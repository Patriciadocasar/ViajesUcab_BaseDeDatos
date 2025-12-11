import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Registrar promoción
export async function POST(req: Request) {
  try {
    const { tipo, fechaInicio, fechaFin, porcentaje } = await req.json();

    console.log("Intentando insertar promoción:", { tipo, fechaInicio, fechaFin, porcentaje });

    const result = await pool.query(
      "SELECT registrar_promocion($1, $2, $3, $4) AS respuesta",
      [tipo, fechaInicio, fechaFin, porcentaje]
    );

    const respuesta = result.rows[0].respuesta;
    console.log("Respuesta de registrar_promocion:", respuesta);

    if (respuesta.status === "error") {
      return NextResponse.json(
        {
          status: "error",
          message: respuesta.message || "Error al insertar la promoción"
        },
        { status: 400 }
      );
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error("Error en POST /api/promocion:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
        details: process.env.NODE_ENV === "development" ? error.stack : undefined
      },
      { status: 500 }
    );
  }
}

// ✅ Consultar todas las promociones
export async function GET() {
  try {
    // Primero obtener los nombres de las columnas para debug
    const columnResult = await pool.query(
      "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'promocion' ORDER BY ordinal_position"
    );
    console.log("Columnas de la tabla Promocion:", columnResult.rows);

    // Consultar todos los datos - row_to_json devuelve los nombres exactos de las columnas
    const result = await pool.query(
      "SELECT json_agg(row_to_json(p)) AS data FROM Promocion p"
    );

    const data = result.rows[0]?.data || [];
    console.log("Datos devueltos por la consulta (primer elemento):", data && data.length > 0 ? JSON.stringify(data[0], null, 2) : "No hay datos");

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de promociones",
        data: data
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/promocion:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: error.message || "Error interno del servidor",
        details: process.env.NODE_ENV === "development" ? error.stack : undefined
      },
      { status: 500 }
    );
  }
}