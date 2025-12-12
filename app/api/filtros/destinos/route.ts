import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// GET: listar todas las tasas
export async function GET() {
    try {
      const result = await pool.query("SELECT obtener_direcciones_filtro() AS respuesta");
      const respuesta = result.rows[0].respuesta;
      return NextResponse.json(
        {
          status: "success",
          message: "Listado de direcciones",
          direcciones: respuesta
        },
        { status: 200 }
      );
    } catch (error: any) {
        console.error("Error en GET /api/filtros/destinos", error);
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