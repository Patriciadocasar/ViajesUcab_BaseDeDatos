import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// POST - Registrar financiamiento
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { reserva_id, numero_cuotas } = body;

    console.log("=== POST /api/financiamiento ===");
    console.log("Datos recibidos:", {
      reserva_id,
      numero_cuotas,
    });

    // Validar datos requeridos
    if (!reserva_id || !numero_cuotas) {
      return NextResponse.json(
        {
          status: "error",
          message: "Faltan datos requeridos: reserva_id, numero_cuotas",
        },
        { status: 400 }
      );
    }

    // Llamar a la función con procedimiento almacenado
    const query = `SELECT sp_registrar_financiamiento_json($1::INTEGER, $2::INTEGER) as resultado`;

    console.log("🔍 Registrando financiamiento...");
    const result = await pool.query(query, [reserva_id, numero_cuotas]);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al registrar financiamiento:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}





