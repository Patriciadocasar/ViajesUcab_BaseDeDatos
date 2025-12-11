import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

// ✅ Crear aerolínea
export async function POST(req: Request) {
  try {
    const { nombre, direccion, telefono, correo, fechaFundacion } = await req.json();

    // Validar que todos los campos requeridos estén presentes
    if (!nombre || !direccion || !telefono || !correo || !fechaFundacion) {
      return NextResponse.json(
        { 
          status: "error", 
          message: "Todos los campos son requeridos: nombre, direccion, telefono, correo, fechaFundacion" 
        },
        { status: 400 }
      );
    }

    console.log("Intentando insertar aerolínea:", { nombre, direccion, telefono, correo, fechaFundacion });

    const result = await pool.query(
      "SELECT insertar_aerolinea($1, $2, $3, $4, $5) AS respuesta",
      [nombre, direccion, telefono, correo, fechaFundacion]
    );

    const respuesta = result.rows[0].respuesta;
    console.log("Respuesta de insertar_aerolinea:", respuesta);

    if (respuesta.status === "error") {
      return NextResponse.json(
        { 
          status: "error", 
          message: respuesta.message || "Error al insertar la aerolínea" 
        },
        { status: 400 }
      );
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error("Error en POST /api/aerolinea:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: error.message || "Error interno del servidor",
        details: process.env.NODE_ENV === "development" ? error.stack : undefined
      },
      { status: 500 }
    );
  }
}

// ✅ Consultar todas las aerolíneas
export async function GET() {
  try {
    // Primero obtener los nombres de las columnas para debug
    const columnResult = await pool.query(
      "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'aerolinea' ORDER BY ordinal_position"
    );
    console.log("Columnas de la tabla Aerolinea:", columnResult.rows);

    // Consultar todos los datos - row_to_json devuelve los nombres exactos de las columnas
    const result = await pool.query(
      "SELECT json_agg(row_to_json(a)) AS data FROM Aerolinea a"
    );

    const data = result.rows[0].data;
    console.log("Datos devueltos por la consulta (primer elemento):", data && data.length > 0 ? JSON.stringify(data[0], null, 2) : "No hay datos");

    return NextResponse.json(
      {
        status: "success",
        message: "Listado de aerolíneas",
        data: data || []
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Error en GET /api/aerolinea:", error);
    return NextResponse.json(
      { status: "error", message: "Error interno del servidor" },
      { status: 500 }
    );
  }
}

// ✅ Actualizar aerolínea
export async function PUT(req: Request) {
  const { id, nombre, direccion, telefono, correo, fechaFundacion } = await req.json();

  try {
    const result = await pool.query(
      "SELECT actualizar_aerolinea($1, $2, $3, $4, $5, $6) AS respuesta",
      [id, nombre, direccion, telefono, correo, fechaFundacion]
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

// ✅ Eliminar aerolínea
export async function DELETE(req: Request) {
  try {
    const { id } = await req.json();

    // Validar que el ID sea un número válido
    const idNumero = parseInt(id);
    if (isNaN(idNumero) || idNumero <= 0) {
      return NextResponse.json(
        { 
          status: "error", 
          message: "ID inválido. El ID debe ser un número válido." 
        },
        { status: 400 }
      );
    }

    console.log("Intentando eliminar aerolínea con ID:", idNumero);

    const result = await pool.query(
      "SELECT eliminar_aerolinea($1) AS respuesta",
      [idNumero]
    );

    const respuesta = result.rows[0].respuesta;
    console.log("Respuesta de eliminar_aerolinea:", respuesta);

    if (respuesta.status === "error") {
      return NextResponse.json(
        { 
          status: "error", 
          message: respuesta.message || "Error al eliminar la aerolínea" 
        },
        { status: 400 }
      );
    }

    return NextResponse.json(respuesta, { status: 200 });
  } catch (error: any) {
    console.error("Error en DELETE /api/aerolinea:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: error.message || "Error interno del servidor" 
      },
      { status: 500 }
    );
  }
}