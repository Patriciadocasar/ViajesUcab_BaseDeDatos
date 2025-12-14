# 🎯 Implementación de Pasajeros y Métodos de Pago

## 📋 Resumen

Se han implementado las siguientes funcionalidades:
1. ✅ **Registro de múltiples pasajeros** asociados a una reserva
2. ✅ **Soporte para 12 tipos de métodos de pago** diferentes
3. ✅ **Formulario dinámico de pasajeros** en la página de compra
4. ✅ **API routes** para gestionar pasajeros y métodos de pago

---

## 🗄️ **Funciones SQL Creadas**

### **1. `registrar_pasajeros()`**

Registra múltiples pasajeros asociados a una reserva y cliente.

**Parámetros**:
- `p_cliente_id` (INTEGER) - ID del cliente
- `p_reserva_id` (INTEGER) - ID de la reserva
- `p_pasajeros` (JSONB) - Array de objetos con datos de pasajeros

**Ejemplo**:
```sql
SELECT registrar_pasajeros(
    51,  -- cliente_id
    1,   -- reserva_id
    '[
        {
            "primerNombre": "Juan",
            "segundoNombre": "Carlos",
            "primerApellido": "Pérez",
            "segundoApellido": "González",
            "fechaNacimiento": "1990-05-15",
            "estadoCivil": "Casado"
        },
        {
            "primerNombre": "María",
            "primerApellido": "López",
            "fechaNacimiento": "1992-08-20",
            "estadoCivil": "Casado"
        }
    ]'::jsonb
);
```

**Respuesta**:
```json
{
  "status": "success",
  "message": "Se registraron 2 pasajeros correctamente",
  "data": {
    "pasajeros_ids": [1, 2],
    "cantidad": 2
  }
}
```

---

### **2. `registrar_metodo_pago()`**

Registra cualquier tipo de método de pago de forma universal.

**Parámetros**:
- `p_tipo` (VARCHAR) - Tipo de método de pago
- `p_cliente_id` (INTEGER) - ID del cliente
- `p_datos` (JSONB) - Datos específicos del método

**Tipos Soportados**:
1. `Tarjeta_Credito`
2. `Tarjeta_Debito`
3. `Cheque`
4. `Efectivo`
5. `Milla_MP`
6. `Criptomonedas`
7. `Billetera_Digital`
8. `Zelle`
9. `PayPal`
10. `Zinli`
11. `Pago_Movil`
12. `Transferencia`

**Ejemplos**:

#### **Tarjeta de Crédito/Débito**
```sql
SELECT registrar_metodo_pago(
    'Tarjeta_Credito',
    51,
    '{
        "numTarjeta": "4111111111111111",
        "codSeguridad": "123",
        "emisor": "Banco XYZ",
        "marca": "Visa",
        "fechaVencimiento": "2026-12-31",
        "nombreTitular": "JUAN PEREZ"
    }'::jsonb
);
```

#### **Pago Móvil**
```sql
SELECT registrar_metodo_pago(
    'Pago_Movil',
    51,
    '{
        "numReferencia": "123456789012345",
        "banco": "Banco Provincial",
        "fecha": "2024-12-14"
    }'::jsonb
);
```

#### **Zelle**
```sql
SELECT registrar_metodo_pago(
    'Zelle',
    51,
    '{
        "numCuentaDestino": "1234567890",
        "banco": "Bank of America",
        "fecha": "2024-12-14",
        "numReferencia": "987654321"
    }'::jsonb
);
```

#### **PayPal / Billetera Digital**
```sql
SELECT registrar_metodo_pago(
    'PayPal',
    51,
    '{
        "numConfirmacion": "12345678901234567890",
        "montoBilletera": "850.00"
    }'::jsonb
);
```

#### **Transferencia**
```sql
SELECT registrar_metodo_pago(
    'Transferencia',
    51,
    '{
        "numCuentaDestino": "01020123456789012345",
        "banco": "Banco Mercantil",
        "fecha": "2024-12-14",
        "numReferencia": "987654321"
    }'::jsonb
);
```

#### **Efectivo**
```sql
SELECT registrar_metodo_pago(
    'Efectivo',
    51,
    '{
        "tipoMoneda": "USD"
    }'::jsonb
);
```

---

### **3. `obtener_pasajeros_reserva()`**

Obtiene todos los pasajeros asociados a una reserva.

**Parámetros**:
- `p_reserva_id` (INTEGER) - ID de la reserva

**Ejemplo**:
```sql
SELECT obtener_pasajeros_reserva(1);
```

**Respuesta**:
```json
{
  "status": "success",
  "data": {
    "reserva_id": 1,
    "pasajeros": [
      {
        "pas_cod": 1,
        "primerNombre": "Juan",
        "segundoNombre": "Carlos",
        "primerApellido": "Pérez",
        "segundoApellido": "González",
        "fechaNacimiento": "1990-05-15",
        "estadoCivil": "Casado",
        "clienteId": 51
      }
    ]
  }
}
```

---

## 🌐 **API Routes Creados**

### **1. POST `/api/pasajeros/registrar`**

Registra múltiples pasajeros para una reserva.

**Request Body**:
```json
{
  "cliente_id": 51,
  "reserva_id": 1,
  "pasajeros": [
    {
      "primerNombre": "Juan",
      "segundoNombre": "Carlos",
      "primerApellido": "Pérez",
      "segundoApellido": "González",
      "fechaNacimiento": "1990-05-15",
      "estadoCivil": "Casado"
    }
  ]
}
```

**Response**:
```json
{
  "status": "success",
  "message": "Se registraron 1 pasajeros correctamente",
  "data": {
    "pasajeros_ids": [1],
    "cantidad": 1
  }
}
```

---

### **2. POST `/api/metodo-pago/registrar-universal`**

Registra cualquier tipo de método de pago.

**Request Body (Tarjeta)**:
```json
{
  "tipo": "Tarjeta_Credito",
  "cliente_id": 51,
  "datos": {
    "numTarjeta": "4111111111111111",
    "codSeguridad": "123",
    "emisor": "Banco XYZ",
    "marca": "Visa",
    "fechaVencimiento": "2026-12-31",
    "nombreTitular": "JUAN PEREZ"
  }
}
```

**Request Body (Pago Móvil)**:
```json
{
  "tipo": "Pago_Movil",
  "cliente_id": 51,
  "datos": {
    "numReferencia": "123456789012345",
    "banco": "Banco Provincial",
    "fecha": "2024-12-14"
  }
}
```

**Response**:
```json
{
  "status": "success",
  "message": "Método de pago Tarjeta_Credito registrado correctamente",
  "data": {
    "metodo_pago_id": 12
  }
}
```

---

## 🎨 **Componente de UI: FormularioPasajeros**

Se creó un componente reutilizable para gestionar el registro de pasajeros.

**Ubicación**: `components/formulario-pasajeros.tsx`

**Características**:
- ✅ Agregar/Eliminar pasajeros dinámicamente
- ✅ Validación de campos obligatorios
- ✅ Campos: Primer Nombre, Segundo Nombre, Primer Apellido, Segundo Apellido, Fecha de Nacimiento, Estado Civil
- ✅ Diseño responsive
- ✅ Integración con Shadcn/ui

**Uso**:
```tsx
import { FormularioPasajeros, type Pasajero } from "@/components/formulario-pasajeros"

const [pasajeros, setPasajeros] = useState<Pasajero[]>([
  {
    primerNombre: "",
    segundoNombre: "",
    primerApellido: "",
    segundoApellido: "",
    fechaNacimiento: "",
    estadoCivil: "Soltero",
  },
])

<FormularioPasajeros pasajeros={pasajeros} onChange={setPasajeros} />
```

---

## 🔄 **Flujo Actualizado de Compra**

```
1. /clientes/itinerario
   ↓ Usuario crea itinerario
   
2. Click en "Comprar Itinerario"
   ↓
   
3. /clientes/itinerario/comprar/[id]
   ↓ Usuario completa:
   - ✅ Selección de preferencias (asientos, habitaciones)
   - ✅ Datos de pasajeros (nuevo)
   ↓
   
4. Click en "Realizar Reserva y Comprar"
   ↓ Sistema:
   - Crea reserva en BD
   - Registra pasajeros automáticamente
   ↓
   
5. /clientes/itinerario/pago/[id]
   ↓ Usuario:
   - Selecciona método de pago
   - Completa datos según el tipo
   ↓
   
6. Sistema procesa pago
   ↓
   
7. /confirmacion
   ✅ Compra completada
```

---

## 📝 **Cambios en la Página de Compra**

**Archivo**: `app/clientes/itinerario/comprar/[id]/page.tsx`

### **Cambios Realizados**:

1. ✅ **Importación del componente**:
```tsx
import { FormularioPasajeros, type Pasajero } from "@/components/formulario-pasajeros"
```

2. ✅ **Estado de pasajeros**:
```tsx
const [pasajeros, setPasajeros] = useState<Pasajero[]>([
  {
    primerNombre: "",
    segundoNombre: "",
    primerApellido: "",
    segundoApellido: "",
    fechaNacimiento: "",
    estadoCivil: "Soltero",
  },
])
```

3. ✅ **Validación de pasajeros**:
```tsx
const pasajerosIncompletos = pasajeros.filter(
  (p) => !p.primerNombre || !p.primerApellido || !p.fechaNacimiento || !p.estadoCivil
)

if (pasajerosIncompletos.length > 0) {
  toast({
    title: "Datos de pasajeros incompletos",
    description: "Por favor completa los datos obligatorios de todos los pasajeros",
    variant: "destructive",
  })
  return
}
```

4. ✅ **Registro de pasajeros después de crear reserva**:
```tsx
const pasajerosResponse = await fetch("/api/pasajeros/registrar", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    cliente_id: parseInt(user.clienteId),
    reserva_id: reserva_id,
    pasajeros: pasajeros,
  }),
})
```

5. ✅ **Formulario en el UI**:
```tsx
<FormularioPasajeros pasajeros={pasajeros} onChange={setPasajeros} />
```

---

## 🔧 **Instalación y Configuración**

### **Paso 1: Ejecutar Script SQL**

```bash
psql -U postgres -d viajes_ucab -f SQL/DDL/funciones_pasajeros_metodos_pago.sql
```

O ejecutar manualmente en tu cliente SQL el contenido del archivo.

### **Paso 2: Verificar las Funciones**

```sql
-- Listar las funciones creadas
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
  AND routine_name IN ('registrar_pasajeros', 'registrar_metodo_pago', 'obtener_pasajeros_reserva');
```

### **Paso 3: Reiniciar la Aplicación**

```bash
npm run dev
```

---

## 🧪 **Cómo Probar**

### **1. Probar Registro de Pasajeros**

1. Ir a `/clientes/itinerario`
2. Crear un itinerario con servicios
3. Click en "Comprar Itinerario"
4. En la página de compra:
   - Completar preferencias de servicios
   - **Agregar datos de pasajeros**:
     - Click en "Agregar Pasajero" para más pasajeros
     - Llenar todos los campos obligatorios
5. Click en "Realizar Reserva y Comprar"
6. Verificar en consola:
   - Debe mostrar: `✅ Pasajeros registrados`

### **2. Verificar en la Base de Datos**

```sql
-- Ver pasajeros de la última reserva
SELECT 
    p.pas_cod,
    p.pas_primer_nombre || ' ' || p.pas_primer_apellido as nombre_completo,
    p.pas_fecha_nacimiento,
    p.pas_estado_civil,
    p.reserva_res_cod,
    r.res_numero_reserva
FROM pasajero p
JOIN reserva r ON p.reserva_res_cod = r.res_cod
ORDER BY p.pas_cod DESC
LIMIT 10;
```

### **3. Probar Diferentes Métodos de Pago**

Puedes usar Postman o curl para probar:

```bash
# Tarjeta de Crédito
curl -X POST http://localhost:3000/api/metodo-pago/registrar-universal \
  -H "Content-Type: application/json" \
  -d '{
    "tipo": "Tarjeta_Credito",
    "cliente_id": 51,
    "datos": {
      "numTarjeta": "4111111111111111",
      "codSeguridad": "123",
      "emisor": "Banco XYZ",
      "marca": "Visa",
      "fechaVencimiento": "2026-12-31",
      "nombreTitular": "JUAN PEREZ"
    }
  }'

# Pago Móvil
curl -X POST http://localhost:3000/api/metodo-pago/registrar-universal \
  -H "Content-Type: application/json" \
  -d '{
    "tipo": "Pago_Movil",
    "cliente_id": 51,
    "datos": {
      "numReferencia": "123456789012345",
      "banco": "Banco Provincial",
      "fecha": "2024-12-14"
    }
  }'
```

---

## 📊 **Consultas SQL Útiles**

### **Ver todos los pasajeros de un cliente**
```sql
SELECT 
    c.cli_primer_nombre || ' ' || c.cli_apellido as cliente,
    p.pas_primer_nombre || ' ' || p.pas_primer_apellido as pasajero,
    p.pas_fecha_nacimiento,
    r.res_numero_reserva,
    r.res_fecha_hora
FROM pasajero p
JOIN cliente c ON p.cliente_cli_cod = c.cli_cod
JOIN reserva r ON p.reserva_res_cod = r.res_cod
WHERE c.cli_cod = 51
ORDER BY r.res_fecha_hora DESC;
```

### **Ver métodos de pago de un cliente**
```sql
SELECT 
    mp.mp_cod,
    mp.tipo,
    mp.fecha_registro,
    CASE 
        WHEN mp.tipo IN ('Tarjeta_Credito', 'Tarjeta_Debito') THEN 
            '****' || RIGHT(mp.num_tarjeta::TEXT, 4)
        WHEN mp.tipo = 'Pago_Movil' THEN
            'Ref: ' || mp.num_referencia
        WHEN mp.tipo IN ('PayPal', 'Zinli', 'Billetera_Digital') THEN
            'Conf: ' || mp.num_confirmacion
        ELSE 'N/A'
    END as info
FROM metodo_de_pago mp
JOIN cli_mp cmp ON mp.mp_cod = cmp.metodo_de_pago_mp_cod
WHERE cmp.cliente_cli_cod = 51
ORDER BY mp.fecha_registro DESC;
```

### **Estadísticas de pasajeros por reserva**
```sql
SELECT 
    r.res_numero_reserva,
    r.res_fecha_hora,
    COUNT(p.pas_cod) as total_pasajeros,
    string_agg(p.pas_primer_nombre || ' ' || p.pas_primer_apellido, ', ') as pasajeros
FROM reserva r
LEFT JOIN pasajero p ON r.res_cod = p.reserva_res_cod
WHERE r.cliente_cli_cod = 51
GROUP BY r.res_cod, r.res_numero_reserva, r.res_fecha_hora
ORDER BY r.res_fecha_hora DESC;
```

---

## ✅ **Checklist de Implementación**

- [x] Función SQL `registrar_pasajeros()` creada
- [x] Función SQL `registrar_metodo_pago()` creada
- [x] Función SQL `obtener_pasajeros_reserva()` creada
- [x] API route `/api/pasajeros/registrar` creado
- [x] API route `/api/metodo-pago/registrar-universal` creado
- [x] Componente `FormularioPasajeros` creado
- [x] Página de compra actualizada con formulario de pasajeros
- [x] Validación de datos de pasajeros implementada
- [x] Registro automático de pasajeros después de crear reserva
- [ ] Script SQL ejecutado en la BD
- [ ] Funciones probadas manualmente
- [ ] Flujo completo probado en la aplicación

---

## 📝 **Archivos Creados/Modificados**

1. ✅ `SQL/DDL/funciones_pasajeros_metodos_pago.sql` - Funciones SQL
2. ✅ `app/api/pasajeros/registrar/route.ts` - API route para pasajeros
3. ✅ `app/api/metodo-pago/registrar-universal/route.ts` - API route para métodos de pago
4. ✅ `components/formulario-pasajeros.tsx` - Componente de UI
5. ✅ `app/clientes/itinerario/comprar/[id]/page.tsx` - Página actualizada
6. ✅ `IMPLEMENTACION_PASAJEROS_Y_METODOS_PAGO.md` - Esta documentación

---

## 🚀 **Próximos Pasos**

1. Ejecutar el script SQL en la base de datos
2. Probar el registro de pasajeros en la aplicación
3. Implementar selección de método de pago en la página de pago
4. Agregar validaciones adicionales según sea necesario

**¡Implementación completada!** 🎉

