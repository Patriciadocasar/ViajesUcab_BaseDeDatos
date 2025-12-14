# 💳 Sistema de Múltiples Métodos de Pago

## 📋 Resumen

Se ha implementado un sistema completo que permite al usuario **combinar múltiples métodos de pago** para cubrir el total de una reserva.

---

## ✨ **Características Principales**

### **1. Múltiples Métodos de Pago**
- ✅ El usuario puede agregar hasta **5 métodos de pago** diferentes
- ✅ Cada método puede cubrir una **porción del total**
- ✅ **Validación automática** de que la suma cubra el total exacto
- ✅ **Indicador visual** de progreso del monto asignado

### **2. Ejemplos de Uso**

#### **Ejemplo 1: Dividir 50/50**
```
Total a pagar: $1,100

Método 1: Tarjeta de Crédito - $550
Método 2: Pago Móvil - $550
```

#### **Ejemplo 2: Tres métodos**
```
Total a pagar: $1,100

Método 1: Tarjeta de Crédito - $500
Método 2: Millas - $300
Método 3: Zelle - $300
```

#### **Ejemplo 3: Pago completo con un método**
```
Total a pagar: $1,100

Método 1: Tarjeta de Crédito - $1,100
```

---

## 🎨 **Componente: SelectorMetodosPagoMultiple**

**Ubicación**: `components/selector-metodos-pago-multiple.tsx`

### **Props**:
```typescript
interface Props {
  metodos: MetodoPagoConMonto[]
  totalRequerido: number
  onChange: (metodos: MetodoPagoConMonto[]) => void
}
```

### **Interfaz MetodoPagoConMonto**:
```typescript
interface MetodoPagoConMonto {
  id: string                    // ID único del método en el formulario
  tipo: TipoMetodoPago          // Tipo de método de pago
  monto: number                 // Monto asignado a este método
  datos: DatosMetodoPago        // Datos específicos (tarjeta, referencia, etc.)
}
```

### **Funcionalidades**:

#### **A. Indicador de Progreso**
```
┌─────────────────────────────────────────┐
│ Total asignado: $800.00                 │
│ Monto restante: $300.00                 │
│ [████████████░░░░░░] 73%                │
└─────────────────────────────────────────┘
```

Cuando está completo:
```
┌─────────────────────────────────────────┐
│ Total asignado: $1,100.00               │
│ Monto restante: $0.00                   │
│ [████████████████████] 100%             │
│ ✓ Total completo                        │
└─────────────────────────────────────────┘
```

#### **B. Botones de Ayuda**
- **"Dividir Equitativo"**: Divide el total entre todos los métodos
- **"Completar Total"**: Asigna el monto restante a ese método

#### **C. Agregar/Eliminar Métodos**
- Botón "Agregar Método de Pago" (máximo 5)
- Botón "X" para eliminar (mínimo 1)

---

## 🔄 **Flujo de Procesamiento**

### **1. Usuario Completa Formulario**
```javascript
metodosPago = [
  {
    id: "metodo-1",
    tipo: "Tarjeta_Credito",
    monto: 550,
    datos: {
      numTarjeta: "4111111111111111",
      codSeguridad: "123",
      nombreTitular: "JUAN PEREZ",
      fechaVencimiento: "2026-12-31"
    }
  },
  {
    id: "metodo-2",
    tipo: "Pago_Movil",
    monto: 550,
    datos: {
      numReferencia: "123456789012345",
      banco: "Banco Provincial"
    }
  }
]
```

### **2. Validación Antes de Enviar**
```javascript
const totalAsignado = metodosPago.reduce((sum, m) => sum + m.monto, 0)
const diferencia = Math.abs(totalPrice - totalAsignado)

if (diferencia > 0.01) {
  // ❌ Error: Monto incompleto
  toast({ title: "Faltan $X.XX por asignar" })
  return
}

// ✅ Total completo, continuar
```

### **3. Registro de Métodos de Pago**
```javascript
// Para cada método, hacer una petición
for (const metodo of metodosPago) {
  const response = await fetch("/api/metodo-pago/registrar-universal", {
    method: "POST",
    body: JSON.stringify({
      tipo: metodo.tipo,
      cliente_id: 51,
      datos: metodo.datos
    })
  })
  
  const result = await response.json()
  metodosRegistrados.push({
    metodo_pago_id: result.data.metodo_pago_id,
    monto: metodo.monto
  })
}

// Resultado:
metodosRegistrados = [
  { metodo_pago_id: 12, monto: 550 },
  { metodo_pago_id: 13, monto: 550 }
]
```

### **4. Procesamiento de Pagos**
```javascript
// Para cada método registrado, procesar el pago
for (const metodoRegistrado of metodosRegistrados) {
  const response = await fetch("/api/pago/procesar", {
    method: "POST",
    body: JSON.stringify({
      reserva_id: 51,
      cliente_id: 51,
      metodo_pago_id: metodoRegistrado.metodo_pago_id,
      monto_pago: metodoRegistrado.monto,
      pago_con_millas: false,
      cantidad_millas: 0
    })
  })
  
  pagosRealizados.push(await response.json())
}

// Resultado: 2 registros en la tabla Pago
```

---

## 📊 **Registros en la Base de Datos**

### **Tabla: Metodo_de_Pago** (2 registros)
```sql
-- Método 1: Tarjeta
INSERT INTO Metodo_de_Pago (Tipo, Num_Tarjeta, ...) 
VALUES ('Tarjeta_Credito', 4111111111111111, ...);
-- Retorna: MP_COD = 12

-- Método 2: Pago Móvil
INSERT INTO Metodo_de_Pago (Tipo, Num_Referencia, Banco) 
VALUES ('Pago_Movil', '123456789012345', 'Banco Provincial');
-- Retorna: MP_COD = 13
```

### **Tabla: Cli_MP** (2 registros)
```sql
INSERT INTO Cli_MP (Cliente_Cli_COD, Metodo_de_Pago_MP_COD)
VALUES (51, 12), (51, 13);
```

### **Tabla: Pago** (2 registros)
```sql
-- Pago 1
INSERT INTO Pago (PAG_Total, Cli_MP_MP_COD, Cli_MP_Cli_COD, Reserva_Res_COD)
VALUES (550.00, 12, 51, 51);

-- Pago 2
INSERT INTO Pago (PAG_Total, Cli_MP_MP_COD, Cli_MP_Cli_COD, Reserva_Res_COD)
VALUES (550.00, 13, 51, 51);
```

---

## 🧪 **Cómo Probar**

### **Escenario 1: Pago con 2 Métodos (50/50)**

1. **Crear itinerario** de $1,100
2. **Ir a pago**
3. **Configurar Método 1**:
   - Tipo: Tarjeta de Crédito
   - Monto: $550
   - Completar datos de tarjeta
4. **Click** "Agregar Método de Pago"
5. **Configurar Método 2**:
   - Tipo: Pago Móvil
   - Monto: $550
   - Completar referencia y banco
6. **Verificar** que el indicador muestre "Total completo"
7. **Click** "Confirmar y Pagar"

**Resultado Esperado**:
- ✅ 2 métodos registrados en `Metodo_de_Pago`
- ✅ 2 pagos registrados en `Pago`
- ✅ Suma total: $1,100
- ✅ Redirect a confirmación

### **Escenario 2: Pago con 3 Métodos**

1. **Configurar Método 1**: Tarjeta - $500
2. **Agregar Método 2**: Millas - $300
3. **Agregar Método 3**: Zelle - $300
4. **Click** "Dividir Equitativo" para distribuir automáticamente
5. **Confirmar y Pagar**

### **Escenario 3: Pago con 1 Método (100%)**

1. **Método 1**: Tarjeta de Crédito - $1,100
2. **Confirmar y Pagar**

---

## 📊 **Consultas SQL para Verificar**

### **Ver todos los pagos de una reserva**:
```sql
SELECT 
    p.pag_cod,
    p.pag_total,
    mp.tipo,
    CASE 
        WHEN mp.tipo IN ('Tarjeta_Credito', 'Tarjeta_Debito') THEN 
            '****' || RIGHT(mp.num_tarjeta::TEXT, 4)
        WHEN mp.tipo = 'Pago_Movil' THEN
            'Ref: ' || mp.num_referencia
        WHEN mp.tipo = 'Zelle' THEN
            mp.num_cuenta_destino
        ELSE mp.tipo
    END as detalles
FROM pago p
JOIN metodo_de_pago mp ON p.cli_mp_mp_cod = mp.mp_cod
WHERE p.reserva_res_cod = 51
ORDER BY p.pag_cod;
```

**Resultado Esperado**:
```
pag_cod | pag_total | tipo              | detalles
--------|-----------|-------------------|------------------
123     | 550.00    | Tarjeta_Credito   | ****1111
124     | 550.00    | Pago_Movil        | Ref: 123456...
```

### **Sumar todos los pagos de una reserva**:
```sql
SELECT 
    r.res_numero_reserva,
    r.res_total as total_reserva,
    SUM(p.pag_total) as total_pagado,
    COUNT(p.pag_cod) as cantidad_pagos,
    r.res_total - SUM(p.pag_total) as diferencia
FROM reserva r
LEFT JOIN pago p ON p.reserva_res_cod = r.res_cod
WHERE r.res_cod = 51
GROUP BY r.res_cod, r.res_numero_reserva, r.res_total;
```

**Resultado Esperado**:
```
numero_reserva | total_reserva | total_pagado | cantidad_pagos | diferencia
---------------|---------------|--------------|----------------|------------
1234           | 1100.00       | 1100.00      | 2              | 0.00
```

---

## 🎨 **Vista de la Interfaz**

### **Indicador de Progreso**:
```
┌─────────────────────────────────────────────────┐
│ Métodos de Pago                                 │
│ Puedes dividir el pago en múltiples métodos.   │
│ Total a pagar: $1,100.00                        │
├─────────────────────────────────────────────────┤
│ Total asignado: $800.00                         │
│ Monto restante: $300.00                         │
│ [████████████████░░░░] 73%                      │
│                                                 │
│ [+ Agregar Método de Pago]                     │
└─────────────────────────────────────────────────┘
```

### **Formulario de Método**:
```
┌─────────────────────────────────────────────────┐
│ Método 1                                    [X] │
│ Asigna un monto para este método de pago       │
├─────────────────────────────────────────────────┤
│ Monto a Pagar con este Método *                │
│ $ [550.00_____________________________]        │
│ [Dividir Equitativo] [Completar Total]         │
│                                                 │
│ Tipo de Método de Pago *                       │
│ [💳 Tarjeta de Crédito ▼]                      │
│                                                 │
│ ─────────────────────────────────────────────  │
│                                                 │
│ Número de Tarjeta *                            │
│ [4111 1111 1111 1111__________________]        │
│                                                 │
│ Fecha Venc. *        CVV *                     │
│ [2026-12-31]         [123]                     │
│                                                 │
│ Nombre del Titular *                           │
│ [JUAN PEREZ_________________________]          │
└─────────────────────────────────────────────────┘
```

---

## 🔧 **Implementación Técnica**

### **1. Estado en Página de Pago**:
```typescript
const [metodosPago, setMetodosPago] = useState<MetodoPagoConMonto[]>([
  {
    id: `metodo-${Date.now()}`,
    tipo: "Tarjeta_Credito",
    monto: totalPrice, // Inicializado con el total
    datos: {},
  },
])
```

### **2. Validación Antes de Enviar**:
```typescript
const totalAsignado = metodosPago.reduce((sum, m) => sum + m.monto, 0)
const diferencia = Math.abs(totalPrice - totalAsignado)

if (diferencia > 0.01) {
  toast({
    title: "Monto incompleto",
    description: `Faltan $${(totalPrice - totalAsignado).toFixed(2)} por asignar`,
    variant: "destructive",
  })
  return
}
```

### **3. Registro de Métodos (Loop)**:
```typescript
const metodosRegistrados = []

for (const metodo of metodosPago) {
  const response = await fetch("/api/metodo-pago/registrar-universal", {
    method: "POST",
    body: JSON.stringify({
      tipo: metodo.tipo,
      cliente_id: parseInt(user.clienteId),
      datos: metodo.datos,
    }),
  })

  const result = await response.json()
  
  metodosRegistrados.push({
    metodo_pago_id: result.data.metodo_pago_id,
    monto: metodo.monto,
  })
}
```

### **4. Procesamiento de Pagos (Loop)**:
```typescript
const pagosRealizados = []
let millasObtenidas = 0

for (const metodoRegistrado of metodosRegistrados) {
  const response = await fetch("/api/pago/procesar", {
    method: "POST",
    body: JSON.stringify({
      reserva_id: reserva_id,
      cliente_id: parseInt(user.clienteId),
      metodo_pago_id: metodoRegistrado.metodo_pago_id,
      monto_pago: metodoRegistrado.monto,
      pago_con_millas: false,
      cantidad_millas: 0,
    }),
  })

  const pagoResult = await response.json()
  pagosRealizados.push(pagoResult)
  millasObtenidas += pagoResult.data.millas_obtenidas || 0
}
```

### **5. Datos Guardados para Confirmación**:
```typescript
const confirmationData = {
  reservationNumber: "1234",
  reservaInfo: { ... },
  pasajeros: [ ... ],
  metodosPago: [                    // ✅ NUEVO
    {
      tipo: "Tarjeta_Credito",
      monto: 550,
      metodoPagoId: 12
    },
    {
      tipo: "Pago_Movil",
      monto: 550,
      metodoPagoId: 13
    }
  ],
  pagoInfo: {
    pagos: pagosRealizados,
    millas_obtenidas: millasObtenidas,
    total_pagos: 2
  }
}
```

---

## 📄 **Página de Confirmación Actualizada**

### **Nueva Sección: Métodos de Pago Utilizados**
```
┌─────────────────────────────────────────────────┐
│ Métodos de Pago Utilizados                     │
├─────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────┐ │
│ │ 💳 Tarjeta Credito                          │ │
│ │ ID: 12                          $550.00     │ │
│ └─────────────────────────────────────────────┘ │
│                                                 │
│ ┌─────────────────────────────────────────────┐ │
│ │ 📱 Pago Movil                               │ │
│ │ ID: 13                          $550.00     │ │
│ └─────────────────────────────────────────────┘ │
│                                                 │
│ ─────────────────────────────────────────────  │
│ Total Pagado:                       $1,100.00  │
└─────────────────────────────────────────────────┘
```

---

## ✅ **Validaciones Implementadas**

1. ✅ **Monto mínimo**: Cada método debe tener monto > 0
2. ✅ **Monto máximo**: No puede exceder el total de la reserva
3. ✅ **Suma exacta**: La suma de todos los métodos debe igualar el total
4. ✅ **Campos obligatorios**: Según el tipo de método
5. ✅ **Máximo 5 métodos**: Límite de métodos por transacción
6. ✅ **Mínimo 1 método**: Al menos un método requerido

---

## 🧪 **Casos de Prueba**

### **Test 1: Validación de Monto Incompleto**
```
Total: $1,100
Método 1: $500
Método 2: $300
Total asignado: $800
Resultado: ❌ Error "Faltan $300.00 por asignar"
```

### **Test 2: Validación de Monto Excedido**
```
Total: $1,100
Método 1: $700
Método 2: $700
Total asignado: $1,400
Resultado: ❌ Error "Excede el total en $300.00"
```

### **Test 3: Pago Exitoso con 2 Métodos**
```
Total: $1,100
Método 1: Tarjeta - $550
Método 2: Pago Móvil - $550
Total asignado: $1,100
Resultado: ✅ Pago procesado correctamente
```

### **Test 4: Botón "Dividir Equitativo"**
```
Total: $1,100
Métodos: 2
Click en "Dividir Equitativo"
Resultado: 
  Método 1: $550
  Método 2: $550
```

### **Test 5: Botón "Completar Total"**
```
Total: $1,100
Método 1: $300 (ya asignado)
Método 2: $0
Click en "Completar Total" en Método 2
Resultado: Método 2: $800
```

---

## 📝 **Archivos Creados/Modificados**

1. ✅ `components/selector-metodos-pago-multiple.tsx` - Componente nuevo
2. ✅ `app/clientes/itinerario/pago/[id]/page.tsx` - Actualizado para múltiples métodos
3. ✅ `app/clientes/confirmacion/page.tsx` - Muestra métodos utilizados
4. ✅ `SISTEMA_MULTIPLES_METODOS_PAGO.md` - Esta documentación

---

## 🎉 **Resultado Final**

El sistema ahora permite:
- ✅ **Combinar hasta 5 métodos de pago** diferentes
- ✅ **Asignar montos específicos** a cada método
- ✅ **Validación automática** del total
- ✅ **Indicador visual** de progreso
- ✅ **Botones de ayuda** (Dividir/Completar)
- ✅ **Registro múltiple** en la BD
- ✅ **Confirmación detallada** de métodos utilizados

**¡Sistema de múltiples métodos de pago completamente funcional!** 🚀

