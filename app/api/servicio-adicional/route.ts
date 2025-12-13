import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ LISTAR TODOS LOS SERVICIOS ADICIONALES
export async function GET() {
  try {
    const query = `
      SELECT 
        sa_cod,
        sa_tipo,
        sa_nombre,
        sa_descripcion,
        operador_turistico_pro_cod,
        sa_costo,
        sa_cant_milla,
        sa_fecha_hora_inicio,
        sa_fecha_hora_fin
      FROM servicio_adicional
      ORDER BY sa_cod ASC;
    `;

    const result = await pool.query(query);

    return NextResponse.json(
      { status: "success", data: result.rows },
      { status: 200 }
    );

  } catch (error) {
    console.error("❌ Error en GET /api/servicio-adicional:", error);
    return NextResponse.json(
      { status: "error", message: "Error al obtener servicios adicionales" },
      { status: 500 }
    );
  }
}

// ✅ OBTENER UN SERVICIO ADICIONAL POR ID (usa tu función JSON)
export async function POST(req: Request) {
  try {
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Debe proporcionar un ID de servicio adicional" },
        { status: 400 }
      );
    }

    const query = `
      SELECT mostrar_servicio_adicional($1) AS data;
    `;

    const result = await pool.query(query, [id]);

    const data = result.rows[0]?.data;

    if (!data) {
      return NextResponse.json(
        { status: "error", message: "Servicio adicional no encontrado" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { status: "success", data },
      { status: 200 }
    );

  } catch (error) {
    console.error("❌ Error en POST /api/servicio-adicional:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}