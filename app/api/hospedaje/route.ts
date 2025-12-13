import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

export async function GET() {
  try {
    console.log("=== GET /api/hospedaje ===");

    const query = `
      SELECT 
        H.Hos_COD,
        H.Hotel_Pro_COD,
        H.Hos_Fecha_Hora_Inicio,
        H.Hos_Fecha_Hora_Fin,
        H.Hot_Cant_Milla,
        H.Hos_Costo,
        
        -- Nombre del hotel
        (
          SELECT Ho.Pro_Nombre
          FROM Hotel Ho
          WHERE Ho.Pro_COD = H.Hotel_Pro_COD
        ) AS hotel_nombre

      FROM Hospedaje H
      ORDER BY H.Hos_COD ASC
      LIMIT 10
    `;

    const result = await pool.query(query);

    console.log("✅ Columnas de hospedajes:", result.fields.map(f => f.name));
    if (result.rows.length > 0) {
      console.log("✅ Primer hospedaje:", result.rows[0]);
    } else {
      console.log("⚠️ No hay hospedajes en la base de datos");
    }

    return NextResponse.json({
      status: "success",
      data: result.rows,
    }, { status: 200 });

  } catch (error: any) {
    console.error("❌ Error en GET /api/hospedaje:", error);
    console.error("Código:", error.code);
    console.error("Mensaje:", error.message);

    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error al obtener hospedajes" 
      },
      { status: 500 }
    );
  }
}