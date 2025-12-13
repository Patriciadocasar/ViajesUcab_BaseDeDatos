import { NextResponse } from "next/server";
import { pool } from "@/lib/db";

// ✅ LISTAR TODOS LOS OPERADORES TURÍSTICOS
export async function GET() {
  try {
    console.log("=== GET /api/operador-turistico ===");

    // Intentar usar la función, si existe
    let query = `SELECT * FROM listar_operador_turistico()`;
    let result;
    
    try {
      result = await pool.query(query);
      console.log("✅ Función listar_operador_turistico() ejecutada");
    } catch (funcError: any) {
      // Si la función no existe, usar consulta directa
      console.log("⚠️ Función no existe, usando consulta directa");
      
      // Verificar columnas disponibles
      const checkTableQuery = `
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'operador_turistico'
      `;
      
      try {
        const tableInfo = await pool.query(checkTableQuery);
        console.log("✅ Columnas de la tabla operador_turistico:", tableInfo.rows.map(r => r.column_name));
      } catch (tableCheckError: any) {
        console.error("❌ Error al verificar la tabla:", tableCheckError.message);
      }
      
      query = `
        SELECT 
          pro_cod,
          pro_nombre,
          pro_direccion,
          pro_telefono,
          pro_correo,
          lugar_lug_cod
        FROM operador_turistico
        ORDER BY pro_cod ASC
        LIMIT 10
      `;
      result = await pool.query(query);
    }

    console.log("✅ Columnas de operadores turísticos:", result.fields.map(f => f.name));
    if (result.rows.length > 0) {
      console.log("✅ Primer operador turístico:", result.rows[0]);
    }

    return NextResponse.json({
      status: "success",
      data: result.rows,
    }, { status: 200 });

  } catch (error: any) {
    console.error("❌ Error en GET /api/operador-turistico:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error al obtener operadores turísticos" 
      },
      { status: 500 }
    );
  }
}

// ✅ OBTENER UN OPERADOR TURÍSTICO POR ID
export async function POST(req: Request) {
  try {
    const { id } = await req.json();

    console.log("=== POST /api/operador-turistico ===");
    console.log("ID recibido:", id);

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Debe proporcionar un ID de operador turístico" },
        { status: 400 }
      );
    }

    // Intentar usar la función, si existe
    let query = `SELECT * FROM consultar_operador_turistico($1)`;
    let result;
    
    try {
      result = await pool.query(query, [id]);
    } catch (funcError: any) {
      // Si la función no existe, usar consulta directa
      console.log("⚠️ Función no existe, usando consulta directa");
      query = `
        SELECT 
          pro_cod,
          pro_nombre,
          pro_direccion,
          pro_telefono,
          pro_correo,
          lugar_lug_cod
        FROM operador_turistico
        WHERE pro_cod = $1
      `;
      result = await pool.query(query, [id]);
    }

    if (result.rows.length === 0) {
      return NextResponse.json(
        { status: "error", message: "Operador turístico no encontrado" },
        { status: 404 }
      );
    }

    console.log("✅ Operador turístico encontrado:", result.rows[0]);

    return NextResponse.json({
      status: "success",
      data: result.rows[0],
    }, { status: 200 });

  } catch (error: any) {
    console.error("❌ Error en POST /api/operador-turistico:", error);
    return NextResponse.json(
      { status: "error", message: error.message || "Error interno del servidor" },
      { status: 500 }
    );
  }
}