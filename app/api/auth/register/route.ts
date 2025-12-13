// app/api/register/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  try {
    const body = await req.json();
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
    } = body;

    console.log("=== POST /api/auth/register ===");
    console.log("Body recibido:", JSON.stringify(body, null, 2));

    const U_Rol_ID = typeof role === "number" ? role : mapRole(role);
    console.log("Role recibido:", role, "Tipo:", typeof role);
    console.log("U_Rol_ID calculado:", U_Rol_ID);

    // Asegurar que los valores opcionales sean null y no undefined
    const parametros = [
      U_Correo,
      U_Contrasena,
      U_Primer_Nombre,
      U_Primer_Apellido,
      U_Rol_ID,
      C_Primer_Nombre,
      C_Segundo_Nombre || null,
      C_Apellido,
      C_Segundo_Apellido || null,
      C_Fecha_Nacimiento,
      C_Estado_Civil,
      C_Lugar_ID || null,
    ];

    console.log("Parámetros para registrar_usuario_cliente:");
    parametros.forEach((param, idx) => {
      console.log(`  $${idx + 1}:`, param, `(${typeof param})`);
    });

    const result = await pool.query(
      `SELECT registrar_usuario_cliente(
        $1, $2, $3, $4, $5,
        $6, $7, $8, $9, $10, $11, $12
      ) AS respuesta`,
      parametros
    );

    const respuesta = result.rows[0].respuesta;

    console.log("Respuesta de registrar_usuario_cliente:", respuesta);

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 400 });
    }

    return NextResponse.json(respuesta, { status: 201 });
  } catch (error: any) {
    console.error("Error completo en POST /api/auth/register:", error);
    console.error("Stack trace:", error.stack);
    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error interno del servidor" 
      },
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