import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/reserva/cancelar
 * Cancela una reserva y genera un reembolso
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/reserva/cancelar ===");
    const body = await request.json();

    const {
      reserva_id,
      porcentaje_retencion = 10.0,
      metodo_pago_reembolso_id,
      tasa_cambio_id = null,
    } = body;

    console.log("❌ Cancelando reserva:", {
      reserva_id,
      porcentaje_retencion,
      metodo_pago_reembolso_id,
    });

    // Validaciones básicas
    if (!reserva_id || !metodo_pago_reembolso_id) {
      return NextResponse.json(
        {
          status: "error",
          message:
            "Los campos reserva_id y metodo_pago_reembolso_id son requeridos",
        },
        { status: 400 }
      );
    }

    // Validar porcentaje de retención
    if (porcentaje_retencion < 0 || porcentaje_retencion > 100) {
      return NextResponse.json(
        {
          status: "error",
          message: "El porcentaje de retención debe estar entre 0 y 100",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT cancelar_reserva_con_reembolso(
        $1::INTEGER,
        $2::NUMERIC,
        $3::INTEGER,
        $4::INTEGER
      ) as resultado
    `;

    const values = [
      reserva_id,
      porcentaje_retencion,
      metodo_pago_reembolso_id,
      tasa_cambio_id,
    ];

    console.log("🔍 Procesando cancelación...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Cancelación procesada:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 200 });
  } catch (error: any) {
    console.error("❌ Error al cancelar reserva:", error);
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
 * GET /api/reserva/cancelar
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/reserva/cancelar",
    method: "POST",
    description: "Cancela una reserva y genera un reembolso",
    parametros: {
      reserva_id: "INTEGER (requerido)",
      porcentaje_retencion:
        "NUMERIC (opcional, default: 10.0) - Porcentaje entre 0 y 100",
      metodo_pago_reembolso_id:
        "INTEGER (requerido) - ID del método de pago para reembolso",
      tasa_cambio_id: "INTEGER (opcional)",
    },
    ejemplo: {
      reserva_id: 5,
      porcentaje_retencion: 10.0,
      metodo_pago_reembolso_id: 3,
    },
  });
}

