import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Consultar todos los hoteles
export async function GET() {
  try {
    const columnResult = await pool.query(
      "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'hotel' OR table_name = 'Hotel' ORDER BY ordinal_position"
    );
    console.log("Columnas de la tabla Hotel:", columnResult.rows);

    const result = await pool.query(`
      SELECT json_agg(row_to_json(h)) AS data
      FROM (
        SELECT *
        FROM Hotel
        ORDER BY pro_cod ASC
      ) h
    `);

    const data = result.rows[0]?.data || [];
    console.log("Datos devueltos por la consulta (primer elemento):", data && data.length > 0 ? JSON.stringify(data[0], null, 2) : "No hay datos");

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de hoteles",
        data: data
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/hotel:", error);
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