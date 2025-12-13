import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ LISTAR TODOS LOS RESTAURANTES
export async function GET() {
  try {
    const query = `
      SELECT 
        rest_cod,
        rest_nombre,
        rest_direccion,
        rest_clasificacion,
        lugar_lug_cod,
        rest_tipo_comida,
        rest_ambiente
      FROM restaurante
      ORDER BY rest_cod ASC;
    `;

    const result = await pool.query(query);

    return NextResponse.json(
      { status: "success", data: result.rows },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en GET /api/restaurante:", error);
    return NextResponse.json(
      { status: "error", message: "Error al obtener restaurantes" },
      { status: 500 }
    );
  }
}

// ✅ OBTENER UN RESTAURANTE POR ID (usa tu función mostrar_restaurante)
export async function POST(req: Request) {
  try {
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Debe proporcionar un ID de restaurante" },
        { status: 400 }
      );
    }

    const query = `
      SELECT mostrar_restaurante($1) AS data;
    `;

    const result = await pool.query(query, [id]);

    const data = result.rows[0]?.data;

    if (!data) {
      return NextResponse.json(
        { status: "error", message: "Restaurante no encontrado" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { status: "success", data },
      { status: 200 }
    );

  } catch (error: any) {
    console.error("❌ Error en POST /api/restaurante:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}