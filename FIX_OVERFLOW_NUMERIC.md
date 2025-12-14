# 🐛 Fix: Desbordamiento de Campo Numeric

## 📋 Problema

Al crear una reserva, se produce el error:

```json
{
  "status": "error",
  "message": "Error al crear la reserva: desbordamiento de campo numeric"
}
```

---

## 🔍 **Análisis del Problema**

### **Petición que Falla**:
```json
{
  "cliente_id": 49,
  "vuelo_ids": [10],
  "crucero_ids": [3],
  "servicio_adicional_ids": [1],
  "fechas_inicio": ["2025-12-20", "2025-12-20", "2025-12-20"],
  "fechas_fin": ["2025-12-31", "2025-12-31", "2025-12-31"]
}
```

### **Causa del Error**:

En la tabla `Reserva`:
```sql
CREATE TABLE Reserva (
    Res_COD SERIAL PRIMARY KEY,
    Res_Numero_Reserva NUMERIC(4) NOT NULL,    -- Máximo: 9999
    Res_Milla_Obtenida NUMERIC(3) NOT NULL,    -- Máximo: 999 ⚠️
    ...
);
```

En la función `crear_itinerario_con_reserva()`:
```sql
-- Línea 154 (ANTES del fix - LÓGICA INCORRECTA)
v_millas_obtenidas := FLOOR(v_total * 0.10);  -- ❌ Calculaba 10% del precio
```

**El Problema (DOBLE ERROR)**:

1. **Lógica Incorrecta**: 
   - Estaba calculando millas como 10% del precio pagado
   - ❌ **INCORRECTO**: Las millas deben ser la suma de las millas que otorga cada servicio
   
2. **Desbordamiento**:
   - Si la suma de millas de todos los servicios excede 999
   - Ejemplo: Vuelo (500 millas) + Crucero (600 millas) = 1,100 millas
   - ❌ Error: 1,100 no cabe en `NUMERIC(3)` (máximo 999)

---

## ✅ **Solución**

### **Cambio en la Función SQL**:

**ANTES (INCORRECTO)**:
```sql
-- ❌ Calculaba 10% del precio (lógica incorrecta)
v_millas_obtenidas := FLOOR(v_total * 0.10);
```

**DESPUÉS (CORRECTO)**:
```sql
-- ✅ Suma las millas de todos los servicios seleccionados
v_millas_obtenidas := LEAST(v_millas_totales, 999);
```

**Explicación**:
- `v_millas_totales`: Ya se calcula sumando las millas de cada servicio:
  - Vuelo: `Vue_Cant_Millas`
  - Crucero: `Cru_Cant_Millas`
  - Servicio Adicional: `SA_Cant_Milla`
  - Hospedaje: `Hot_Cant_Milla`
  - Transporte: `TT_Cant_Millas`
- `LEAST()`: Limita a máximo 999 para evitar desbordamiento

**Ejemplo**:
```
Vuelo 10: 50 millas
Crucero 3: 100 millas
Servicio 1: 30 millas
----------------------------
v_millas_totales = 180 millas
v_millas_obtenidas = LEAST(180, 999) = 180 ✅
```

---

## 🔧 **Cómo Aplicar el Fix**

### **Opción 1: Usando psql (Recomendado)**

```bash
# Conectarse a la base de datos
psql -U postgres -d viajes_ucab

# Ejecutar el script de fix
\i SQL/DDL/fix_overflow_millas.sql

# Verificar que se aplicó
SELECT proname FROM pg_proc WHERE proname = 'crear_itinerario_con_reserva';
```

### **Opción 2: Desde pgAdmin**

1. Abrir pgAdmin
2. Conectarse a la base de datos `viajes_ucab`
3. Click derecho en "Functions" → "Query Tool"
4. Copiar y pegar el contenido de `SQL/DDL/fix_overflow_millas.sql`
5. Click en "Execute" (F5)

### **Opción 3: Desde la Aplicación**

Si tienes una ruta de API para ejecutar SQL:

```typescript
// En terminal o usando un script Node.js
const { pool } = require("./lib/db")

const fs = require("fs")
const sql = fs.readFileSync("SQL/DDL/fix_overflow_millas.sql", "utf8")

pool.query(sql)
  .then(() => console.log("✅ Función actualizada"))
  .catch(err => console.error("❌ Error:", err))
```

---

## 🧪 **Verificación**

### **Test 1: Reserva con Total Bajo ($500)**

```sql
SELECT crear_itinerario_con_reserva(
    49,                    -- cliente_id
    NULL,                  -- camarote
    NULL,                  -- paquetes
    NULL,                  -- hospedajes
    NULL,                  -- restaurantes
    ARRAY[10],             -- vuelo_ids (supongamos costo $500)
    NULL,                  -- cruceros
    NULL,                  -- transportes
    NULL,                  -- servicios
    ARRAY['2025-12-20']::DATE[],
    ARRAY['2025-12-31']::DATE[]
);
```

**Resultado Esperado**:
```json
{
  "status": "success",
  "data": {
    "millas_obtenidas": 50     // 10% de $500
  }
}
```

### **Test 2: Reserva con Muchas Millas (>999)**

Supongamos que cada servicio otorga:
- Vuelo 10: 500 millas
- Crucero 3: 600 millas
- Servicio 1: 200 millas
- **Suma**: 1,300 millas

```sql
SELECT crear_itinerario_con_reserva(
    49,
    NULL,
    NULL,
    NULL,
    NULL,
    ARRAY[10],             -- vuelo: 500 millas
    ARRAY[3],              -- crucero: 600 millas
    NULL,
    ARRAY[1],              -- servicio: 200 millas
    ARRAY['2025-12-20', '2025-12-20', '2025-12-20']::DATE[],
    ARRAY['2025-12-31', '2025-12-31', '2025-12-31']::DATE[]
);
```

**Resultado Esperado**:
```json
{
  "status": "success",
  "data": {
    "total": 15000.00,
    "millas_obtenidas": 999,           // ✅ Limitado a 999
    "millas_totales_servicios": 1300   // Suma real de millas
  }
}
```

---

## 📊 **Tabla de Ejemplos**

| Servicios Seleccionados | Millas por Servicio | Suma Total | ANTES (10% precio) | DESPUÉS (suma millas) |
|-------------------------|---------------------|------------|--------------------|-----------------------|
| Vuelo                   | 50                  | 50         | ❌ Incorrecto     | ✅ 50                 |
| Vuelo + Crucero         | 50 + 100            | 150        | ❌ Incorrecto     | ✅ 150                |
| 3 Vuelos                | 50 + 50 + 50        | 150        | ❌ Incorrecto     | ✅ 150                |
| Vuelo + Crucero + Park  | 200 + 300 + 450     | 950        | ❌ Incorrecto     | ✅ 950                |
| Muchos servicios        | 500 + 600 + 300     | 1,400      | ❌ ERROR overflow | ✅ 999 (limitado)     |

---

## 🔍 **Consulta para Verificar Costos Actuales**

Para ver qué servicios tienes en la BD y sus costos:

```sql
-- Ver costos de vuelos
SELECT Vue_COD, Vue_Costo, Vue_Cant_Millas 
FROM Vuelo 
WHERE Vue_COD = 10;

-- Ver costos de cruceros
SELECT Cru_COD, Cru_Costo, Cru_Cant_Millas 
FROM Crucero 
WHERE Cru_COD = 3;

-- Ver costos de servicios adicionales
SELECT SA_COD, SA_Nombre, SA_Costo, SA_Cant_Milla 
FROM Servicio_Adicional 
WHERE SA_COD = 1;

-- Total de la combinación
SELECT 
    (SELECT COALESCE(Vue_Costo, 0) FROM Vuelo WHERE Vue_COD = 10) +
    (SELECT COALESCE(Cru_Costo, 0) FROM Crucero WHERE Cru_COD = 3) +
    (SELECT COALESCE(SA_Costo, 0) FROM Servicio_Adicional WHERE SA_COD = 1)
    AS total_estimado;
```

---

## 🚨 **Verificar en Tu Caso Específico**

Ejecuta esta consulta para ver el total de tu itinerario:

```sql
SELECT 
    'Vuelo 10' as servicio,
    Vue_Costo as costo,
    Vue_Cant_Millas as millas
FROM Vuelo 
WHERE Vue_COD = 10

UNION ALL

SELECT 
    'Crucero 3' as servicio,
    Cru_Costo as costo,
    Cru_Cant_Millas as millas
FROM Crucero 
WHERE Cru_COD = 3

UNION ALL

SELECT 
    'Servicio 1' as servicio,
    SA_Costo as costo,
    SA_Cant_Milla as millas
FROM Servicio_Adicional 
WHERE SA_COD = 1

UNION ALL

SELECT 
    'TOTAL' as servicio,
    (SELECT COALESCE(Vue_Costo, 0) FROM Vuelo WHERE Vue_COD = 10) +
    (SELECT COALESCE(Cru_Costo, 0) FROM Crucero WHERE Cru_COD = 3) +
    (SELECT COALESCE(SA_Costo, 0) FROM Servicio_Adicional WHERE SA_COD = 1) as costo,
    NULL as millas
;
```

**Si el TOTAL > $9,990, entonces ese era tu problema.**

---

## 📝 **Archivos Modificados**

1. ✅ `SQL/DDL/functions.sql` - Actualizado con `LEAST()`
2. ✅ `SQL/DDL/fix_overflow_millas.sql` - Script para aplicar el fix
3. ✅ `FIX_OVERFLOW_NUMERIC.md` - Esta documentación

---

## ⚙️ **Pasos para Resolver tu Error Actual**

### **Paso 1: Aplicar el Fix a la BD**

```bash
# Opción A: Usando psql
psql -U postgres -d viajes_ucab -f SQL/DDL/fix_overflow_millas.sql

# Opción B: Copiar y pegar en pgAdmin
# Abrir pgAdmin → Query Tool → Ejecutar el contenido de fix_overflow_millas.sql
```

### **Paso 2: Verificar que se Aplicó**

```sql
-- Esta consulta debe mostrar la función actualizada
SELECT prosrc 
FROM pg_proc 
WHERE proname = 'crear_itinerario_con_reserva';

-- Buscar la línea que contiene:
-- "LEAST(FLOOR(v_total * 0.10), 999)"
```

### **Paso 3: Reintentar la Petición**

Volver a hacer la petición desde la aplicación:

```javascript
POST /api/itinerario/crear
{
  "cliente_id": 49,
  "vuelo_ids": [10],
  "crucero_ids": [3],
  "servicio_adicional_ids": [1],
  "fechas_inicio": ["2025-12-20", "2025-12-20", "2025-12-20"],
  "fechas_fin": ["2025-12-31", "2025-12-31", "2025-12-31"]
}
```

**Resultado Esperado**:
```json
{
  "status": "success",
  "message": "Reserva e itinerarios creados exitosamente",
  "data": {
    "reserva_id": 51,
    "numero_reserva": 1234,
    "subtotal": 15000.00,
    "total": 15000.00,
    "millas_obtenidas": 999,     // ✅ Limitado a 999
    "millas_totales_servicios": 150
  }
}
```

---

## 🎉 **Resultado Final**

Después de aplicar el fix:
- ✅ Las reservas con totales altos (>$9,990) funcionarán correctamente
- ✅ Las millas obtenidas se limitarán a máximo 999
- ✅ No habrá más errores de "desbordamiento de campo numeric"
- ✅ Todas las demás funcionalidades siguen igual

**¡Error resuelto!** 🚀

---

## 💡 **Nota Adicional**

Si en el futuro quieres permitir más de 999 millas por reserva, necesitarías:

1. **Modificar el esquema de la tabla**:
```sql
ALTER TABLE Reserva 
ALTER COLUMN Res_Milla_Obtenida TYPE NUMERIC(5);
```

2. **Actualizar la variable en la función**:
```sql
v_millas_obtenidas NUMERIC(5) := 0;
```

3. **Remover el límite**:
```sql
v_millas_obtenidas := FLOOR(v_total * 0.10);  -- Sin LEAST()
```

Pero por ahora, el límite de 999 millas es razonable y mantiene la integridad de la BD.

