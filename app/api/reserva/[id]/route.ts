import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * GET /api/reserva/[id]
 * Obtiene el detalle completo de una reserva
 */
export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const reservaId = parseInt(params.id);
    console.log(`=== GET /api/reserva/${reservaId} ===`);

    if (isNaN(reservaId)) {
      return NextResponse.json(
        {
          status: "error",
          message: "ID de reserva inválido",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT obtener_detalle_reserva($1::INTEGER) as resultado
    `;

    console.log("🔍 Obteniendo detalle de reserva...");
    const result = await pool.query(query, [reservaId]);
    const response = result.rows[0].resultado;

    console.log("✅ Detalle obtenido:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 404 });
    }

    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al obtener detalle de reserva:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

