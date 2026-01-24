import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// GET - Listar todos los reclamos (para admin)
export async function GET(request: Request) {
  try {
    console.log("=== GET /api/reclamos ===");
    console.log("Obteniendo lista de reclamos para administrador...");

    const query = `
      SELECT sp_mostrar_reclamos_admin() as resultado
    `;

    const result = await pool.query(query);
    const response = result.rows[0].resultado;

    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al listar reclamos:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

// POST - Registrar un reclamo
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { itinerario_id, descripcion } = body;

    console.log("=== POST /api/reclamos ===");
    console.log("Datos recibidos:", { itinerario_id, descripcion });

    // Validar datos requeridos
    if (!itinerario_id || !descripcion) {
      return NextResponse.json(
        {
          status: "error",
          message: "itinerario_id y descripcion son requeridos",
        },
        { status: 400 }
      );
    }

    // Validar que el itinerario_id no sea un timestamp temporal del frontend
    const MAX_INTEGER = 2147483647; // Límite de INTEGER en PostgreSQL
    if (itinerario_id > MAX_INTEGER) {
      return NextResponse.json(
        {
          status: "error",
          message: "Este itinerario aún no está sincronizado con la base de datos. Por favor espera unos momentos y recarga la página.",
        },
        { status: 400 }
      );
    }

    // Llamar al procedimiento almacenado
    const query = `
      SELECT sp_registrar_reclamo_json($1::INTEGER, $2::TEXT) as resultado
    `;

    console.log("🔍 Registrando reclamo...");
    const result = await pool.query(query, [itinerario_id, descripcion]);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al registrar reclamo:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

// PUT - Actualizar estado de un reclamo a "Listo"
export async function PUT(request: Request) {
  try {
    const body = await request.json();
    const { registro_id, fecha_fin } = body;

    console.log("=== PUT /api/reclamos ===");
    console.log("Datos recibidos:", { registro_id, fecha_fin });

    // Validar datos requeridos
    if (!registro_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "registro_id es requerido",
        },
        { status: 400 }
      );
    }

    // Llamar al procedimiento almacenado
    const query = fecha_fin
      ? `SELECT sp_actualizar_estado_reclamo_json($1::INTEGER, $2::DATE) as resultado`
      : `SELECT sp_actualizar_estado_reclamo_json($1::INTEGER) as resultado`;

    const params = fecha_fin ? [registro_id, fecha_fin] : [registro_id];

    console.log("🔍 Actualizando estado del reclamo...");
    const result = await pool.query(query, params);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al actualizar estado del reclamo:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}
