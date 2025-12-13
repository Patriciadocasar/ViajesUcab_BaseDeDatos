// app/api/listas-desplegables/paises/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    // Consultar directamente los lugares de tipo 'Pais'
    const result = await pool.query(`
      SELECT 
        Lug_COD as lug_cod,
        Lug_Nombre as lug_nombre,
        Lug_Tipo as lug_tipo
      FROM Lugar
      WHERE Lug_Tipo = 'Pais'
      ORDER BY Lug_Nombre ASC
    `);

    console.log("Países encontrados:", result.rows.length);

    if (!result.rows || result.rows.length === 0) {
      return NextResponse.json(
        { status: "error", message: "No se encontraron países" },
        { status: 404 }
      );
    }

    return NextResponse.json({
      status: "success",
      message: "Listado de países",
      data: result.rows
    }, { status: 200 });
  } catch (error: any) {
    console.error("Error en GET /api/listas-desplegables/paises:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error interno del servidor" },
      { status: 500 }
    );
  }
}
