# Flujo de Creación y Pago de Itinerarios

## Diagrama del Flujo Principal

```
┌─────────────────────────────────────────────────────────────────────┐
│                         CLIENTE                                      │
│                      (Cliente_Cli_COD)                              │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ├──── Tiene Millas Acumuladas
                             │     (Cli_Millas_Acum)
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    1. CREAR ITINERARIO                              │
│               crear_itinerario_con_reserva()                        │
│                                                                     │
│  Entrada:                                                           │
│  • Cliente ID                                                       │
│  • Vuelos, Hospedajes, Cruceros, etc. (Arrays de IDs)             │
│  • Fechas de inicio y fin                                          │
│                                                                     │
│  Proceso:                                                           │
│  1. Valida que el cliente existe                                   │
│  2. Calcula costos totales de todos los servicios                 │
│  3. Calcula millas totales de los servicios                       │
│  4. Genera número de reserva único                                │
│  5. Crea registro en tabla RESERVA                                │
│  6. Crea registro(s) en tabla ITINERARIO                          │
│                                                                     │
│  Salida:                                                            │
│  • Reserva ID                                                       │
│  • Número de reserva                                                │
│  • Subtotal, Total                                                  │
│  • Millas que se obtendrán al pagar                                │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Genera
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         RESERVA                                      │
│                      (Tabla: Reserva)                               │
│                                                                     │
│  • Res_COD (ID de la reserva)                                      │
│  • Res_Numero_Reserva (Número visible para el cliente)            │
│  • Res_Subtotal                                                     │
│  • Res_Total                                                        │
│  • Res_Milla_Obtenida (millas a ganar al pagar)                   │
│  • Cliente_Cli_COD                                                  │
│  • Res_Fecha_Hora                                                   │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Contiene
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      ITINERARIO(S)                                  │
│                    (Tabla: Itinerario)                             │
│                                                                     │
│  Cada itinerario puede tener:                                      │
│  • Vuelo_Vue_COD                                                    │
│  • Hospedaje_Hos_COD                                               │
│  • Crucero_Cru_COD                                                 │
│  • Transporte_Terrestre_TT_COD                                     │
│  • Servicio_Adicional_SA_COD                                       │
│  • Restaurante_Rest_COD                                            │
│  • Paquete_Turistico_PT_COD                                        │
│  • Iti_Costo_Total (suma de todos los servicios)                  │
│  • Iti_Cant_Milla_Total (millas acumuladas del servicio)          │
│  • Iti_Fecha_Inicio / Iti_Fecha_Fin                               │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Cliente decide pagar
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    2. PROCESAR PAGO                                 │
│                  procesar_pago_reserva()                           │
│                                                                     │
│  Entrada:                                                           │
│  • Reserva ID                                                       │
│  • Cliente ID                                                       │
│  • Método de Pago ID                                                │
│  • Monto a pagar                                                    │
│  • ¿Usar millas? (opcional)                                        │
│  • ¿Usar financiamiento? (opcional)                                │
│                                                                     │
│  Proceso:                                                           │
│  1. Valida reserva y cliente                                       │
│  2. Si usa millas: verifica que tenga suficientes                 │
│  3. Verifica/crea relación Cli_MP                                 │
│  4. Si usa financiamiento: crea Financiamiento y Cuotas           │
│  5. Crea registro en tabla PAGO                                    │
│  6. Actualiza millas del cliente:                                  │
│     - Resta millas usadas (si aplica)                             │
│     - Suma millas obtenidas (Res_Milla_Obtenida)                 │
│                                                                     │
│  Salida:                                                            │
│  • Pago ID                                                          │
│  • Monto pagado                                                     │
│  • Millas usadas y obtenidas                                        │
│  • Millas actuales del cliente                                      │
│  • Financiamiento ID (si aplica)                                    │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Genera
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                           PAGO                                       │
│                       (Tabla: Pago)                                 │
│                                                                     │
│  • PAG_COD (ID del pago)                                           │
│  • PAG_Fecha_Hora                                                   │
│  • PAG_Total (monto pagado)                                         │
│  • Pag_Total_Milla (millas usadas, si aplica)                     │
│  • Cli_MP_MP_COD (método de pago)                                  │
│  • Cli_MP_Cli_COD (cliente)                                        │
│  • Reserva_Res_COD (reserva pagada)                                │
│  • Tasa_de_Cambio_TC_COD (si aplica conversión)                   │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             │ Actualiza
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                  CLIENTE ACTUALIZADO                                │
│                                                                     │
│  Millas Nuevas = Millas Anteriores - Millas Usadas + Millas Ganadas│
│                                                                     │
│  Ejemplo:                                                           │
│  • Millas Anteriores: 500                                           │
│  • Millas Usadas: 100                                               │
│  • Millas Ganadas: 250                                              │
│  • Millas Nuevas: 500 - 100 + 250 = 650                            │
└─────────────────────────────────────────────────────────────────────┘
```

## Relaciones entre Tablas

```
CLIENTE ─────────┐
                 │
                 ├──── CLI_MP ────── METODO_DE_PAGO
                 │         │
                 │         └────── PAGO
                 │                  │
                 └──── RESERVA ─────┤
                          │         │
                          │         └──── TASA_DE_CAMBIO
                          │
                          ├──── ITINERARIO ────┬──── VUELO
                          │                    │
                          │                    ├──── HOSPEDAJE
                          │                    │
                          │                    ├──── CRUCERO
                          │                    │
                          │                    ├──── TRANSPORTE_TERRESTRE
                          │                    │
                          │                    ├──── SERVICIO_ADICIONAL
                          │                    │
                          │                    ├──── RESTAURANTE
                          │                    │
                          │                    └──── PAQUETE_TURISTICO
                          │
                          └──── FINANCIAMIENTO ──── CUOTA ──── PAGO
```

## Flujo Alternativo: Pago con Financiamiento

```
┌─────────────────────────────────────────────────────────────────────┐
│                  PAGO CON FINANCIAMIENTO                            │
└─────────────────────────────┬───────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ FINANCIAMIENTO   │
                    │                  │
                    │ • Fin_COD        │
                    │ • Fin_Numero_Cuotas: 6  │
                    │ • Fin_Monto_Financiado: 3000.00  │
                    │ • Reserva_Res_COD  │
                    └────────┬─────────┘
                             │
                             │ Genera
                             ▼
               ┌─────────────────────────────┐
               │      CUOTAS (6 cuotas)      │
               └─────────────────────────────┘
                             │
                ┌────────────┼────────────┐
                ▼            ▼            ▼
            CUOTA 1      CUOTA 2      CUOTA 6
            Monto: 500   Monto: 500   Monto: 500
            Vence: +1mes Vence: +2mes Vence: +6mes
```

## Flujo de Cancelación y Reembolso

```
┌─────────────────────────────────────────────────────────────────────┐
│               CANCELAR RESERVA CON REEMBOLSO                        │
│            cancelar_reserva_con_reembolso()                        │
│                                                                     │
│  Entrada:                                                           │
│  • Reserva ID                                                       │
│  • Porcentaje de retención (ej: 10%)                               │
│  • Método de pago para reembolso                                    │
│                                                                     │
│  Proceso:                                                           │
│  1. Obtiene el total de la reserva                                 │
│  2. Calcula monto retenido = total * (% retención / 100)          │
│  3. Calcula monto devuelto = total - monto retenido               │
│  4. Crea registro en tabla REEMBOLSO                               │
│  5. Crea registro en tabla PAGO_REEMBOLSADO                        │
│                                                                     │
│  Ejemplo:                                                           │
│  • Total Reserva: $1,500                                            │
│  • Retención 10%: $150                                              │
│  • Monto Devuelto: $1,350                                           │
└─────────────────────────────┬───────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │   REEMBOLSO      │
                    │                  │
                    │ • Rem_Monto_Devuelto: 1350  │
                    │ • Rem_Monto_Retenido: 150   │
                    │ • Reserva_Res_COD           │
                    └────────┬─────────┘
                             │
                             │ Genera
                             ▼
                    ┌──────────────────┐
                    │ PAGO_REEMBOLSADO │
                    │                  │
                    │ • Fecha_Hora_Reembolso     │
                    │ • Monto_Reembolso: 1350    │
                    │ • Metodo_de_Pago_MP_COD    │
                    │ • Tasa_de_Cambio_TC_COD    │
                    └──────────────────┘
```

## Cálculo de Millas

### Millas de Servicios
Cada servicio tiene millas asociadas:
- **Vuelo**: `Vue_Cant_Millas` (ej: 150 millas)
- **Hospedaje**: `Hot_Cant_Milla` (ej: 50 millas)
- **Crucero**: `Cru_Cant_Millas` (ej: 300 millas)
- **Transporte Terrestre**: `TT_Cant_Millas` (ej: 20 millas)
- **Servicio Adicional**: `SA_Cant_Milla` (ej: 30 millas)
- **Paquete Turístico**: `PT_Cant_Milla` (ej: 200 millas)

### Millas por Compra
Cuando el cliente paga, obtiene millas adicionales:
```
Millas Obtenidas = FLOOR(Total_Pago * 0.10)

Ejemplo:
Total Pagado: $2,500
Millas Obtenidas: FLOOR(2500 * 0.10) = 250 millas
```

### Millas Totales del Itinerario
```
Millas_Itinerario = Suma de todas las millas de los servicios incluidos

Ejemplo:
Vuelo: 150 millas
Hotel: 50 millas
Tour: 30 millas
────────────────
Total: 230 millas (guardadas en Iti_Cant_Milla_Total)
```

## Ejemplo Completo Paso a Paso

### Escenario
Juan quiere viajar a París y reservar:
- Vuelo Caracas-París (ID: 1, Costo: $800, Millas: 150)
- Hotel 5 estrellas (ID: 2, Costo: $1,200, Millas: 50)
- Tour por la ciudad (ID: 5, Costo: $150, Millas: 15)

Juan tiene actualmente 500 millas acumuladas.

### Paso 1: Crear el itinerario

```sql
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 10,              -- Juan
    p_vuelo_ids := ARRAY[1],
    p_hospedaje_ids := ARRAY[2],
    p_servicio_adicional_ids := ARRAY[5],
    p_fechas_inicio := ARRAY['2024-07-15'::DATE],
    p_fechas_fin := ARRAY['2024-07-22'::DATE]
);
```

**Resultado:**
```json
{
  "status": "success",
  "data": {
    "reserva_id": 100,
    "numero_reserva": 5678,
    "subtotal": 2150.00,
    "total": 2150.00,
    "millas_obtenidas": 215,        // 10% de $2,150
    "millas_totales_servicios": 215  // 150 + 50 + 15
  }
}
```

### Paso 2: Juan decide usar 100 millas y pagar el resto

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 100,
    p_cliente_id := 10,
    p_metodo_pago_id := 5,
    p_monto_pago := 2150.00,
    p_pago_con_millas := TRUE,
    p_cantidad_millas := 100
);
```

**Resultado:**
```json
{
  "status": "success",
  "data": {
    "pago_id": 50,
    "monto_pagado": 2150.00,
    "millas_usadas": 100,
    "millas_obtenidas": 215,
    "millas_actuales_cliente": 615   // 500 - 100 + 215
  }
}
```

### Resumen Final
- **Juan tenía**: 500 millas
- **Juan usó**: 100 millas
- **Juan ganó**: 215 millas
- **Juan tiene ahora**: 615 millas
- **Reserva creada**: #5678
- **Itinerario**: Vuelo + Hotel + Tour a París

## Integración con el Frontend

### Componente: CrearItinerarioForm.tsx

```typescript
const handleCrearItinerario = async () => {
  const response = await fetch('/api/itinerario/crear', {
    method: 'POST',
    body: JSON.stringify({
      cliente_id: user.clienteId,
      vuelo_ids: selectedVuelos.map(v => v.id),
      hospedaje_ids: selectedHospedajes.map(h => h.id),
      fechas_inicio: [startDate],
      fechas_fin: [endDate]
    })
  });
  
  const result = await response.json();
  
  if (result.status === 'success') {
    // Guardar reserva_id para el siguiente paso
    setReservaId(result.data.reserva_id);
    router.push(`/itinerario/pago/${result.data.reserva_id}`);
  }
}
```

### Componente: PagarReservaForm.tsx

```typescript
const handleProcesarPago = async () => {
  const response = await fetch('/api/pago/procesar', {
    method: 'POST',
    body: JSON.stringify({
      reserva_id: reservaId,
      cliente_id: user.clienteId,
      metodo_pago_id: selectedPaymentMethod,
      monto_pago: totalAmount,
      pago_con_millas: usesMiles,
      cantidad_millas: milesToUse
    })
  });
  
  const result = await response.json();
  
  if (result.status === 'success') {
    // Actualizar millas del usuario
    updateUserMiles(result.data.millas_actuales_cliente);
    router.push(`/confirmacion?reservation=${numeroReserva}`);
  }
}
```

## Consideraciones de Seguridad

1. **Validación de Cliente**: Siempre verificar que el cliente que hace la reserva es el mismo que está autenticado
2. **Validación de Monto**: Verificar que el monto pagado coincide con el total de la reserva
3. **Transacciones**: Todas las operaciones de pago deben ser transaccionales (esto ya está manejado por las funciones)
4. **Auditoría**: Considerar agregar triggers para registrar cambios en la tabla Auditoria

## Próximos Pasos

Para completar la integración:

1. ✅ Funciones SQL creadas
2. ⬜ Crear API routes en Next.js
3. ⬜ Actualizar componentes de UI para usar las nuevas APIs
4. ⬜ Agregar manejo de errores y validaciones
5. ⬜ Implementar pruebas unitarias
6. ⬜ Documentar endpoints de API

