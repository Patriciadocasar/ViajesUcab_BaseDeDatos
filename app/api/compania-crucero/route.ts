import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Consultar todas las compañías de crucero
export async function GET() {
  try {
    const columnResult = await pool.query(
      "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'compania_crucero' OR table_name = 'Compania_Crucero' ORDER BY ordinal_position"
    );
    console.log("Columnas de la tabla Compania_Crucero:", columnResult.rows);

    const result = await pool.query(
      "SELECT json_agg(row_to_json(c)) AS data FROM Compania_Crucero c"
    );

    const data = result.rows[0]?.data || [];
    console.log("Datos devueltos por la consulta (primer elemento):", data && data.length > 0 ? JSON.stringify(data[0], null, 2) : "No hay datos");

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de compañías de crucero",
        data: data
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/compania-crucero:", error);
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