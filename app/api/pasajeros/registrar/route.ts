import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/pasajeros/registrar
 * Registra múltiples pasajeros para una reserva
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/pasajeros/registrar ===");
    const body = await request.json();

    const { cliente_id, reserva_id, pasajeros } = body;

    console.log("📋 Datos recibidos:", {
      cliente_id,
      reserva_id,
      cantidad_pasajeros: pasajeros?.length,
    });

    // Validaciones
    if (!cliente_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "El cliente_id es requerido",
        },
        { status: 400 }
      );
    }

    if (!reserva_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "El reserva_id es requerido",
        },
        { status: 400 }
      );
    }

    if (!pasajeros || !Array.isArray(pasajeros) || pasajeros.length === 0) {
      return NextResponse.json(
        {
          status: "error",
          message: "Debe proporcionar al menos un pasajero",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT registrar_pasajeros(
        $1::INTEGER,
        $2::INTEGER,
        $3::JSONB
      ) as resultado
    `;

    const values = [cliente_id, reserva_id, JSON.stringify(pasajeros)];

    console.log("🔍 Ejecutando función SQL...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al registrar pasajeros:", error);
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
 * GET /api/pasajeros/registrar
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/pasajeros/registrar",
    method: "POST",
    description: "Registra múltiples pasajeros para una reserva",
    parametros: {
      cliente_id: "INTEGER (requerido) - ID del cliente",
      reserva_id: "INTEGER (requerido) - ID de la reserva",
      pasajeros: "Array (requerido) - Array de objetos con datos de pasajeros",
    },
    ejemplo: {
      cliente_id: 51,
      reserva_id: 1,
      pasajeros: [
        {
          primerNombre: "Juan",
          segundoNombre: "Carlos",
          primerApellido: "Pérez",
          segundoApellido: "González",
          fechaNacimiento: "1990-05-15",
          estadoCivil: "Casado",
        },
        {
          primerNombre: "María",
          segundoNombre: null,
          primerApellido: "López",
          segundoApellido: "Martínez",
          fechaNacimiento: "1992-08-20",
          estadoCivil: "Casado",
        },
      ],
    },
  });
}

