# Funciones de Itinerario y Pago - ViajesUCAB

## 📋 Resumen

Este conjunto de funciones SQL permite gestionar la creación de itinerarios de viaje y el procesamiento de pagos en el sistema ViajesUCAB. Las funciones están diseñadas para trabajar con el esquema de base de datos PostgreSQL existente.

## 📁 Archivos Creados

### 1. `functions.sql`
Contiene el código completo de las 5 funciones principales:
- `crear_itinerario_con_reserva()` - Crea reservas e itinerarios
- `procesar_pago_reserva()` - Procesa pagos con múltiples opciones
- `registrar_metodo_pago_tarjeta()` - Registra tarjetas de pago
- `obtener_detalle_reserva()` - Consulta información de reservas
- `cancelar_reserva_con_reembolso()` - Gestiona cancelaciones

### 2. `EJEMPLOS_FUNCIONES_ITINERARIO.md`
Documentación detallada con ejemplos de uso de cada función, incluyendo:
- Parámetros de entrada
- Ejemplos de llamadas SQL
- Resultados esperados en formato JSON
- Casos de uso comunes
- Integración con Next.js

### 3. `FLUJO_ITINERARIO_PAGO.md`
Diagramas visuales y explicaciones del flujo completo:
- Diagramas ASCII del proceso
- Relaciones entre tablas
- Cálculo de millas
- Ejemplo paso a paso completo
- Consideraciones de seguridad

### 4. `test_functions.sql`
Script de pruebas automatizadas que incluye:
- 8 pruebas diferentes
- Verificación de datos
- Ejemplos de uso real
- Validación de resultados

## 🚀 Instalación

### Paso 1: Ejecutar las funciones

```bash
psql -U tu_usuario -d viajesucab_db -f SQL/DDL/functions.sql
```

### Paso 2: Verificar instalación

```sql
-- Verificar que las funciones fueron creadas
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_name LIKE '%itinerario%' OR routine_name LIKE '%pago%';
```

### Paso 3: Ejecutar pruebas (opcional)

```bash
psql -U tu_usuario -d viajesucab_db -f SQL/DDL/test_functions.sql
```

## 📖 Uso Rápido

### Ejemplo 1: Crear un itinerario simple

```sql
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_vuelo_ids := ARRAY[1],
    p_hospedaje_ids := ARRAY[2],
    p_fechas_inicio := ARRAY['2024-07-15'::DATE],
    p_fechas_fin := ARRAY['2024-07-22'::DATE]
);
```

### Ejemplo 2: Procesar un pago

```sql
SELECT procesar_pago_reserva(
    p_reserva_id := 1,
    p_cliente_id := 1,
    p_metodo_pago_id := 3,
    p_monto_pago := 1500.00
);
```

## 🔑 Características Principales

### ✅ Gestión Automática de Costos
- Calcula automáticamente el costo total de la reserva
- Suma los costos de todos los servicios incluidos
- Maneja subtotales y totales

### ✅ Sistema de Millas
- Calcula millas obtenidas por compra (10% del total)
- Permite usar millas acumuladas para pagar
- Actualiza automáticamente el saldo de millas del cliente

### ✅ Financiamiento
- Soporte para pago en cuotas
- Generación automática de cuotas mensuales
- Cálculo de montos por cuota

### ✅ Múltiples Métodos de Pago
- Tarjetas de crédito/débito
- Pago con millas
- Combinación de métodos

### ✅ Reembolsos
- Cancelación de reservas con retención configurable
- Registro de reembolsos por método de pago
- Soporte para tasas de cambio

## 📊 Estructura de Datos

### Tablas Principales Involucradas

```
Cliente
  └── Reserva
        ├── Itinerario (1 o más)
        │     ├── Vuelo
        │     ├── Hospedaje
        │     ├── Crucero
        │     ├── Transporte_Terrestre
        │     ├── Servicio_Adicional
        │     ├── Restaurante
        │     └── Paquete_Turistico
        │
        ├── Pago
        │     ├── Cli_MP (Método de Pago)
        │     └── Tasa_de_Cambio
        │
        ├── Financiamiento
        │     └── Cuota (1 o más)
        │
        └── Reembolso
              └── Pago_Reembolsado
```

## 🔄 Flujo de Trabajo Típico

### 1. Cliente Crea Itinerario
```
Usuario selecciona servicios en la UI
    ↓
Frontend envía request a API
    ↓
API llama crear_itinerario_con_reserva()
    ↓
Se crea Reserva + Itinerario(s)
    ↓
Retorna número de reserva y total
```

### 2. Cliente Procesa Pago
```
Usuario ingresa datos de pago
    ↓
Frontend envía request a API
    ↓
API llama procesar_pago_reserva()
    ↓
Se valida y procesa el pago
    ↓
Se actualizan millas del cliente
    ↓
Retorna confirmación
```

## 🔗 Integración con Next.js

### Crear API Route

```typescript
// app/api/itinerario/crear/route.ts
import { query } from '@/lib/db'

export async function POST(request: Request) {
  const body = await request.json()
  
  const result = await query(
    'SELECT crear_itinerario_con_reserva($1, $2, $3, $4, $5, $6)',
    [
      body.cliente_id,
      body.camarote,
      body.vuelo_ids,
      body.hospedaje_ids,
      body.fechas_inicio,
      body.fechas_fin
    ]
  )
  
  return Response.json(result.rows[0].crear_itinerario_con_reserva)
}
```

### Usar en Componente

```typescript
// components/CrearItinerario.tsx
const handleCrearItinerario = async () => {
  const response = await fetch('/api/itinerario/crear', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      cliente_id: user.id,
      vuelo_ids: selectedFlights.map(f => f.id),
      hospedaje_ids: selectedHotels.map(h => h.id),
      fechas_inicio: [startDate],
      fechas_fin: [endDate]
    })
  })
  
  const result = await response.json()
  
  if (result.status === 'success') {
    router.push(`/pago/${result.data.reserva_id}`)
  }
}
```

## 🧪 Testing

### Pruebas Unitarias

El archivo `test_functions.sql` incluye 8 pruebas:

1. ✅ Crear itinerario simple (vuelo + hotel)
2. ✅ Crear itinerario complejo (múltiples servicios)
3. ✅ Registrar método de pago
4. ✅ Obtener detalle de reserva
5. ✅ Procesar pago simple
6. ✅ Procesar pago con millas
7. ✅ Procesar pago con financiamiento
8. ✅ Cancelar reserva con reembolso

### Ejecutar Todas las Pruebas

```bash
psql -U tu_usuario -d viajesucab_db -f SQL/DDL/test_functions.sql
```

## 📝 Formato de Respuesta

Todas las funciones retornan JSON con el siguiente formato:

### Éxito
```json
{
  "status": "success",
  "message": "Descripción del éxito",
  "data": {
    // Datos específicos de la operación
  }
}
```

### Error
```json
{
  "status": "error",
  "message": "Descripción del error"
}
```

## ⚠️ Consideraciones Importantes

### Validaciones
- ✅ Todas las funciones validan que los IDs existan
- ✅ Se verifica que el cliente tenga millas suficientes
- ✅ Se valida que el monto pagado sea correcto
- ✅ Se manejan transacciones automáticamente

### Seguridad
- 🔒 Validar siempre que el cliente autenticado sea el dueño de la reserva
- 🔒 No exponer información sensible de tarjetas en logs
- 🔒 Usar HTTPS para todas las comunicaciones
- 🔒 Implementar rate limiting en las APIs

### Performance
- ⚡ Las funciones usan índices existentes en las tablas
- ⚡ Los cálculos se hacen en la base de datos (más eficiente)
- ⚡ Se minimizan las consultas con agregaciones

## 🐛 Troubleshooting

### Error: "El cliente especificado no existe"
**Solución**: Verificar que el `cliente_id` sea válido
```sql
SELECT * FROM Cliente WHERE Cli_COD = 1;
```

### Error: "Debe incluir al menos un servicio"
**Solución**: Asegurarse de pasar al menos un array de servicios
```sql
-- Incorrecto
SELECT crear_itinerario_con_reserva(p_cliente_id := 1);

-- Correcto
SELECT crear_itinerario_con_reserva(
    p_cliente_id := 1,
    p_vuelo_ids := ARRAY[1]
);
```

### Error: "El cliente no tiene suficientes millas"
**Solución**: Verificar el saldo de millas del cliente
```sql
SELECT Cli_Millas_Acum FROM Cliente WHERE Cli_COD = 1;
```

## 📚 Documentación Adicional

- **Ejemplos detallados**: Ver `EJEMPLOS_FUNCIONES_ITINERARIO.md`
- **Diagramas de flujo**: Ver `FLUJO_ITINERARIO_PAGO.md`
- **Código fuente**: Ver `functions.sql`
- **Pruebas**: Ver `test_functions.sql`

## 🤝 Contribuir

Para agregar nuevas funciones o mejorar las existentes:

1. Seguir el formato JSON de respuesta establecido
2. Incluir manejo de errores con `EXCEPTION`
3. Documentar parámetros y ejemplos
4. Agregar pruebas en `test_functions.sql`

## 📞 Soporte

Para preguntas o problemas:
- Revisar la documentación en los archivos `.md`
- Ejecutar las pruebas para verificar funcionamiento
- Consultar los ejemplos de uso

## 📅 Changelog

### Versión 1.0 (Diciembre 2024)
- ✨ Funciones iniciales creadas
- 📖 Documentación completa
- 🧪 Suite de pruebas
- 🔗 Ejemplos de integración con Next.js

---

**Última actualización**: Diciembre 2024  
**Autor**: Sistema ViajesUCAB  
**Versión**: 1.0

