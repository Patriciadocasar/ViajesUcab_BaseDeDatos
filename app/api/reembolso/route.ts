import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// POST - Registrar reembolso
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { reserva_id, divisa, tasa_aplicada, metodo_pago_id, tasa_cambio_id } = body;

    console.log("=== POST /api/reembolso ===");
    console.log("Datos recibidos:", {
      reserva_id,
      divisa,
      tasa_aplicada,
      metodo_pago_id,
      tasa_cambio_id,
    });

    // Validar datos requeridos
    if (!reserva_id || !divisa || !tasa_aplicada || !metodo_pago_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "Faltan datos requeridos: reserva_id, divisa, tasa_aplicada, metodo_pago_id",
        },
        { status: 400 }
      );
    }


    const query = tasa_cambio_id
      ? `SELECT sp_registrar_reembolso_json($1::INTEGER, $2::TEXT, $3::NUMERIC, $4::INTEGER, $5::INTEGER) as resultado`
      : `SELECT sp_registrar_reembolso_json($1::INTEGER, $2::TEXT, $3::NUMERIC, $4::INTEGER) as resultado`;

    const params = tasa_cambio_id
      ? [reserva_id, divisa, tasa_aplicada, metodo_pago_id, tasa_cambio_id]
      : [reserva_id, divisa, tasa_aplicada, metodo_pago_id];

    console.log("🔍 Procesando reembolso...");
    const result = await pool.query(query, params);

    const response = result.rows[0].resultado;
    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al procesar reembolso:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

