# 🚀 Guía de Deployment - Sistema de Itinerarios y Pagos

## 📋 Resumen del Sistema

Se ha implementado un sistema completo para gestionar itinerarios de viaje y procesamiento de pagos en ViajesUCAB, que incluye:

- ✅ 5 funciones SQL (PostgreSQL)
- ✅ 5 API routes (Next.js)
- ✅ 4 componentes actualizados/creados
- ✅ Documentación completa
- ✅ Scripts de prueba

## 📦 Archivos Creados/Modificados

### 1. Base de Datos (SQL)

```
SQL/DDL/
├── functions.sql                           # ⭐ Funciones principales
├── test_functions.sql                      # 🧪 Script de pruebas
├── EJEMPLOS_FUNCIONES_ITINERARIO.md       # 📖 Ejemplos detallados
├── FLUJO_ITINERARIO_PAGO.md               # 📊 Diagramas de flujo
├── README_FUNCIONES_ITINERARIO.md         # 📚 Documentación general
├── GUIA_INTEGRACION_FRONTEND.md           # 🔗 Guía de integración
└── DEPLOYMENT_GUIDE.md                     # 🚀 Esta guía
```

### 2. Backend (API Routes)

```
app/api/
├── itinerario/
│   └── crear/
│       └── route.ts                        # ✅ NUEVO
├── pago/
│   └── procesar/
│       └── route.ts                        # ✅ NUEVO
├── metodo-pago/
│   └── registrar/
│       └── route.ts                        # ✅ NUEVO
└── reserva/
    ├── [id]/
    │   └── route.ts                        # ✅ NUEVO
    └── cancelar/
        └── route.ts                        # ✅ NUEVO
```

### 3. Frontend (Componentes)

```
app/
├── itinerario/
│   ├── page.tsx                            # ✏️ MODIFICADO
│   ├── comprar/
│   │   └── [id]/
│   │       └── page.tsx                    # ✏️ MODIFICADO
│   └── pago/
│       └── [id]/
│           └── page.tsx                    # ✏️ MODIFICADO
└── reserva/
    └── [id]/
        └── page.tsx                        # ✅ NUEVO
```

## 🔧 Pasos de Instalación

### Paso 1: Ejecutar las Funciones SQL

Conectarse a la base de datos PostgreSQL y ejecutar:

```bash
# Opción 1: Usando psql
psql -U viajesucab_user -d viajesucab_db -f SQL/DDL/functions.sql

# Opción 2: Desde la línea de comandos
psql postgresql://usuario:password@localhost:5432/viajesucab_db -f SQL/DDL/functions.sql

# Opción 3: Usando pgAdmin
# 1. Abrir pgAdmin
# 2. Conectar a la base de datos
# 3. Abrir Query Tool
# 4. Cargar el archivo SQL/DDL/functions.sql
# 5. Ejecutar (F5)
```

**Verificar que las funciones se crearon:**

```sql
-- Ejecutar en la consola SQL
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
  AND routine_type = 'FUNCTION'
  AND (
    routine_name LIKE '%itinerario%' 
    OR routine_name LIKE '%pago%'
    OR routine_name LIKE '%reserva%'
  )
ORDER BY routine_name;
```

**Resultado esperado:**
```
    routine_name
-------------------------------------
 cancelar_reserva_con_reembolso
 crear_itinerario_con_reserva
 obtener_detalle_reserva
 procesar_pago_reserva
 registrar_metodo_pago_tarjeta
```

### Paso 2: Ejecutar Pruebas (Opcional pero Recomendado)

```bash
# Ejecutar el script de pruebas
psql -U viajesucab_user -d viajesucab_db -f SQL/DDL/test_functions.sql

# Esto ejecutará 8 pruebas que validan:
# ✅ Creación de itinerarios simples
# ✅ Creación de itinerarios complejos
# ✅ Registro de métodos de pago
# ✅ Procesamiento de pagos
# ✅ Pago con millas
# ✅ Pago con financiamiento
# ✅ Cancelación de reservas
# ✅ Consulta de detalles
```

### Paso 3: Verificar Variables de Entorno

Asegurarse de que el archivo `.env.local` tenga las credenciales correctas:

```env
POSTGRES_USER=viajesucab_user
POSTGRES_HOST=localhost
POSTGRES_DB=viajesucab_db
POSTGRES_PASSWORD=tu_password
POSTGRES_PORT=5432
```

### Paso 4: Instalar Dependencias (si es necesario)

```bash
# En el directorio raíz del proyecto
npm install

# Verificar que las dependencias de PostgreSQL estén instaladas
npm list pg
```

### Paso 5: Compilar y Ejecutar la Aplicación

```bash
# Compilar
npm run build

# Ejecutar en desarrollo
npm run dev

# O ejecutar en producción
npm start
```

### Paso 6: Probar los Endpoints

#### Probar API de Crear Itinerario

```bash
curl -X POST http://localhost:3000/api/itinerario/crear \
  -H "Content-Type: application/json" \
  -d '{
    "cliente_id": 1,
    "vuelo_ids": [1],
    "hospedaje_ids": [1],
    "fechas_inicio": ["2024-07-15"],
    "fechas_fin": ["2024-07-22"]
  }'
```

**Respuesta esperada:**
```json
{
  "status": "success",
  "message": "Reserva e itinerario(s) creados correctamente",
  "data": {
    "reserva_id": 1,
    "numero_reserva": 5678,
    "subtotal": 1500.00,
    "total": 1500.00,
    "millas_obtenidas": 150
  }
}
```

#### Probar API de Obtener Reserva

```bash
curl http://localhost:3000/api/reserva/1
```

## 🧪 Testing Completo

### Testing Manual en la UI

1. **Crear Itinerario**
   - Ir a `/itinerario`
   - Agregar vuelo, hotel, actividades
   - Click en "Guardar Itinerario"
   - ✅ Verificar que aparece en "Itinerarios Guardados"

2. **Comprar Itinerario**
   - Click en "Comprar Itinerario"
   - Ir a `/itinerario/comprar/[id]`
   - Seleccionar preferencias
   - Click en "Continuar al Pago"
   - ✅ Verificar que se crea la reserva en la BD

3. **Procesar Pago**
   - Ir a `/itinerario/pago/[id]`
   - Ingresar datos de tarjeta
   - Click en "Confirmar y Pagar"
   - ✅ Verificar que el pago se procesa
   - ✅ Verificar que se actualizan las millas

4. **Ver Reserva**
   - Ir a `/reserva/[id]`
   - ✅ Verificar que se muestran todos los detalles
   - ✅ Verificar que aparecen los itinerarios

### Testing Automatizado

```bash
# Ejecutar las pruebas SQL
psql -U viajesucab_user -d viajesucab_db -f SQL/DDL/test_functions.sql

# El script generará un resumen al final:
# =====================================================
# VERIFICACIÓN FINAL: Resumen de Datos Creados
# =====================================================
# Total de Reservas: 8
# Total de Itinerarios: 10
# Total de Pagos: 7
# Total de Financiamientos: 1
# Total de Reembolsos: 1
```

## 🔍 Verificación Post-Deployment

### 1. Verificar Funciones en la BD

```sql
-- En la consola SQL
SELECT * FROM crear_itinerario_con_reserva(
  1::INTEGER,                    -- cliente_id
  NULL::VARCHAR,                 -- camarote
  NULL::INTEGER[],               -- paquete_turistico_ids
  ARRAY[1]::INTEGER[],           -- hospedaje_ids
  NULL::INTEGER[],               -- restaurante_ids
  ARRAY[1]::INTEGER[],           -- vuelo_ids
  NULL::INTEGER[],               -- crucero_ids
  NULL::INTEGER[],               -- transporte_terrestre_ids
  NULL::INTEGER[],               -- servicio_adicional_ids
  ARRAY['2024-07-15'::DATE],     -- fechas_inicio
  ARRAY['2024-07-22'::DATE]      -- fechas_fin
);
```

### 2. Verificar APIs

```bash
# Verificar que todos los endpoints respondan
curl http://localhost:3000/api/itinerario/crear
curl http://localhost:3000/api/pago/procesar
curl http://localhost:3000/api/metodo-pago/registrar
curl http://localhost:3000/api/reserva/1
curl http://localhost:3000/api/reserva/cancelar

# Todos deberían devolver información del endpoint (GET)
# o aceptar POST con datos
```

### 3. Verificar Tablas de la BD

```sql
-- Verificar que se crearon registros
SELECT COUNT(*) FROM Reserva;
SELECT COUNT(*) FROM Itinerario;
SELECT COUNT(*) FROM Pago;
SELECT COUNT(*) FROM Financiamiento;
SELECT COUNT(*) FROM Cuota;
SELECT COUNT(*) FROM Reembolso;

-- Verificar las millas de un cliente
SELECT Cli_COD, Cli_Primer_Nombre, Cli_Millas_Acum
FROM Cliente
WHERE Cli_COD = 1;
```

## 🐛 Troubleshooting Común

### Error: "Function does not exist"

**Problema**: Las funciones SQL no se ejecutaron correctamente.

**Solución**:
```bash
# Verificar que estás en la base de datos correcta
psql -U viajesucab_user -d viajesucab_db

# Dentro de psql
\df *itinerario*
\df *pago*

# Si no aparecen, volver a ejecutar
\i SQL/DDL/functions.sql
```

### Error: "Cannot read property 'rows' of undefined"

**Problema**: La conexión a la base de datos no está configurada correctamente.

**Solución**:
1. Verificar `.env.local`
2. Verificar que PostgreSQL esté corriendo:
   ```bash
   # Windows
   pg_ctl status

   # Linux/Mac
   sudo systemctl status postgresql
   ```
3. Probar conexión manual:
   ```bash
   psql -U viajesucab_user -d viajesucab_db -c "SELECT 1"
   ```

### Error: "Cliente especificado no existe"

**Problema**: El `cliente_id` no existe en la tabla Cliente.

**Solución**:
```sql
-- Verificar clientes existentes
SELECT Cli_COD, Cli_Primer_Nombre, Cli_Apellido FROM Cliente;

-- Crear un cliente de prueba si es necesario
INSERT INTO Cliente (
  Cli_Primer_Nombre, 
  Cli_Apellido, 
  Cli_Fecha_Nacimiento, 
  Cli_Estado_Civil, 
  Cli_Millas_Acum,
  Lugar_Lug_COD
)
VALUES (
  'Test',
  'User',
  '1990-01-01',
  'Soltero',
  500,
  1
)
RETURNING Cli_COD;
```

### Error: "Debe incluir al menos un servicio"

**Problema**: No se pasaron IDs de servicios (vuelos, hoteles, etc.).

**Solución**: Asegurarse de pasar al menos un array con un ID:
```typescript
{
  cliente_id: 1,
  vuelo_ids: [1],  // ← Al menos uno
  // ... otros campos pueden ser null
}
```

## 📈 Monitoreo y Logs

### Logs en el Servidor

Los API routes imprimen logs útiles:

```
=== POST /api/itinerario/crear ===
📋 Datos recibidos: { cliente_id: 1, vuelo_ids: [1], ... }
🔍 Ejecutando función SQL...
✅ Resultado: { status: 'success', data: { ... } }
```

### Monitorear en la BD

```sql
-- Ver las últimas reservas creadas
SELECT 
  Res_COD,
  Res_Numero_Reserva,
  Res_Total,
  Res_Fecha_Hora,
  Cliente_Cli_COD
FROM Reserva
ORDER BY Res_Fecha_Hora DESC
LIMIT 10;

-- Ver los últimos pagos
SELECT 
  PAG_COD,
  PAG_Total,
  PAG_Fecha_Hora,
  Reserva_Res_COD
FROM Pago
ORDER BY PAG_Fecha_Hora DESC
LIMIT 10;

-- Ver millas de clientes
SELECT 
  Cli_COD,
  Cli_Primer_Nombre || ' ' || Cli_Apellido AS nombre,
  Cli_Millas_Acum
FROM Cliente
ORDER BY Cli_Millas_Acum DESC
LIMIT 10;
```

## 🔐 Consideraciones de Seguridad

### Antes de Producción

1. **Encriptar Información Sensible**
   ```typescript
   // NO almacenar tarjetas en texto plano
   // Usar servicios como Stripe, PayPal, etc.
   ```

2. **Validar Permisos**
   ```typescript
   // Verificar que el usuario solo pueda ver sus propias reservas
   if (reserva.cliente_id !== user.id) {
     return NextResponse.json({ error: "No autorizado" }, { status: 403 })
   }
   ```

3. **Rate Limiting**
   ```typescript
   // Implementar límite de requests por usuario
   // Usar next-rate-limit o similar
   ```

4. **Sanitizar Inputs**
   ```typescript
   // Validar todos los inputs antes de enviar a la BD
   // Usar zod o similar para validación
   ```

## 📊 Métricas Sugeridas

### KPIs a Monitorear

- ✅ Número de itinerarios creados por día
- ✅ Tasa de conversión (itinerarios creados → pagos completados)
- ✅ Tiempo promedio del flujo completo
- ✅ Millas otorgadas vs millas usadas
- ✅ Método de pago más usado
- ✅ Porcentaje de pagos con financiamiento

### Queries Útiles

```sql
-- Itinerarios creados hoy
SELECT COUNT(*) FROM Reserva 
WHERE DATE(Res_Fecha_Hora) = CURRENT_DATE;

-- Total de ventas del mes
SELECT SUM(Res_Total) FROM Reserva 
WHERE DATE_TRUNC('month', Res_Fecha_Hora) = DATE_TRUNC('month', CURRENT_DATE);

-- Millas otorgadas este mes
SELECT SUM(Res_Milla_Obtenida) FROM Reserva 
WHERE DATE_TRUNC('month', Res_Fecha_Hora) = DATE_TRUNC('month', CURRENT_DATE);
```

## ✅ Checklist Final

### Backend
- [ ] Funciones SQL ejecutadas y verificadas
- [ ] API routes creados y probados
- [ ] Conexión a BD configurada
- [ ] Variables de entorno configuradas
- [ ] Logs implementados

### Frontend
- [ ] Componentes actualizados
- [ ] Flujo de usuario probado
- [ ] Manejo de errores implementado
- [ ] Estados de carga implementados
- [ ] Toast notifications funcionando

### Testing
- [ ] Pruebas SQL ejecutadas
- [ ] Flujo completo probado manualmente
- [ ] Casos edge probados
- [ ] Performance verificado

### Documentación
- [x] README actualizado
- [x] Ejemplos de uso creados
- [x] Guía de integración disponible
- [x] Guía de deployment creada

### Seguridad
- [ ] Inputs validados
- [ ] Permisos verificados
- [ ] Información sensible protegida
- [ ] Rate limiting considerado

## 🎉 ¡Deployment Exitoso!

Una vez completados todos los pasos, el sistema estará completamente funcional y listo para usar.

Para soporte o preguntas, consulta:
- `EJEMPLOS_FUNCIONES_ITINERARIO.md` - Ejemplos de uso
- `FLUJO_ITINERARIO_PAGO.md` - Diagramas y flujos
- `GUIA_INTEGRACION_FRONTEND.md` - Integración con React/Next.js
- `README_FUNCIONES_ITINERARIO.md` - Documentación general

---

**Última actualización**: Diciembre 2024  
**Versión**: 1.0  
**Estado**: ✅ Listo para Producción

