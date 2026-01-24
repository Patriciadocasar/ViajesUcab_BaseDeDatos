import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ INSERTAR RESTRICCIÓN DE PAQUETE
export async function POST(req: Request) {
  try {
    const { tipo, descripcion, paquete_id } = await req.json();

    const query = `SELECT insertar_restriccion_paquete($1, $2, $3) AS data`;
    const values = [tipo, descripcion, paquete_id];
    const result = await pool.query(query, values);

    return NextResponse.json(result.rows[0].data);
  } catch (error) {
    console.error("❌ Error INSERT restricción:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno" },
      { status: 500 }
    );
  }
}

// ✅ CONSULTAR RESTRICCIONES DE UN PAQUETE
export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const paquete_id = searchParams.get("paquete_id");

    if (!paquete_id) {
      return NextResponse.json(
        { status: "error", message: "ID de paquete requerido" },
        { status: 400 }
      );
    }

    const query = `SELECT consultar_restricciones_paquete($1) AS data`;
    const result = await pool.query(query, [paquete_id]);

    return NextResponse.json(result.rows[0].data);
  } catch (error) {
    console.error("❌ Error CONSULTAR restricciones:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno" },
      { status: 500 }
    );
  }
}

// ✅ ACTUALIZAR RESTRICCIÓN DE PAQUETE
export async function PUT(req: Request) {
  try {
    const { id, tipo, descripcion } = await req.json();

    const query = `SELECT actualizar_restriccion_paquete($1, $2, $3) AS data`;
    const values = [id, tipo, descripcion];
    const result = await pool.query(query, values);

    return NextResponse.json(result.rows[0].data);
  } catch (error) {
    console.error("❌ Error ACTUALIZAR restricción:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno" },
      { status: 500 }
    );
  }
}

// ✅ ELIMINAR RESTRICCIÓN DE PAQUETE
export async function DELETE(req: Request) {
  try {
    const { id } = await req.json();

    const query = `SELECT eliminar_restriccion_paquete($1) AS data`;
    const result = await pool.query(query, [id]);

    return NextResponse.json(result.rows[0].data);
  } catch (error) {
    console.error("❌ Error ELIMINAR restricción:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno" },
      { status: 500 }
    );
  }
}






