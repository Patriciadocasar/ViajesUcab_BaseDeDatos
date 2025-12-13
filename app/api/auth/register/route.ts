// app/api/register/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  const {
    U_Correo,
    U_Contrasena,
    U_Primer_Nombre,
    U_Primer_Apellido,
    role,
    C_Primer_Nombre,
    C_Segundo_Nombre,
    C_Apellido,
    C_Segundo_Apellido,
    C_Fecha_Nacimiento,
    C_Estado_Civil,
    C_Lugar_ID,
  } = await req.json();

  try {
    const U_Rol_ID = typeof role === "number" ? role : mapRole(role);

    const result = await pool.query(
      `SELECT registrar_usuario_cliente(
        $1, $2, $3, $4, $5,
        $6, $7, $8, $9, $10, $11, $12
      ) AS respuesta`,
      [
        U_Correo,
        U_Contrasena,
        U_Primer_Nombre,
        U_Primer_Apellido,
        U_Rol_ID,
        C_Primer_Nombre,
        C_Segundo_Nombre,
        C_Apellido,
        C_Segundo_Apellido,
        C_Fecha_Nacimiento,
        C_Estado_Civil,
        C_Lugar_ID,
      ]
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 201 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

function mapRole(role: string): number {
  switch (role) {
    case "admin":
      return 1;
    case "proveedor":
      return 2;
    default:
      return 3; // cliente
  }
}