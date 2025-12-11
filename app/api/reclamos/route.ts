import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Consultar todos los reclamos
export async function GET() {
  try {
    // Primero obtener los nombres de las columnas para debug
    const columnResult = await pool.query(
      "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'reclamo' OR table_name = 'Reclamo' ORDER BY ordinal_position"
    );
    console.log("Columnas de la tabla Reclamo:", columnResult.rows);

    // Consultar todos los datos - usar subconsulta para ordenar antes de agregar
    let result;
    try {
      result = await pool.query(
        `SELECT json_agg(row_to_json(r)) AS data 
         FROM (
           SELECT * FROM Reclamo ORDER BY Rec_COD ASC
         ) r`
      );
    } catch (e: any) {
      // Si falla, intentar con minúsculas
      console.log("Intentando con tabla en minúsculas...");
      result = await pool.query(
        `SELECT json_agg(row_to_json(r)) AS data 
         FROM (
           SELECT * FROM reclamo ORDER BY rec_cod ASC
         ) r`
      );
    }

    const data = result.rows[0]?.data || [];
    console.log("Datos devueltos por la consulta (primer elemento):", data && data.length > 0 ? JSON.stringify(data[0], null, 2) : "No hay datos");

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de reclamos",
        data: data
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/reclamos:", error);
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