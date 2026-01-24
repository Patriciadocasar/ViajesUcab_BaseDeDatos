--REPORTE 1
SELECT 
    datos.mes,
    datos.combinacion_metodos,
    datos.ingreso_por_combinacion,
    totales.ingreso_total_mes,
    ROUND ((datos.ingreso_por_combinacion * 100.0 / totales.ingreso_total_mes),2) AS porcentaje
FROM (
    -- Subconsulta 1: detalle por combinación de métodos
    SELECT 
        TO_CHAR(p.PAG_Fecha_Hora, 'YYYY-MM') AS mes,
        STRING_AGG(mp.Tipo, ' + ' ORDER BY mp.Tipo) AS combinacion_metodos,
        SUM(p.PAG_Total) AS ingreso_por_combinacion
    FROM Pago p, Cli_MP cm, Metodo_de_Pago mp
    WHERE p.Cli_MP_MP_COD = cm.Metodo_de_Pago_MP_COD
      AND p.Cli_MP_Cli_COD = cm.Cliente_Cli_COD
      AND cm.Metodo_de_Pago_MP_COD = mp.MP_COD
    GROUP BY mes, p.PAG_COD
) datos,
(
    -- Subconsulta 2: total por mes
    SELECT 
        TO_CHAR(PAG_Fecha_Hora, 'YYYY-MM') AS mes,
        SUM(PAG_Total) AS ingreso_total_mes
    FROM Pago
    GROUP BY TO_CHAR(PAG_Fecha_Hora, 'YYYY-MM')
) totales
WHERE datos.mes = totales.mes
ORDER BY datos.mes, datos.combinacion_metodos;


-- Reporte 2: 

SELECT 
    c.Cli_COD,
    c.Cli_Primer_Nombre || ' ' || c.Cli_Apellido AS Cliente,
    sa.SA_Nombre AS Servicio,
    sa.SA_Tipo AS Tipo_Servicio,
    sa.SA_Cant_Milla AS Millas_Otorgadas,
    i.Iti_Fecha_Inicio,
    i.Iti_Fecha_Fin,
    r.Res_Numero_Reserva
FROM Itinerario i, Cliente c, Servicio_Adicional sa, Reserva r
WHERE r.Cliente_Cli_COD = c.Cli_COD
  AND i.Servicio_Adicional_SA_COD = sa.SA_COD
  AND i.Reserva_Res_COD = r.Res_COD
ORDER BY i.Iti_Fecha_Inicio DESC;


-- Reporte 3: 

SELECT
    pt.PT_Nombre AS Paquete,
    pt.PT_Costo_Millas AS Costo_Millas,
    r.Res_Fecha_Hora AS Fecha_Reserva,
    c.Cli_Primer_Nombre || ' ' || c.Cli_Apellido AS Cliente,
    p.Pag_Total_Milla AS Millas_Usadas
FROM Itinerario i, Paquete_Turistico pt, Reserva r, Cliente c, Pago p
WHERE i.Paquete_Turistico_PT_COD = pt.PT_COD
  AND i.Reserva_Res_COD = r.Res_COD
  AND r.Cliente_Cli_COD = c.Cli_COD
  AND p.Reserva_Res_COD = r.Res_COD
  AND p.Pag_Total_Milla > 0
  AND r.Res_Fecha_Hora >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY p.Pag_Total_Milla DESC
FETCH FIRST 10 ROWS ONLY;

-- Reporte 4: 

SELECT 
    sa.SA_Nombre AS Servicio,
    sa.SA_Tipo AS Tipo_Servicio,
    op.Pro_Nombre AS Operador_Turistico,
    sa.SA_Fecha_Hora_Fin - sa.SA_Fecha_Hora_Inicio AS Duracion,
    AVG(sa.SA_Costo) AS Costo_Promedio,
    COUNT(*) AS Veces_Vendido
FROM Itinerario i, Servicio_Adicional sa, Operador_Turistico op
WHERE i.Servicio_Adicional_SA_COD = sa.SA_COD
AND sa.Operador_Turistico_Pro_COD = op.Pro_COD
GROUP BY sa.SA_Nombre, sa.SA_Tipo, op.Pro_Nombre, Duracion
ORDER BY Veces_Vendido DESC
FETCH FIRST 10 ROWS ONLY;

-- Reporte 5: 

SELECT 
    c.Cli_COD,
    c.Cli_Primer_Nombre || ' ' || c.Cli_Apellido AS Cliente,
    COUNT(*) AS Itinerarios_Complejos
FROM Itinerario i
JOIN Reserva r ON i.Reserva_Res_COD = r.Res_COD
JOIN Cliente c ON r.Cliente_Cli_COD = c.Cli_COD
WHERE (
    (CASE WHEN i.Vuelo_Vue_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Crucero_Cru_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Hospedaje_Hos_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Restaurante_Rest_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Paquete_Turistico_PT_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Transporte_Terrestre_TT_COD IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN i.Servicio_Adicional_SA_COD IS NOT NULL THEN 1 ELSE 0 END)
) > 2
GROUP BY c.Cli_COD, Cliente
ORDER BY Itinerarios_Complejos DESC;