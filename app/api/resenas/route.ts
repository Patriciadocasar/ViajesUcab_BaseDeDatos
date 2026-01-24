import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// POST - Registrar una reseña
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { itinerario_id, descripcion } = body;

    console.log("=== POST /api/resenas ===");
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
      SELECT sp_registrar_resena_json($1::INTEGER, $2::TEXT) as resultado
    `;

    console.log("🔍 Registrando reseña...");
    const result = await pool.query(query, [itinerario_id, descripcion]);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al registrar reseña:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

