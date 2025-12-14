# 🎯 Flujo Completo de Itinerario - Actualizado

## 📋 Resumen

Se ha completado y organizado el flujo completo de creación, compra y confirmación de itinerarios dentro de la carpeta `/clientes`.

---

## 🗺️ **Estructura de Rutas Actualizada**

```
app/
└── clientes/
    ├── itinerario/
    │   ├── page.tsx                    ← 1. Crear Itinerario
    │   ├── comprar/
    │   │   └── [id]/
    │   │       └── page.tsx            ← 2. Comprar (Preferencias + Pasajeros)
    │   └── pago/
    │       └── [id]/
    │           └── page.tsx            ← 3. Pago (Métodos de Pago)
    └── confirmacion/
        └── page.tsx                    ← 4. Confirmación (Factura + Boletos)
```

---

## 🔄 **Flujo Completo del Usuario**

### **Paso 1: Crear Itinerario** 
**Ruta**: `/clientes/itinerario`

**Acciones del Usuario**:
- ✅ Ingresar nombre del itinerario
- ✅ Seleccionar fechas de inicio y fin
- ✅ Agregar servicios:
  - Vuelos ✈️
  - Cruceros 🚢
  - Traslados 🚌
  - Hospedajes 🏨
  - Servicios adicionales 🎯
  - Restaurantes 🍽️
- ✅ Ver resumen con:
  - Total de precio
  - Total de millas
  - Huella de carbono

**Validaciones**:
- ✅ Nombre del itinerario requerido
- ✅ Fechas de inicio y fin requeridas
- ✅ Fecha inicio < Fecha fin
- ✅ Al menos un servicio agregado

**Botón**: "Comprar Itinerario"

**Datos Guardados en localStorage**:
```json
{
  "id": "temp-1234567890",
  "name": "Vacaciones de Verano",
  "startDate": "2025-12-15",
  "endDate": "2025-12-30",
  "items": [
    {
      "id": "1",
      "realId": 1,
      "type": "vuelo",
      "title": "VU-1: Brasil → Venezuela",
      "price": 850,
      "millas": 500,
      "huellaCarbono": 2.5
    }
  ],
  "totalPrice": 1100,
  "createdAt": "2024-12-14T10:30:00Z"
}
```

**Navegación**: → `/clientes/itinerario/comprar/temp-1234567890`

---

### **Paso 2: Comprar Itinerario**
**Ruta**: `/clientes/itinerario/comprar/[id]`

**Secciones**:

#### **A. Información del Itinerario**
- Nombre del itinerario
- Fechas de inicio y fin
- Cantidad de servicios

#### **B. Preferencias de Servicios**
Para cada servicio que lo requiera:

**Vuelos**:
- ○ Económica - Ventana ($0)
- ○ Económica - Pasillo ($0)
- ○ Business - Ventana (+$500)
- ○ Business - Pasillo (+$500)

**Cruceros**:
- ○ Camarote Interior ($0)
- ○ Camarote con Vista al Mar (+$300)
- ○ Camarote con Balcón (+$600)
- ○ Suite (+$1,200)

**Traslados**:
- ○ Asiento Estándar ($0)
- ○ Asiento Confort (+$50)
- ○ Asiento Premium (+$100)

**Hospedajes**:
- ○ Habitación Estándar ($0)
- ○ Habitación Deluxe (+$100)
- ○ Suite (+$250)
- ○ Suite Presidencial (+$500)

#### **C. Información de Pasajeros** ⭐ NUEVO
- **Pasajero 1** (obligatorio):
  - Primer Nombre *
  - Segundo Nombre
  - Primer Apellido *
  - Segundo Apellido
  - Fecha de Nacimiento *
  - Estado Civil * (Soltero/Casado/Divorciado)
- **[+ Agregar Pasajero]** (opcional, múltiples)

**Validaciones**:
- ✅ Todas las preferencias de servicios seleccionadas
- ✅ Al menos un pasajero registrado
- ✅ Campos obligatorios de pasajeros completos

**Botón**: "Realizar Reserva y Comprar"

**Proceso Backend**:
1. Llama a `/api/itinerario/crear` → Crea reserva en BD
2. Llama a `/api/pasajeros/registrar` → Registra pasajeros
3. Guarda datos en localStorage

**Datos Guardados en localStorage**:
```json
{
  "itinerary": { ... },
  "selections": {
    "service-1": "economy-window",
    "service-2": "standard"
  },
  "pasajeros": [
    {
      "primerNombre": "Juan",
      "segundoNombre": "Carlos",
      "primerApellido": "Pérez",
      "segundoApellido": "González",
      "fechaNacimiento": "1990-05-15",
      "estadoCivil": "Casado"
    }
  ],
  "reservaInfo": {
    "reserva_id": 51,
    "numero_reserva": 1234,
    "subtotal": 1100,
    "total": 1100
  },
  "customerInfo": {
    "name": "Miguel Apellido",
    "email": "miguel@ejemplo.com",
    "phone": "+58 212-555-0100",
    "passport": "P12345678"
  }
}
```

**Navegación**: → `/clientes/itinerario/pago/temp-1234567890`

---

### **Paso 3: Pago**
**Ruta**: `/clientes/itinerario/pago/[id]`

**Secciones**:

#### **A. Información Personal** (Solo lectura)
- Nombre completo
- Email
- Teléfono
- Dirección

#### **B. Método de Pago** ⭐ NUEVO - 9 Opciones

**Opción 1: 💳 Tarjeta de Crédito**
```
Número de Tarjeta *: [____-____-____-____]
Fecha de Vencimiento *: [YYYY-MM-DD]
CVV *: [___]
Nombre del Titular *: [JUAN PEREZ]
Banco Emisor: [Banco XYZ]
Marca: [Visa ▼]
```

**Opción 2: 💳 Tarjeta de Débito**
```
(Mismos campos que Tarjeta de Crédito)
```

**Opción 3: 📱 Pago Móvil**
```
Número de Referencia *: [_______________]
Banco *: [Banco Provincial ▼]
Fecha de Transacción: [2024-12-14]
```

**Opción 4: 💵 Zelle**
```
Correo/Teléfono Destino *: [ejemplo@email.com]
Banco: [Bank of America]
Número de Referencia *: [_________]
Fecha de Transacción: [2024-12-14]
```

**Opción 5: 🌐 PayPal**
```
Número de Confirmación *: [____________________]
Monto en Billetera: [850.00]
```

**Opción 6: 💰 Zinli**
```
Número de Confirmación *: [____________________]
Monto en Billetera: [850.00]
```

**Opción 7: 🏦 Transferencia Bancaria**
```
Número de Cuenta Destino *: [____________________]
Banco *: [Banco Mercantil]
Número de Referencia *: [_________]
Fecha de Transacción: [2024-12-14]
```

**Opción 8: 💵 Efectivo**
```
Tipo de Moneda: [USD ▼]
Nota: Pago al recoger documentos de viaje
```

**Opción 9: ✈️ Pagar con Millas**
```
Se deducirán automáticamente del saldo
```

#### **C. Resumen del Pedido**
- Itinerario: Nombre
- Servicios: Cantidad
- Subtotal: $X,XXX
- Impuestos: Incluidos
- **Total**: $X,XXX

**Botón**: "Confirmar y Pagar"

**Proceso Backend**:
1. Llama a `/api/metodo-pago/registrar-universal` → Registra método de pago
2. Llama a `/api/pago/procesar` → Procesa el pago
3. Actualiza millas del cliente
4. Limpia localStorage

**Navegación**: → `/clientes/confirmacion?reservation=1234`

---

### **Paso 4: Confirmación** ⭐ ACTUALIZADO
**Ruta**: `/clientes/confirmacion?reservation=1234`

**Secciones**:

#### **A. Mensaje de Éxito**
```
✅ ¡Compra Confirmada!
Tu reserva ha sido procesada exitosamente.
Hemos enviado un correo de confirmación a miguel@ejemplo.com

[🏠 Volver al Inicio] [📥 Imprimir] [📧 Reenviar Email]
```

#### **B. Información de Reserva**
- **Número de Reserva**: 1234
- **Fecha de Compra**: 14 de diciembre de 2024, 10:30
- **Cliente**: Miguel Apellido
- **Pasaporte**: P12345678
- **Total de Servicios**: 2

#### **C. Documentos de Viaje** (Tabs)

**Tab 1: 🧾 Factura**
- Desglose de servicios
- Precios individuales
- Subtotal
- Impuestos
- Total
- Botones: Descargar, Enviar por Email

**Tab 2: 📋 Boletos de Viaje**
- Un boleto por cada servicio
- Código QR
- Información del servicio
- Datos del pasajero
- Número de reserva

#### **D. Información Importante**
- Check-in: 2 horas antes (vuelos) / 1 hora antes (terrestres)
- Documentación: ID oficial + boleto de confirmación
- Cambios y Cancelaciones: 48 horas de anticipación
- Soporte: soporte@viajesucab.com / +58 212-555-0100

---

## 📊 **Datos Almacenados en la Base de Datos**

### **Tabla: Reserva**
```sql
INSERT INTO Reserva (
  Res_Numero_Reserva,
  Res_Milla_Obtenida,
  Res_Fecha_Hora,
  Cliente_Cli_COD,
  Res_Subtotal,
  Res_Total
) VALUES (
  1234,
  500,
  '2024-12-14 10:30:00',
  51,
  1100.00,
  1100.00
);
```

### **Tabla: Itinerario** (uno por servicio)
```sql
INSERT INTO Itinerario (
  Reserva_Res_COD,
  Vuelo_Vue_COD,
  Iti_Fecha_Inicio,
  Iti_Fecha_Fin,
  Iti_Costo_Total,
  Iti_Cant_Milla_Total
) VALUES (
  51,
  1,
  '2025-12-15',
  '2025-12-30',
  850.00,
  500
);
```

### **Tabla: Pasajero** (uno por pasajero)
```sql
INSERT INTO Pasajero (
  Pas_Primer_Nombre,
  Pas_Segundo_Nombre,
  Pas_Primer_Apellido,
  Pas_Segundo_Apellido,
  Pas_Fecha_Nacimiento,
  Pas_Estado_Civil,
  Cliente_Cli_COD,
  Reserva_Res_COD
) VALUES (
  'Juan',
  'Carlos',
  'Pérez',
  'González',
  '1990-05-15',
  'Casado',
  51,
  51
);
```

### **Tabla: Metodo_de_Pago**
```sql
INSERT INTO Metodo_de_Pago (
  Tipo,
  Num_Tarjeta,
  Cod_Seguridad,
  Emisor,
  Marca,
  Fecha_Vencimiento,
  Nombre_Titular
) VALUES (
  'Tarjeta_Credito',
  4111111111111111,
  123,
  'Banco XYZ',
  'Visa',
  '2026-12-31',
  'JUAN PEREZ'
);
```

### **Tabla: Pago**
```sql
INSERT INTO Pago (
  PAG_Fecha_Hora,
  PAG_Total,
  Cli_MP_MP_COD,
  Cli_MP_Cli_COD,
  Reserva_Res_COD
) VALUES (
  '2024-12-14 10:35:00',
  1100.00,
  12,
  51,
  51
);
```

### **Tabla: Cliente** (actualización de millas)
```sql
UPDATE Cliente
SET Cli_Millas_Acum = Cli_Millas_Acum + 500
WHERE Cli_COD = 51;
```

---

## 🔍 **Consultas SQL para Verificar**

### **1. Ver Reserva Completa**
```sql
SELECT 
    r.res_numero_reserva,
    r.res_fecha_hora,
    r.res_total,
    r.res_milla_obtenida,
    c.cli_primer_nombre || ' ' || c.cli_apellido as cliente,
    COUNT(DISTINCT i.iti_cod) as total_itinerarios,
    COUNT(DISTINCT p.pas_cod) as total_pasajeros,
    COUNT(DISTINCT pg.pag_cod) as total_pagos
FROM reserva r
JOIN cliente c ON r.cliente_cli_cod = c.cli_cod
LEFT JOIN itinerario i ON i.reserva_res_cod = r.res_cod
LEFT JOIN pasajero p ON p.reserva_res_cod = r.res_cod
LEFT JOIN pago pg ON pg.reserva_res_cod = r.res_cod
WHERE r.res_numero_reserva = 1234
GROUP BY r.res_cod, r.res_numero_reserva, r.res_fecha_hora, r.res_total, r.res_milla_obtenida, c.cli_primer_nombre, c.cli_apellido;
```

### **2. Ver Pasajeros de una Reserva**
```sql
SELECT 
    p.pas_primer_nombre || ' ' || p.pas_primer_apellido as nombre_completo,
    p.pas_fecha_nacimiento,
    p.pas_estado_civil,
    r.res_numero_reserva
FROM pasajero p
JOIN reserva r ON p.reserva_res_cod = r.res_cod
WHERE r.res_numero_reserva = 1234;
```

### **3. Ver Método de Pago Utilizado**
```sql
SELECT 
    mp.tipo,
    mp.fecha_registro,
    CASE 
        WHEN mp.tipo IN ('Tarjeta_Credito', 'Tarjeta_Debito') THEN 
            mp.nombre_titular || ' - ****' || RIGHT(mp.num_tarjeta::TEXT, 4)
        WHEN mp.tipo = 'Pago_Movil' THEN
            'Ref: ' || mp.num_referencia || ' - ' || mp.banco
        WHEN mp.tipo = 'Zelle' THEN
            mp.num_cuenta_destino || ' - Ref: ' || mp.num_referencia
        ELSE mp.tipo
    END as detalles,
    pg.pag_total,
    r.res_numero_reserva
FROM pago pg
JOIN metodo_de_pago mp ON pg.cli_mp_mp_cod = mp.mp_cod
JOIN reserva r ON pg.reserva_res_cod = r.res_cod
WHERE r.res_numero_reserva = 1234;
```

---

## ✅ **Checklist de Implementación**

- [x] Página de creación de itinerario
- [x] Carga dinámica de servicios desde BD
- [x] Validación de fechas y servicios
- [x] Página de compra con preferencias
- [x] Formulario de pasajeros (múltiples)
- [x] Registro de pasajeros en BD
- [x] Página de pago con 9 métodos
- [x] Registro de métodos de pago en BD
- [x] Procesamiento de pagos
- [x] Actualización de millas
- [x] Página de confirmación
- [x] Generación de factura
- [x] Generación de boletos
- [x] Flujo completo en `/clientes`

---

## 📝 **Archivos del Flujo**

1. ✅ `app/clientes/itinerario/page.tsx` - Crear itinerario
2. ✅ `app/clientes/itinerario/comprar/[id]/page.tsx` - Comprar
3. ✅ `app/clientes/itinerario/pago/[id]/page.tsx` - Pago
4. ✅ `app/clientes/confirmacion/page.tsx` - Confirmación
5. ✅ `components/formulario-pasajeros.tsx` - Formulario de pasajeros
6. ✅ `components/selector-metodo-pago.tsx` - Selector de métodos de pago
7. ✅ `SQL/DDL/funciones_pasajeros_metodos_pago.sql` - Funciones SQL
8. ✅ `app/api/itinerario/crear/route.ts` - API crear reserva
9. ✅ `app/api/pasajeros/registrar/route.ts` - API registrar pasajeros
10. ✅ `app/api/metodo-pago/registrar-universal/route.ts` - API métodos de pago
11. ✅ `app/api/pago/procesar/route.ts` - API procesar pago

---

## 🎉 **Resultado Final**

El flujo completo está implementado y funcional:
1. ✅ Usuario crea itinerario con servicios reales
2. ✅ Usuario selecciona preferencias y registra pasajeros
3. ✅ Sistema crea reserva en BD
4. ✅ Usuario selecciona método de pago (9 opciones)
5. ✅ Sistema procesa pago y actualiza millas
6. ✅ Usuario ve confirmación con factura y boletos

**¡Todo el flujo está en `/clientes` y completamente funcional!** 🚀

