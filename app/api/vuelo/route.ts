// app/api/vuelo/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    const result = await pool.query(`
      SELECT 
        V.Vue_COD,
        V.Avion_Avi_COD,
        V.Vue_Huella_Carbono,
        V.Vue_Fecha_Hora_Salida,
        V.Vue_Fecha_Hora_Llegada,
        V.Vue_Cant_Millas,
        V.Vue_Costo,
        
        -- ORIGEN
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Vuelo_Vue_COD = V.Vue_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD
            LIMIT 1
        ) AS origen,

        -- DESTINO
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Vuelo_Vue_COD = V.Vue_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD2
            LIMIT 1
        ) AS destino

      FROM Vuelo V
      ORDER BY V.Vue_COD ASC
    `);

    console.log("Columnas de vuelos:", result.fields.map(f => f.name));
    console.log(`Total de vuelos encontrados: ${result.rows.length}`);
    if (result.rows.length > 0) {
      console.log("Primer vuelo:", result.rows[0]);
      console.log("IDs de vuelos en orden:", result.rows.map(v => v.vue_cod));
    }

    return NextResponse.json({
      status: "success",
      data: result.rows,
    });
  } catch (error: any) {
    console.error("Error al obtener vuelos:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error al obtener vuelos" 
      },
      { status: 500 }
    );
  }
}

export async function POST(req: Request) {
  try {
    const { id } = await req.json();

    if (!id) {
      return NextResponse.json(
        { status: "error", message: "Falta el ID del vuelo" },
        { status: 400 }
      );
    }

    const result = await pool.query(
      "SELECT mostrar_vuelo_json($1) AS respuesta",
      [id]
    );

    const respuesta = result.rows[0].respuesta;

    if (respuesta.status === "error") {
      return NextResponse.json(respuesta, { status: 404 });
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