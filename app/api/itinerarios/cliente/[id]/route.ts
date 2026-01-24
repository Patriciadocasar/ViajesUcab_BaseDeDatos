import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const clienteId = parseInt(params.id);
    console.log(`=== GET /api/itinerarios/cliente/${clienteId} ===`);

    // Validar que el ID sea un número válido
    if (isNaN(clienteId)) {
      return NextResponse.json(
        {
          status: "error",
          message: "ID de cliente inválido",
        },
        { status: 400 }
      );
    }

    // Llamado de la funcion
    const query = `
      SELECT obtener_itinerarios_cliente($1::INTEGER) as resultado
    `;

    console.log("🔍 Obteniendo itinerarios del cliente...");
    const result = await pool.query(query, [clienteId]);
    const response = result.rows[0].resultado;

    console.log("✅ Itinerarios obtenidos:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 404 });
    }


    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al obtener itinerarios del cliente:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

