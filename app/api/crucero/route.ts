// app/api/crucero/route.ts
import { pool } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    const result = await pool.query(`
      SELECT 
        C.Cru_COD,
        C.Cru_nombre,
        C.Barco_Bar_COD,
        C.Cru_Huella_Carbono,
        C.Cru_Fecha_Hora_Salida,
        C.Cru_Fecha_Hora_Lllegada,
        C.Cru_Cant_Millas,
        C.Cru_Costo,
        
        -- ORIGEN (puerto de salida)
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Crucero_Cru_COD = C.Cru_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD
            LIMIT 1
        ) AS origen,

        -- DESTINO (puerto de llegada)
        (
            SELECT L.Lug_Nombre
            FROM Ruta R, Terminal T, Lugar L
            WHERE R.Crucero_Cru_COD = C.Cru_COD
            AND T.Ter_COD = R.Terminal_Ter_COD
            AND L.Lug_COD = T.Lugar_Lug_COD2
            LIMIT 1
        ) AS destino

      FROM Crucero C
      ORDER BY C.Cru_COD ASC
    `);

    console.log("Columnas de cruceros:", result.fields.map(f => f.name));
    console.log(`Total de cruceros encontrados: ${result.rows.length}`);
    if (result.rows.length > 0) {
      console.log("Primer crucero:", result.rows[0]);
      console.log("IDs de cruceros en orden:", result.rows.map(c => c.cru_cod));
    }

    return NextResponse.json({
      status: "success",
      data: result.rows,
    });
  } catch (error: any) {
    console.error("Error al obtener cruceros:", error);
    return NextResponse.json(
      { 
        status: "error", 
        message: process.env.NODE_ENV === 'development' ? error.message : "Error al obtener cruceros" 
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
        { status: "error", message: "Falta el ID del crucero" },
        { status: 400 }
      );
    }

    const result = await pool.query(
      "SELECT mostrar_crucero_json($1) AS respuesta",
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