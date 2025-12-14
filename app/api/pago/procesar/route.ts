import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/pago/procesar
 * Procesa el pago de una reserva
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/pago/procesar ===");
    const body = await request.json();

    const {
      reserva_id,
      cliente_id,
      metodo_pago_id,
      monto_pago,
      pago_con_millas = false,
      cantidad_millas = 0,
      tasa_cambio_id = null,
      usar_financiamiento = false,
      numero_cuotas = null,
      monto_financiado = null,
    } = body;

    console.log("💳 Datos de pago:", {
      reserva_id,
      cliente_id,
      metodo_pago_id,
      monto_pago,
      pago_con_millas,
      cantidad_millas,
      usar_financiamiento,
      numero_cuotas,
    });

    // Validaciones básicas
    if (!reserva_id || !cliente_id || !metodo_pago_id || !monto_pago) {
      return NextResponse.json(
        {
          status: "error",
          message:
            "Los campos reserva_id, cliente_id, metodo_pago_id y monto_pago son requeridos",
        },
        { status: 400 }
      );
    }

    // Validar que si usa financiamiento, se especifique número de cuotas
    if (usar_financiamiento && (!numero_cuotas || numero_cuotas <= 0)) {
      return NextResponse.json(
        {
          status: "error",
          message:
            "Si usa financiamiento, debe especificar el número de cuotas",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT procesar_pago_reserva(
        $1::INTEGER,
        $2::INTEGER,
        $3::INTEGER,
        $4::NUMERIC,
        $5::BOOLEAN,
        $6::INTEGER,
        $7::INTEGER,
        $8::BOOLEAN,
        $9::INTEGER,
        $10::NUMERIC
      ) as resultado
    `;

    const values = [
      reserva_id,
      cliente_id,
      metodo_pago_id,
      monto_pago,
      pago_con_millas,
      cantidad_millas,
      tasa_cambio_id,
      usar_financiamiento,
      numero_cuotas,
      monto_financiado,
    ];

    console.log("🔍 Procesando pago...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Pago procesado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al procesar pago:", error);
    return NextResponse.json(
      {
        status: "error",
        message: error.message || "Error interno del servidor",
      },
      { status: 500 }
    );
  }
}

/**
 * GET /api/pago/procesar
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/pago/procesar",
    method: "POST",
    description: "Procesa el pago de una reserva",
    parametros: {
      reserva_id: "INTEGER (requerido)",
      cliente_id: "INTEGER (requerido)",
      metodo_pago_id: "INTEGER (requerido)",
      monto_pago: "NUMERIC (requerido)",
      pago_con_millas: "BOOLEAN (opcional, default: false)",
      cantidad_millas: "INTEGER (opcional, default: 0)",
      tasa_cambio_id: "INTEGER (opcional)",
      usar_financiamiento: "BOOLEAN (opcional, default: false)",
      numero_cuotas: "INTEGER (opcional, requerido si usar_financiamiento)",
      monto_financiado: "NUMERIC (opcional)",
    },
    ejemplo: {
      reserva_id: 1,
      cliente_id: 1,
      metodo_pago_id: 3,
      monto_pago: 1500.0,
      pago_con_millas: false,
      cantidad_millas: 0,
    },
  });
}

