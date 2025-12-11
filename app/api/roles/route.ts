import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Crear rol
export async function POST(req: Request) {
  const { tipo } = await req.json();

  try {
    const result = await pool.query(
      "SELECT crear_rol($1) AS respuesta",
      [tipo]
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

// ✅ Consultar todos los roles
export async function GET() {
  try {
    const result = await pool.query(
      "SELECT consultar_roles() AS respuesta"
    );

    const respuesta = result.rows[0].respuesta;

    // Si la respuesta tiene status y roles, devolverla tal cual
    if (respuesta && respuesta.status === "success" && respuesta.roles) {
      return NextResponse.json(respuesta, { status: 200 });
    }

    // Si la respuesta tiene status pero los roles están en otro campo
    if (respuesta && respuesta.status === "success") {
      const roles = respuesta.data || respuesta.resultado || respuesta.roles || [];
      return NextResponse.json({
        status: "success",
        roles: Array.isArray(roles) ? roles : []
      }, { status: 200 });
    }

    // Si la respuesta es directamente un array
    if (Array.isArray(respuesta)) {
      return NextResponse.json({
        status: "success",
        roles: respuesta
      }, { status: 200 });
    }

    // Si no hay respuesta o es un error
    console.error("Estructura de respuesta inesperada:", respuesta);
    return NextResponse.json(
      { status: "error", message: "Estructura de respuesta inesperada", data: respuesta },
      { status: 500 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/roles:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

// ✅ Actualizar rol
export async function PUT(req: Request) {
  const { id, tipo } = await req.json();

  try {
    const result = await pool.query(
      "SELECT actualizar_rol($1, $2) AS respuesta",
      [id, tipo]
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

// ✅ Eliminar rol
export async function DELETE(req: Request) {
  const { id } = await req.json();

  try {
    const result = await pool.query(
      "SELECT eliminar_rol($1) AS respuesta",
      [id]
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}