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
      tipo,
      restricciones // Array de restricciones agregadas
    } = await req.json();

    // Si el paquete es especial, debe tener al menos una restricción
    let restriccion_tipo = null;
    let restriccion_descripcion = null;

    if (tipo?.toLowerCase() === 'especial' && restricciones && restricciones.length > 0) {
      // Tomar la primera restricción agregada
      const primeraRestriccion = restricciones[0];
      restriccion_tipo = primeraRestriccion.tipo;
      restriccion_descripcion = primeraRestriccion.descripcion;
    }

    const query = `
      SELECT insertar_paquete_turistico($1,$2,$3,$4,$5,$6,$7,$8) AS data;
    `;

    const values = [
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo,
      restriccion_tipo,
      restriccion_descripcion
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

    // Si id es 0 o null, obtener todos los paquetes usando función SQL
    if (!id || id === "0") {
      const query = `SELECT listar_paquetes_turisticos() AS resultado`;
      const result = await pool.query(query);
      return NextResponse.json(result.rows[0].resultado);
    }

    // Si tiene un ID específico, usar la función
    const query = `SELECT consultar_paquete_turistico($1) AS data`;
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
      tipo,
      restricciones // Array de restricciones agregadas
    } = await req.json();

    // Si el paquete es especial, debe tener al menos una restricción
    let restriccion_tipo = null;
    let restriccion_descripcion = null;

    if (tipo?.toLowerCase() === 'especial' && restricciones && restricciones.length > 0) {
      // Tomar la primera restricción agregada
      const primeraRestriccion = restricciones[0];
      restriccion_tipo = primeraRestriccion.tipo;
      restriccion_descripcion = primeraRestriccion.descripcion;
    }

    const query = `
      SELECT actualizar_paquete_turistico($1,$2,$3,$4,$5,$6,$7,$8,$9) AS data;
    `;

    const values = [
      id,
      nombre,
      descripcion,
      costo,
      costo_millas,
      cant_milla,
      tipo,
      restriccion_tipo,
      restriccion_descripcion
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