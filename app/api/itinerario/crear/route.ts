import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/itinerario/crear
 * Crea una nueva reserva con itinerario(s)
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/itinerario/crear ===");
    const body = await request.json();

    const {
      cliente_id,
      camarote = null,
      paquete_turistico_ids = null,
      hospedaje_ids = null,
      restaurante_ids = null,
      vuelo_ids = null,
      crucero_ids = null,
      transporte_terrestre_ids = null,
      servicio_adicional_ids = null,
      fechas_inicio = null,
      fechas_fin = null,
    } = body;

    console.log("📋 Datos recibidos:", {
      cliente_id,
      camarote,
      vuelo_ids,
      hospedaje_ids,
      servicio_adicional_ids,
      fechas_inicio,
      fechas_fin,
    });

    // Validaciones básicas
    if (!cliente_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "El cliente_id es requerido",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT crear_itinerario_con_reserva(
        $1::INTEGER,
        $2::VARCHAR,
        $3::INTEGER[],
        $4::INTEGER[],
        $5::INTEGER[],
        $6::INTEGER[],
        $7::INTEGER[],
        $8::INTEGER[],
        $9::INTEGER[],
        $10::DATE[],
        $11::DATE[]
      ) as resultado
    `;

    const values = [
      cliente_id,
      camarote,
      paquete_turistico_ids,
      hospedaje_ids,
      restaurante_ids,
      vuelo_ids,
      crucero_ids,
      transporte_terrestre_ids,
      servicio_adicional_ids,
      fechas_inicio,
      fechas_fin,
    ];

    console.log("🔍 Ejecutando función SQL...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al crear itinerario:", error);
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
 * GET /api/itinerario/crear
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/itinerario/crear",
    method: "POST",
    description: "Crea una nueva reserva con itinerario(s)",
    parametros: {
      cliente_id: "INTEGER (requerido)",
      camarote: "VARCHAR (opcional)",
      paquete_turistico_ids: "INTEGER[] (opcional)",
      hospedaje_ids: "INTEGER[] (opcional)",
      restaurante_ids: "INTEGER[] (opcional)",
      vuelo_ids: "INTEGER[] (opcional)",
      crucero_ids: "INTEGER[] (opcional)",
      transporte_terrestre_ids: "INTEGER[] (opcional)",
      servicio_adicional_ids: "INTEGER[] (opcional)",
      fechas_inicio: "DATE[] (opcional)",
      fechas_fin: "DATE[] (opcional)",
    },
    ejemplo: {
      cliente_id: 1,
      vuelo_ids: [1],
      hospedaje_ids: [2],
      fechas_inicio: ["2024-07-15"],
      fechas_fin: ["2024-07-22"],
    },
  });
}

