import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ INSERTAR PAQUETE TURÍSTICO
export async function POST(req: Request) {
  try {
    const {
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo
    } = await req.json();

    const query = `
      SELECT insertar_paquete_turistico($1,$2,$3,$4,$5,$6) AS data;
    `;

    const values = [
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo
    ];

    const result = await pool.query(query, values);

    return NextResponse.json(result.rows[0].data);

  } catch (error) {
    console.error("❌ Error INSERT:", error);
    return NextResponse.json({ status: "error", message: "Error interno" }, { status: 500 });
  }
}

// ✅ CONSULTAR PAQUETE TURÍSTICO
export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const id = searchParams.get("id");

    // Si id es 0 o null, obtener todos los paquetes
    if (!id || id === "0") {
      const query = `
        SELECT 
          PT_COD as pt_cod,
          PT_Nombre as pt_nombre,
          PT_Descripcion as pt_descripcion,
          PT_Costo as pt_costo,
          PT_Costo_Millas as pt_costo_millas,
          PT_Cant_Milla as pt_cant_milla,
          PT_Tipo as pt_tipo
        FROM Paquete_Turistico
        ORDER BY PT_COD;
      `;

      const result = await pool.query(query);

      return NextResponse.json({
        status: "success",
        data: result.rows
      });
    }

    // Si tiene un ID específico, usar la función
    const query = `
      SELECT consultar_paquete_turistico($1) AS data;
    `;

    const result = await pool.query(query, [id]);

    return NextResponse.json(result.rows[0].data);

  } catch (error) {
    console.error("❌ Error CONSULTAR:", error);
    return NextResponse.json({ status: "error", message: "Error interno" }, { status: 500 });
  }
}

// ✅ ACTUALIZAR PAQUETE TURÍSTICO
export async function PUT(req: Request) {
  try {
    const {
      id,
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo
    } = await req.json();

    const query = `
      SELECT actualizar_paquete_turistico($1,$2,$3,$4,$5,$6,$7) AS data;
    `;

    const values = [
      id,
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo
    ];

    const result = await pool.query(query, values);

    return NextResponse.json(result.rows[0].data);

  } catch (error) {
    console.error("❌ Error ACTUALIZAR:", error);
    return NextResponse.json({ status: "error", message: "Error interno" }, { status: 500 });
  }
}

// ✅ ELIMINAR PAQUETE TURÍSTICO
export async function DELETE(req: Request) {
  try {
    const { id } = await req.json();

    const query = `
      SELECT eliminar_paquete_turistico($1) AS data;
    `;

    const result = await pool.query(query, [id]);

    return NextResponse.json(result.rows[0].data);

  } catch (error) {
    console.error("❌ Error ELIMINAR:", error);
    return NextResponse.json({ status: "error", message: "Error interno" }, { status: 500 });
  }
}