import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/metodo-pago/registrar-universal
 * Registra cualquier tipo de método de pago
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/metodo-pago/registrar-universal ===");
    const body = await request.json();

    const { tipo, cliente_id, datos } = body;

    console.log("📋 Datos recibidos:", {
      tipo,
      cliente_id,
      datos: Object.keys(datos || {}),
    });

    // Validaciones
    const tiposValidos = [
      'Tarjeta_Credito',
      'Tarjeta_Debito',
      'Cheque',
      'Efectivo',
      'Milla_MP',
      'Criptomonedas',
      'Billetera_Digital',
      'Zelle',
      'PayPal',
      'Zinli',
      'Pago_Movil',
      'Transferencia'
    ];

    if (!tipo || !tiposValidos.includes(tipo)) {
      return NextResponse.json(
        {
          status: "error",
          message: `Tipo de método de pago no válido. Tipos permitidos: ${tiposValidos.join(', ')}`,
        },
        { status: 400 }
      );
    }

    if (!cliente_id) {
      return NextResponse.json(
        {
          status: "error",
          message: "El cliente_id es requerido",
        },
        { status: 400 }
      );
    }

    if (!datos) {
      return NextResponse.json(
        {
          status: "error",
          message: "Los datos del método de pago son requeridos",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT registrar_metodo_pago(
        $1::VARCHAR,
        $2::INTEGER,
        $3::JSONB
      ) as resultado
    `;

    const values = [tipo, cliente_id, JSON.stringify(datos)];

    console.log("🔍 Ejecutando función SQL...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Resultado:", response);

    if (response.status === "error") {
      return NextResponse.json(response, { status: 400 });
    }

    return NextResponse.json(response, { status: 201 });
  } catch (error: any) {
    console.error("❌ Error al registrar método de pago:", error);
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
 * GET /api/metodo-pago/registrar-universal
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/metodo-pago/registrar-universal",
    method: "POST",
    description: "Registra cualquier tipo de método de pago",
    parametros: {
      tipo: "VARCHAR (requerido) - Tipo de método de pago",
      cliente_id: "INTEGER (requerido) - ID del cliente",
      datos: "JSONB (requerido) - Datos específicos del método",
    },
    tipos_soportados: [
      "Tarjeta_Credito",
      "Tarjeta_Debito",
      "Cheque",
      "Efectivo",
      "Milla_MP",
      "Criptomonedas",
      "Billetera_Digital",
      "Zelle",
      "PayPal",
      "Zinli",
      "Pago_Movil",
      "Transferencia",
    ],
    ejemplos: {
      tarjeta: {
        tipo: "Tarjeta_Credito",
        cliente_id: 51,
        datos: {
          numTarjeta: "4111111111111111",
          codSeguridad: "123",
          emisor: "Banco XYZ",
          marca: "Visa",
          fechaVencimiento: "2026-12-31",
          nombreTitular: "JUAN PEREZ",
        },
      },
      pago_movil: {
        tipo: "Pago_Movil",
        cliente_id: 51,
        datos: {
          numReferencia: "123456789012345",
          banco: "Banco Provincial",
          fecha: "2024-12-14",
        },
      },
      zelle: {
        tipo: "Zelle",
        cliente_id: 51,
        datos: {
          numCuentaDestino: "1234567890",
          banco: "Bank of America",
          fecha: "2024-12-14",
          numReferencia: "987654321",
        },
      },
    },
  });
}

