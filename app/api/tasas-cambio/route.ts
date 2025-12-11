// app/api/tasas-cambio/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// GET: listar todas las tasas
export async function GET() {
  try {
    const result = await pool.query("SELECT obtener_tasas_cambio() AS respuesta");
    const respuesta = result.rows[0].respuesta;
    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json({ status: "error", message: "Error interno del servidor" }, { status: 500 });
  }
}

// POST: crear nueva tasa
export async function POST(req: Request) {
  try {
    const { TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD } = await req.json();

    const result = await pool.query(
      "SELECT crear_tasa_cambio($1, $2, $3, $4, $5, $6) AS respuesta",
      [TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD]
    );

    const respuesta = result.rows[0].respuesta;
    return NextResponse.json(respuesta, { status: 201 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json({ status: "error", message: "Error interno del servidor" }, { status: 500 });
  }
}

// PUT: actualizar tasa existente
export async function PUT(req: Request) {
  try {
    const { TC_COD, TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD } = await req.json();

    const result = await pool.query(
      "SELECT actualizar_tasa_cambio($1, $2, $3, $4, $5, $6, $7) AS respuesta",
      [TC_COD, TC_Tipo_Moneda, TC_Valor, TC_Cant_Milla, TC_Fecha_Actualizacion, TC_Fecha_Final, Lugar_Lug_COD]
    );

    const respuesta = result.rows[0].respuesta;
    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json({ status: "error", message: "Error interno del servidor" }, { status: 500 });
  }
}

// DELETE: eliminar tasa
export async function DELETE(req: Request) {
  try {
    const { TC_COD } = await req.json();

    const result = await pool.query(
      "SELECT eliminar_tasa_cambio($1) AS respuesta",
      [TC_COD]
    );

    const respuesta = result.rows[0].respuesta;
    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error(error);
    return NextResponse.json({ status: "error", message: "Error interno del servidor" }, { status: 500 });
  }
}