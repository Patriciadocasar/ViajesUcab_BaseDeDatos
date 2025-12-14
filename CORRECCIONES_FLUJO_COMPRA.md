# ✅ Correcciones del Flujo de Compra de Itinerarios

## 📋 Problemas Identificados y Solucionados

### 🐛 **Problema 1: Cliente_ID Incorrecto**

**Síntoma**: Se estaba enviando el `usuario_ID` (14) en lugar del `cliente_ID` (51) al crear la reserva.

**Causa**: La función `inicio_sesion` no devolvía el `cliente_ID` en la respuesta.

**Solución**:

#### 1. **Actualizar función SQL `inicio_sesion`**

**Archivo**: `SQL/DDL/update_inicio_sesion.sql`

```sql
-- Agregar cliente_ID a la consulta
SELECT Usu_COD, Cliente_Cli_COD, Rol_Rol_COD, ...
INTO v_usuario_id, v_cliente_id, v_rol_id, ...

-- Incluir en la respuesta
resultado := json_build_object(
    'usuario_ID', v_usuario_id,
    'cliente_ID', v_cliente_id,  -- ✅ NUEVO
    'rol_ID', v_rol_id,
    ...
);
```

**Ejecutar en la BD**:
```bash
psql -U tu_usuario -d tu_base_datos -f SQL/DDL/update_inicio_sesion.sql
```

#### 2. **Actualizar interfaz User**

**Archivo**: `lib/user-context.tsx`

```typescript
export interface User {
  id: string           // usuario_ID
  clienteId: string    // ✅ NUEVO - cliente_ID real para reservas
  name: string
  email: string
  role: number
}
```

#### 3. **Actualizar mapeo en login**

```typescript
const loggedUser: User = {
  id: data.usuario_ID.toString(),
  clienteId: data.cliente_ID ? data.cliente_ID.toString() : data.usuario_ID.toString(), // ✅ NUEVO
  name: `${data.primerNombre} ${data.primerApellido}`,
  email: data.email,
  role: data.rol_ID,
}
```

#### 4. **Usar clienteId en las APIs**

**Archivo 1**: `app/clientes/itinerario/comprar/[id]/page.tsx`

```typescript
// Antes
cliente_id: parseInt(user.id),  // ❌ Enviaba usuario_ID

// Después
cliente_id: parseInt(user.clienteId),  // ✅ Envía cliente_ID
```

**Archivo 2**: `app/clientes/itinerario/pago/[id]/page.tsx`

```typescript
// Antes (línea 140)
body: JSON.stringify({
  cliente_id: parseInt(user.id),  // ❌ Enviaba usuario_ID
  ...
})

// Después
body: JSON.stringify({
  cliente_id: parseInt(user.clienteId),  // ✅ Envía cliente_ID
  ...
})
```

---

### 🐛 **Problema 2: Fechas de Inicio/Fin Incorrectas**

**Síntoma**: Las fechas del itinerario no se guardaban correctamente en la tabla `Itinerario`.

**Causa**: Se estaba usando la fecha de cada servicio individual en lugar de las fechas del itinerario completo.

**Solución**:

**Archivo**: `app/clientes/itinerario/comprar/[id]/page.tsx`

**Antes**:
```typescript
itinerary.items.forEach((item) => {
  if (item.type === "vuelo" && item.realId) {
    vuelo_ids.push(item.realId)
    fechas_inicio.push(item.date)      // ❌ Fecha del servicio
    fechas_fin.push(item.date)         // ❌ Fecha del servicio
  }
})
```

**Después**:
```typescript
// Usar las fechas del itinerario completo
const fechaInicioItinerario = itinerary.startDate || itinerary.items[0]?.date
const fechaFinItinerario = itinerary.endDate || itinerary.items[itinerary.items.length - 1]?.date

itinerary.items.forEach((item) => {
  if (item.type === "vuelo" && item.realId) {
    vuelo_ids.push(item.realId)
    fechas_inicio.push(fechaInicioItinerario)  // ✅ Fecha inicio del itinerario
    fechas_fin.push(fechaFinItinerario)        // ✅ Fecha fin del itinerario
  }
})
```

---

### 🐛 **Problema 3: Texto del Botón Confuso**

**Síntoma**: El botón decía "Continuar al Pago" pero en realidad primero crea la reserva.

**Solución**:

**Archivo**: `app/clientes/itinerario/comprar/[id]/page.tsx`

**Antes**:
```tsx
<Button>Continuar al Pago</Button>
```

**Después**:
```tsx
<Button>Realizar Reserva y Comprar</Button>
```

---

## 🔧 **Pasos para Aplicar las Correcciones**

### **1. Actualizar la Base de Datos**

```bash
# Conectar a PostgreSQL y ejecutar el script
psql -U postgres -d viajes_ucab -f SQL/DDL/update_inicio_sesion.sql
```

O ejecutar manualmente en tu cliente SQL:

```sql
-- Copiar y ejecutar el contenido de SQL/DDL/update_inicio_sesion.sql
```

### **2. Cerrar Sesión y Volver a Iniciar**

⚠️ **IMPORTANTE**: Los usuarios que ya iniciaron sesión necesitan cerrar sesión y volver a iniciar para obtener el `cliente_ID`.

1. En la aplicación, hacer logout
2. Volver a hacer login
3. Ahora el `localStorage` tendrá el `clienteId` correcto

### **3. Verificar en Consola del Navegador**

Después de iniciar sesión, abre la consola (F12) y ejecuta:

```javascript
JSON.parse(localStorage.getItem('currentUser'))
```

Deberías ver:
```json
{
  "id": "14",
  "clienteId": "51",  // ✅ Ahora aparece
  "name": "Miguel Apellido",
  "email": "miguel@ejemplo.com",
  "role": 1
}
```

### **4. Probar el Flujo Completo**

1. **Crear Itinerario**:
   - Ir a `/clientes/itinerario`
   - Nombre: "Vacaciones de prueba"
   - Fecha inicio: 15/12/2025
   - Fecha fin: 30/12/2025
   - Agregar un vuelo

2. **Comprar**:
   - Click en "Comprar Itinerario"
   - Verificar que lleva a `/clientes/itinerario/comprar/temp-...`
   - El botón debe decir "Realizar Reserva y Comprar"

3. **Verificar en Consola**:
   - Abrir DevTools (F12) → Console
   - Buscar el log: `🔑 Usuario:`
   - Debe mostrar el `clienteId` correcto (51)

4. **Seleccionar Preferencias**:
   - Seleccionar tipo de asiento/habitación
   - Click en "Realizar Reserva y Comprar"

5. **Verificar en Network**:
   - DevTools → Network → Filtrar por "crear"
   - Ver la petición POST
   - Body debe contener:
     ```json
     {
       "cliente_id": 51,  // ✅ Correcto
       "vuelo_ids": [1],
       "fechas_inicio": ["2025-12-15"],  // ✅ Fecha inicio del itinerario
       "fechas_fin": ["2025-12-30"]      // ✅ Fecha fin del itinerario
     }
     ```

---

## 📊 **Verificar en la Base de Datos**

### **1. Verificar la Reserva**

```sql
SELECT 
    r.res_cod,
    r.res_numero_reserva,
    r.cliente_cli_cod,  -- Debe ser 51
    c.cli_primer_nombre || ' ' || c.cli_apellido as cliente
FROM reserva r
JOIN cliente c ON r.cliente_cli_cod = c.cli_cod
ORDER BY r.res_fecha_hora DESC
LIMIT 1;
```

### **2. Verificar las Fechas del Itinerario**

```sql
SELECT 
    i.iti_cod,
    i.reserva_res_cod,
    i.iti_fecha_inicio,  -- Debe ser 2025-12-15
    i.iti_fecha_fin,     -- Debe ser 2025-12-30
    i.vuelo_vue_cod,
    i.hospedaje_hos_cod
FROM itinerario i
ORDER BY i.iti_cod DESC
LIMIT 5;
```

### **3. Verificar Relación Cliente-Reserva**

```sql
SELECT 
    u.usu_cod as usuario_id,
    u.cliente_cli_cod as cliente_id,
    u.usu_primer_nombre || ' ' || u.usu_primer_apellido as nombre,
    c.cli_cod,
    c.cli_primer_nombre || ' ' || c.cli_apellido as cliente_nombre,
    (SELECT COUNT(*) FROM reserva WHERE cliente_cli_cod = c.cli_cod) as total_reservas
FROM usuario u
JOIN cliente c ON u.cliente_cli_cod = c.cli_cod
WHERE u.usu_correo = 'tu_email@ejemplo.com';  -- Reemplaza con tu email
```

---

## ✅ **Checklist de Verificación**

- [ ] Script SQL ejecutado en la BD
- [ ] Función `inicio_sesion` actualizada
- [ ] Usuario cerró sesión y volvió a iniciar
- [ ] `localStorage` tiene `clienteId`
- [ ] Botón dice "Realizar Reserva y Comprar"
- [ ] Console log muestra `clienteId` correcto
- [ ] Petición POST envía `cliente_id` correcto (51)
- [ ] Petición POST envía fechas del itinerario completo
- [ ] Reserva se crea con `cliente_cli_cod` correcto
- [ ] Itinerario se guarda con fechas correctas

---

## 🎯 **Resultado Esperado**

### **Antes** ❌
```json
{
  "cliente_id": 14,  // ❌ usuario_ID
  "vuelo_ids": [1],
  "fechas_inicio": ["2025-12-12"],  // ❌ Fecha del servicio
  "fechas_fin": ["2025-12-12"]      // ❌ Fecha del servicio
}
```

### **Después** ✅
```json
{
  "cliente_id": 51,  // ✅ cliente_ID
  "vuelo_ids": [1],
  "fechas_inicio": ["2025-12-15"],  // ✅ Fecha inicio itinerario
  "fechas_fin": ["2025-12-30"]      // ✅ Fecha fin itinerario
}
```

---

## 📝 **Archivos Modificados**

1. ✅ `SQL/DDL/update_inicio_sesion.sql` - Script para actualizar la BD
2. ✅ `PROCEDURES Y FUNCTIONS.TXT` - Documentación actualizada
3. ✅ `lib/user-context.tsx` - Interfaz User con clienteId
4. ✅ `app/clientes/itinerario/comprar/[id]/page.tsx` - Usa clienteId y fechas correctas

---

## 🚀 **Próximos Pasos**

1. Ejecutar el script SQL
2. Reiniciar sesión
3. Probar el flujo completo
4. Verificar en la BD

**¡Todas las correcciones están listas!** 🎉

