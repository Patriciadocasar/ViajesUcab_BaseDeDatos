// app/api/login/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  const { email, password } = await req.json(); // <-- usa las claves correctas

  try {
    const result = await pool.query(
      "SELECT inicio_sesion($1,$2) as respuesta",
      [email, password] // <-- pasa email y password
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 200 }); // mejor 200 en vez de 201
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}