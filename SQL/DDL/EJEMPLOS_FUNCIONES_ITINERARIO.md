# Guía de Funciones para Itinerarios y Pagos

Este documento explica cómo usar las funciones creadas para gestionar itinerarios y pagos en el sistema ViajesUCAB.

## Índice
1. [Crear Itinerario con Reserva](#1-crear-itinerario-con-reserva)
2. [Procesar Pago de Reserva](#2-procesar-pago-de-reserva)
3. [Registrar Método de Pago (Tarjeta)](#3-registrar-método-de-pago-tarjeta)
4. [Obtener Detalle de Reserva](#4-obtener-detalle-de-reserva)
5. [Cancelar Reserva con Reembolso](#5-cancelar-reserva-con-reembolso)

---

## 1. Crear Itinerario con Reserva

### `crear_itinerario_con_reserva()`

Esta función crea una reserva completa con uno o varios itinerarios asociados. Calcula automáticamente los costos totales y las millas.

### Parámetros:
- `p_cliente_id`: ID del cliente que hace la reserva
- `p_res_camarote`: Número de camarote (opcional, para cruceros)
- `p_vuelo_ids`: Array de IDs de vuelos
- `p_hospedaje_ids`: Array de IDs de hospedajes
- `p_crucero_ids`: Array de IDs de cruceros
- `p_transporte_terrestre_ids`: Array de IDs de transportes terrestres
- `p_servicio_adicional_ids`: Array de IDs de servicios adicionales
- `p_restaurante_ids`: Array de IDs de restaurantes
- `p_paquete_turistico_ids`: Array de IDs de paquetes turísticos
- `p_fechas_inicio`: Array de fechas de inicio
- `p_fechas_fin`: Array de fechas de fin

### Ejemplo 1: Crear un itinerario simple con un vuelo y un hotel

```sql
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_vuelo_ids := ARRAY[1],
    p_hospedaje_ids := ARRAY[2],
    p_fechas_inicio := ARRAY['2024-06-15'::DATE],
    p_fechas_fin := ARRAY['2024-06-22'::DATE]
);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "message": "Reserva e itinerario(s) creados correctamente",
  "data": {
    "reserva_id": 1,
    "numero_reserva": 1234,
    "subtotal": 1500.00,
    "total": 1500.00,
    "millas_obtenidas": 150,
    "millas_totales_servicios": 200,
    "itinerarios_creados": 1
  }
}
```

### Ejemplo 2: Crear un itinerario complejo con múltiples servicios

```sql
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_res_camarote := 'A-101',
    p_vuelo_ids := ARRAY[1, 5],
    p_hospedaje_ids := ARRAY[2, 3],
    p_crucero_ids := ARRAY[1],
    p_servicio_adicional_ids := ARRAY[4, 7],
    p_fechas_inicio := ARRAY['2024-07-01'::DATE, '2024-07-08'::DATE],
    p_fechas_fin := ARRAY['2024-07-07'::DATE, '2024-07-15'::DATE]
);
```

### Ejemplo 3: Crear itinerario con un paquete turístico

```sql
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 5,
    p_paquete_turistico_ids := ARRAY[1],
    p_fechas_inicio := ARRAY['2024-08-01'::DATE],
    p_fechas_fin := ARRAY['2024-08-10'::DATE]
);
```

---

## 2. Procesar Pago de Reserva

### `procesar_pago_reserva()`

Esta función procesa el pago completo de una reserva, con soporte para pago con millas, financiamiento y diferentes métodos de pago.

### Parámetros:
- `p_reserva_id`: ID de la reserva a pagar
- `p_cliente_id`: ID del cliente
- `p_metodo_pago_id`: ID del método de pago a usar
- `p_monto_pago`: Monto total a pagar
- `p_pago_con_millas`: TRUE si se usan millas (default: FALSE)
- `p_cantidad_millas`: Cantidad de millas a usar (default: 0)
- `p_tasa_cambio_id`: ID de la tasa de cambio (opcional)
- `p_usar_financiamiento`: TRUE si se usa financiamiento (default: FALSE)
- `p_numero_cuotas`: Número de cuotas (opcional)
- `p_monto_financiado`: Monto a financiar (opcional)

### Ejemplo 1: Pago completo con tarjeta (sin millas)

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 1,
    p_cliente_id := 1,
    p_metodo_pago_id := 3,
    p_monto_pago := 1500.00
);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "message": "Pago procesado correctamente",
  "data": {
    "pago_id": 1,
    "reserva_id": 1,
    "monto_pagado": 1500.00,
    "millas_usadas": 0,
    "millas_obtenidas": 150,
    "millas_actuales_cliente": 350,
    "financiamiento_id": null,
    "cuotas_creadas": 0
  }
}
```

### Ejemplo 2: Pago usando millas acumuladas

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 2,
    p_cliente_id := 1,
    p_metodo_pago_id := 3,
    p_monto_pago := 1200.00,
    p_pago_con_millas := TRUE,
    p_cantidad_millas := 200
);
```

### Ejemplo 3: Pago con financiamiento a 6 cuotas

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 3,
    p_cliente_id := 2,
    p_metodo_pago_id := 5,
    p_monto_pago := 500.00,  -- Pago inicial
    p_usar_financiamiento := TRUE,
    p_numero_cuotas := 6,
    p_monto_financiado := 3000.00
);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "message": "Pago procesado correctamente",
  "data": {
    "pago_id": 3,
    "reserva_id": 3,
    "monto_pagado": 500.00,
    "millas_usadas": 0,
    "millas_obtenidas": 300,
    "millas_actuales_cliente": 300,
    "financiamiento_id": 1,
    "cuotas_creadas": 6
  }
}
```

### Ejemplo 4: Pago con tasa de cambio específica

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 4,
    p_cliente_id := 3,
    p_metodo_pago_id := 2,
    p_monto_pago := 50000.00,  -- En bolívares
    p_tasa_cambio_id := 1  -- Tasa USD -> VES
);
```

---

## 3. Registrar Método de Pago (Tarjeta)

### `registrar_metodo_pago_tarjeta()`

Esta función registra un nuevo método de pago de tipo tarjeta de crédito o débito.

### Parámetros:
- `p_tipo`: 'Tarjeta_Credito' o 'Tarjeta_Debito'
- `p_num_tarjeta`: Número de tarjeta (16 dígitos)
- `p_cod_seguridad`: CVV (3-4 dígitos)
- `p_emisor`: Banco emisor
- `p_marca`: Visa, Mastercard, etc.
- `p_fecha_vencimiento`: Fecha de vencimiento
- `p_nombre_titular`: Nombre en la tarjeta

### Ejemplo:

```sql
SELECT registrar_metodo_pago_tarjeta(
    p_tipo := 'Tarjeta_Credito',
    p_num_tarjeta := 4111111111111111,
    p_cod_seguridad := 123,
    p_emisor := 'Banco de Venezuela',
    p_marca := 'Visa',
    p_fecha_vencimiento := '2027-12-31'::DATE,
    p_nombre_titular := 'Juan Perez'
);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "message": "Método de pago registrado correctamente",
  "data": {
    "metodo_pago_id": 10
  }
}
```

---

## 4. Obtener Detalle de Reserva

### `obtener_detalle_reserva()`

Esta función obtiene toda la información de una reserva, incluyendo sus itinerarios.

### Parámetros:
- `p_reserva_id`: ID de la reserva

### Ejemplo:

```sql
SELECT obtener_detalle_reserva(p_reserva_id := 1);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "data": {
    "reserva": {
      "reserva_id": 1,
      "numero_reserva": 1234,
      "fecha_hora": "2024-01-15T10:30:00",
      "subtotal": 1500.00,
      "total": 1500.00,
      "millas_obtenidas": 150,
      "camarote": null,
      "cliente": {
        "cliente_id": 1,
        "nombre": "Juan Perez"
      }
    },
    "itinerarios": [
      {
        "itinerario_id": 1,
        "costo_total": 1500.00,
        "fecha_inicio": "2024-06-15",
        "fecha_fin": "2024-06-22",
        "millas_totales": 200,
        "vuelo_id": 1,
        "hospedaje_id": 2,
        "crucero_id": null,
        "transporte_terrestre_id": null,
        "servicio_adicional_id": null
      }
    ]
  }
}
```

---

## 5. Cancelar Reserva con Reembolso

### `cancelar_reserva_con_reembolso()`

Esta función cancela una reserva y genera un reembolso con una retención porcentual.

### Parámetros:
- `p_reserva_id`: ID de la reserva a cancelar
- `p_porcentaje_retencion`: % a retener (default: 10%)
- `p_metodo_pago_reembolso_id`: ID del método de pago para el reembolso
- `p_tasa_cambio_id`: ID de la tasa de cambio (opcional)

### Ejemplo 1: Cancelación con 10% de retención

```sql
SELECT cancelar_reserva_con_reembolso(
    p_reserva_id := 5,
    p_porcentaje_retencion := 10.00,
    p_metodo_pago_reembolso_id := 3
);
```

**Resultado esperado:**
```json
{
  "status": "success",
  "message": "Reserva cancelada y reembolso procesado",
  "data": {
    "reembolso_id": 1,
    "monto_total": 1500.00,
    "monto_retenido": 150.00,
    "monto_devuelto": 1350.00,
    "porcentaje_retencion": 10.00
  }
}
```

### Ejemplo 2: Cancelación con 20% de retención

```sql
SELECT cancelar_reserva_con_reembolso(
    p_reserva_id := 6,
    p_porcentaje_retencion := 20.00,
    p_metodo_pago_reembolso_id := 5,
    p_tasa_cambio_id := 1
);
```

---

## Flujo Completo de Ejemplo

A continuación, un flujo completo desde la creación del itinerario hasta el pago:

### Paso 1: Registrar método de pago del cliente

```sql
-- Registrar tarjeta de crédito
SELECT registrar_metodo_pago_tarjeta(
    p_tipo := 'Tarjeta_Credito',
    p_num_tarjeta := 4111111111111111,
    p_cod_seguridad := 123,
    p_emisor := 'Banco Provincial',
    p_marca := 'Visa',
    p_fecha_vencimiento := '2027-06-30'::DATE,
    p_nombre_titular := 'Maria Rodriguez'
);
-- Retorna: metodo_pago_id = 15
```

### Paso 2: Crear el itinerario y reserva

```sql
-- Crear reserva con vuelo, hotel y servicio adicional
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 3,
    p_vuelo_ids := ARRAY[7],
    p_hospedaje_ids := ARRAY[4],
    p_servicio_adicional_ids := ARRAY[12],
    p_fechas_inicio := ARRAY['2024-09-01'::DATE],
    p_fechas_fin := ARRAY['2024-09-07'::DATE]
);
-- Retorna: reserva_id = 20, total = 2500.00
```

### Paso 3: Asociar método de pago al cliente

```sql
-- Si no se hizo automáticamente, asociar el método de pago al cliente
INSERT INTO Cli_MP (Cliente_Cli_COD, Metodo_de_Pago_MP_COD)
VALUES (3, 15);
```

### Paso 4: Procesar el pago

```sql
-- Pagar usando el método de pago registrado
SELECT procesar_pago_reserva(
    p_reserva_id := 20,
    p_cliente_id := 3,
    p_metodo_pago_id := 15,
    p_monto_pago := 2500.00
);
-- Retorna: pago_id = 25, millas_obtenidas = 250
```

### Paso 5: Verificar la reserva

```sql
-- Obtener todos los detalles de la reserva
SELECT obtener_detalle_reserva(p_reserva_id := 20);
```

---

## Notas Importantes

### Sobre las Millas:
- Las millas se calculan automáticamente como el 10% del monto total pagado
- Las millas se suman al cliente después de completar el pago
- Si se usan millas para pagar, se restan primero y luego se suman las obtenidas

### Sobre el Financiamiento:
- Las cuotas se crean automáticamente con vencimiento mensual
- El monto de cada cuota se calcula dividiendo el monto financiado entre el número de cuotas
- Se puede hacer un pago inicial y financiar el resto

### Sobre las Reservas:
- El número de reserva se genera automáticamente
- Una reserva puede tener múltiples itinerarios
- El costo total se calcula sumando todos los servicios incluidos

### Manejo de Errores:
Todas las funciones retornan un JSON con el siguiente formato en caso de error:

```json
{
  "status": "error",
  "message": "Descripción del error"
}
```

---

## Integración con la Aplicación Next.js

Para integrar estas funciones en tu aplicación, puedes crear endpoints en `/app/api/` que llamen a estas funciones. Por ejemplo:

### API Route: `/app/api/itinerario/crear/route.ts`

```typescript
import { query } from '@/lib/db'

export async function POST(request: Request) {
  const body = await request.json()
  
  const resultado = await query(
    `SELECT crear_itinerario_con_reserva(
      $1::INTEGER,
      $2::VARCHAR,
      $3::INTEGER[],
      $4::INTEGER[],
      $5::DATE[],
      $6::DATE[]
    )`,
    [
      body.cliente_id,
      body.camarote,
      body.vuelo_ids,
      body.hospedaje_ids,
      body.fechas_inicio,
      body.fechas_fin
    ]
  )
  
  return Response.json(resultado.rows[0])
}
```

### API Route: `/app/api/pago/procesar/route.ts`

```typescript
import { query } from '@/lib/db'

export async function POST(request: Request) {
  const body = await request.json()
  
  const resultado = await query(
    `SELECT procesar_pago_reserva(
      $1::INTEGER,
      $2::INTEGER,
      $3::INTEGER,
      $4::NUMERIC,
      $5::BOOLEAN,
      $6::INTEGER
    )`,
    [
      body.reserva_id,
      body.cliente_id,
      body.metodo_pago_id,
      body.monto_pago,
      body.pago_con_millas || false,
      body.cantidad_millas || 0
    ]
  )
  
  return Response.json(resultado.rows[0])
}
```

---

## Testing de las Funciones

Para probar las funciones, ejecuta estos comandos en orden:

```sql
-- 1. Crear un cliente de prueba (si no existe)
INSERT INTO Cliente (Cli_Primer_Nombre, Cli_Apellido, Cli_Fecha_Nacimiento, 
                     Cli_Estado_Civil, Cli_Millas_Acum, Lugar_Lug_COD)
VALUES ('Test', 'User', '1990-01-01', 'Soltero', 500, 1)
RETURNING Cli_COD;

-- 2. Crear servicios de prueba (vuelo, hotel, etc.)
-- Ver SQL/DML/inserts.sql para ejemplos

-- 3. Probar creación de itinerario
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,  -- Usar el ID del cliente creado
    p_vuelo_ids := ARRAY[1],
    p_hospedaje_ids := ARRAY[1],
    p_fechas_inicio := ARRAY[CURRENT_DATE + 30],
    p_fechas_fin := ARRAY[CURRENT_DATE + 37]
);

-- 4. Probar procesamiento de pago
-- Usar los IDs retornados en el paso anterior
```

