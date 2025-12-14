import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

/**
 * POST /api/metodo-pago/registrar
 * Registra un nuevo método de pago (tarjeta)
 */
export async function POST(request: Request) {
  try {
    console.log("=== POST /api/metodo-pago/registrar ===");
    const body = await request.json();

    const {
      tipo, // 'Tarjeta_Credito' o 'Tarjeta_Debito'
      num_tarjeta,
      cod_seguridad,
      emisor,
      marca,
      fecha_vencimiento,
      nombre_titular,
    } = body;

    console.log("💳 Registrando método de pago:", {
      tipo,
      marca,
      emisor,
      nombre_titular,
    });

    // Validaciones básicas
    if (
      !tipo ||
      !num_tarjeta ||
      !cod_seguridad ||
      !emisor ||
      !marca ||
      !fecha_vencimiento ||
      !nombre_titular
    ) {
      return NextResponse.json(
        {
          status: "error",
          message: "Todos los campos son requeridos",
        },
        { status: 400 }
      );
    }

    // Validar tipo
    if (!["Tarjeta_Credito", "Tarjeta_Debito"].includes(tipo)) {
      return NextResponse.json(
        {
          status: "error",
          message: "El tipo debe ser Tarjeta_Credito o Tarjeta_Debito",
        },
        { status: 400 }
      );
    }

    // Llamar a la función SQL
    const query = `
      SELECT registrar_metodo_pago_tarjeta(
        $1::VARCHAR,
        $2::NUMERIC,
        $3::NUMERIC,
        $4::VARCHAR,
        $5::VARCHAR,
        $6::DATE,
        $7::VARCHAR
      ) as resultado
    `;

    const values = [
      tipo,
      num_tarjeta,
      cod_seguridad,
      emisor,
      marca,
      fecha_vencimiento,
      nombre_titular,
    ];

    console.log("🔍 Registrando tarjeta...");
    const result = await pool.query(query, values);
    const response = result.rows[0].resultado;

    console.log("✅ Tarjeta registrada:", response);

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
 * GET /api/metodo-pago/registrar
 * Retorna información sobre el endpoint
 */
export async function GET() {
  return NextResponse.json({
    endpoint: "/api/metodo-pago/registrar",
    method: "POST",
    description: "Registra un nuevo método de pago (tarjeta)",
    parametros: {
      tipo: "VARCHAR (requerido) - 'Tarjeta_Credito' o 'Tarjeta_Debito'",
      num_tarjeta: "NUMERIC (requerido) - 16 dígitos",
      cod_seguridad: "NUMERIC (requerido) - 3-4 dígitos",
      emisor: "VARCHAR (requerido) - Banco emisor",
      marca: "VARCHAR (requerido) - Visa, Mastercard, etc.",
      fecha_vencimiento: "DATE (requerido) - Formato YYYY-MM-DD",
      nombre_titular: "VARCHAR (requerido) - Nombre en la tarjeta",
    },
    ejemplo: {
      tipo: "Tarjeta_Credito",
      num_tarjeta: 4111111111111111,
      cod_seguridad: 123,
      emisor: "Banco de Venezuela",
      marca: "Visa",
      fecha_vencimiento: "2027-12-31",
      nombre_titular: "Juan Perez",
    },
  });
}

