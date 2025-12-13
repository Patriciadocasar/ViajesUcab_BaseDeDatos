// app/api/aerolinea/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";


// ✅ CREAR AEROLÍNEA
export async function POST(req: Request) {
  try {
    const body = await req.json();
    const { nombre, direccion, telefono, correo, fechaFundacion, lugarId } = body;

    console.log("=== POST /api/aerolinea ===");
    console.log("Body recibido completo:", JSON.stringify(body, null, 2));
    console.log("lugarId extraído:", lugarId, "Tipo:", typeof lugarId);
    console.log("Validaciones:");
    console.log("  - lugarId es undefined?", lugarId === undefined);
    console.log("  - lugarId es null?", lugarId === null);
    console.log("  - lugarId es número?", typeof lugarId === 'number');

    // Validar que lugarId exista
    if (!lugarId || isNaN(Number(lugarId))) {
      console.error("❌ lugarId inválido:", lugarId);
      return NextResponse.json(
        { status: "error", message: "Debe seleccionar un país válido" },
        { status: 400 }
      );
    }

    const lugarIdFinal = Number(lugarId);
    console.log("lugarId final a insertar:", lugarIdFinal);

    const parametros = [nombre, direccion, telefono, correo, fechaFundacion, lugarIdFinal];
    console.log("Parámetros para INSERT:", parametros);

    const result = await pool.query(
      `INSERT INTO Aerolinea 
        (Pro_Nombre, Pro_Direccion, Pro_Telefono, Pro_Correo, A_Fecha_Fundacion, Lugar_Lug_COD)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING Pro_COD, Lugar_Lug_COD`,
      parametros
    );

    console.log("✅ Inserción exitosa:", result.rows[0]);

    return NextResponse.json(
      {
        status: "success",
        message: "Aerolínea creada correctamente",
        data: result.rows[0],
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en POST /api/aerolinea:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error interno del servidor" },
      { status: 500 }
    );
  }
}



// ✅ LISTAR TODAS LAS AEROLÍNEAS (GET corregido)
export async function GET() {
  try {
    const result = await pool.query(`
      SELECT json_agg(row_to_json(a)) AS data
      FROM (
        SELECT *
        FROM Aerolinea
        ORDER BY Pro_COD ASC
      ) a
    `);

    const data = result.rows[0].data;

    console.log("Fila cruda:", data?.[0]); // ✅ Aquí verás lugar_lug_cod

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de aerolíneas",
        data: data || [],
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/aerolinea:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}



// ✅ ACTUALIZAR AEROLÍNEA
export async function PUT(req: Request) {
  try {
    const body = await req.json();
    const {
      id,
      nombre,
      direccion,
      telefono,
      correo,
      fechaFundacion,
      lugarId,
    } = body;

    console.log("=== PUT /api/aerolinea ===");
    console.log("Body recibido completo:", JSON.stringify(body, null, 2));
    console.log("lugarId extraído:", lugarId, "Tipo:", typeof lugarId);

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Falta el ID de la aerolínea" },
        { status: 400 }
      );
    }

    // Validar que lugarId exista
    if (!lugarId || isNaN(Number(lugarId))) {
      console.error("❌ lugarId inválido:", lugarId);
      return NextResponse.json(
        { status: "error", message: "Debe seleccionar un país válido" },
        { status: 400 }
      );
    }

    const lugarIdFinal = Number(lugarId);
    const parametros = [id, nombre, direccion, telefono, correo, fechaFundacion, lugarIdFinal];
    console.log("Parámetros para actualizar_aerolinea:", parametros);

    const result = await pool.query(
      "SELECT actualizar_aerolinea($1,$2,$3,$4,$5,$6,$7) AS respuesta",
      parametros
    );

    const respuesta = result.rows[0].respuesta;
    
    console.log("✅ Respuesta de actualizar_aerolinea:", respuesta);

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error("Error en PUT /api/aerolinea:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error interno del servidor" },
      { status: 500 }
    );
  }
}



// ✅ ELIMINAR AEROLÍNEA
export async function DELETE(req: Request) {
  try {
    const { id } = await req.json();

    console.log("=== DELETE /api/aerolinea ===");
    console.log("ID recibido:", id);

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Falta el ID de la aerolínea" },
        { status: 400 }
      );
    }

    const result = await pool.query(
      "SELECT eliminar_aerolinea($1) AS respuesta",
      [id]
    );

    const respuesta = result.rows[0].respuesta;
    
    console.log("✅ Respuesta de eliminar_aerolinea:", respuesta);

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error("Error en DELETE /api/aerolinea:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}