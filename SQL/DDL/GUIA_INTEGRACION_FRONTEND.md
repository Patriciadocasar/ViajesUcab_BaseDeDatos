# Guía de Integración Frontend - Sistema de Itinerarios y Pagos

## 📋 Resumen

Esta guía explica cómo usar el sistema completo de itinerarios y pagos desde el frontend de la aplicación Next.js.

## 🗂️ Estructura de Archivos Creados

### API Routes (Backend)
```
app/api/
├── itinerario/
│   └── crear/
│       └── route.ts          # POST - Crear reserva con itinerario
├── pago/
│   └── procesar/
│       └── route.ts          # POST - Procesar pago
├── metodo-pago/
│   └── registrar/
│       └── route.ts          # POST - Registrar tarjeta
└── reserva/
    ├── [id]/
    │   └── route.ts          # GET - Obtener detalle de reserva
    └── cancelar/
        └── route.ts          # POST - Cancelar reserva
```

### Componentes (Frontend)
```
app/
├── itinerario/
│   ├── page.tsx              # ✅ ACTUALIZADO - Crear itinerario
│   ├── comprar/
│   │   └── [id]/
│   │       └── page.tsx      # ✅ ACTUALIZADO - Seleccionar servicios
│   └── pago/
│       └── [id]/
│           └── page.tsx      # ✅ ACTUALIZADO - Procesar pago
└── reserva/
    └── [id]/
        └── page.tsx          # ✅ NUEVO - Ver detalle de reserva
```

## 🔄 Flujo Completo de Usuario

### 1. Usuario Crea un Itinerario

**Componente**: `app/itinerario/page.tsx`

#### Acción del Usuario:
1. Selecciona destinos, vuelos, hoteles, actividades
2. Asigna fechas
3. Click en "Guardar Itinerario"

#### Código de Integración:

```typescript
const saveItinerary = async () => {
  // Validaciones
  if (!itineraryName || items.length === 0) {
    toast({ title: "Error", description: "Completa todos los campos" })
    return
  }

  // Guardar localmente (para la UI inmediata)
  const newItinerary = {
    id: Date.now().toString(),
    name: itineraryName,
    items: [...items],
    totalPrice: items.reduce((sum, item) => sum + item.price, 0),
    createdAt: new Date().toISOString(),
  }

  addItinerary(newItinerary) // Guardar en contexto local

  toast({
    title: "✅ Itinerario guardado",
    description: "Puedes proceder a comprar cuando estés listo",
  })
}
```

### 2. Usuario Decide Comprar el Itinerario

**Componente**: `app/itinerario/comprar/[id]/page.tsx`

#### Acción del Usuario:
1. Click en "Comprar Itinerario"
2. Selecciona preferencias (clase de vuelo, tipo de habitación, etc.)
3. Click en "Continuar al Pago"

#### Código de Integración:

```typescript
const handleContinueToPayment = async () => {
  // Validar selecciones
  if (missingSelections.length > 0) {
    toast({ title: "Error", description: "Completa todas las selecciones" })
    return
  }

  try {
    toast({ title: "Procesando...", description: "Creando tu reserva" })

    // Preparar datos para la API
    const vuelo_ids: number[] = []
    const hospedaje_ids: number[] = []
    const servicio_adicional_ids: number[] = []
    const fechas_inicio: string[] = []
    const fechas_fin: string[] = []

    // Extraer IDs de servicios reales de la BD
    itinerary.items.forEach((item) => {
      if (item.type === "transport") vuelo_ids.push(item.realId) // ID real de BD
      if (item.type === "accommodation") hospedaje_ids.push(item.realId)
      if (item.type === "activity") servicio_adicional_ids.push(item.realId)
      
      fechas_inicio.push(item.date)
      fechas_fin.push(item.date)
    })

    // ✅ Llamada a la API
    const response = await fetch("/api/itinerario/crear", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        cliente_id: parseInt(user.id),
        vuelo_ids: vuelo_ids.length > 0 ? vuelo_ids : null,
        hospedaje_ids: hospedaje_ids.length > 0 ? hospedaje_ids : null,
        servicio_adicional_ids: servicio_adicional_ids.length > 0 ? servicio_adicional_ids : null,
        fechas_inicio: fechas_inicio,
        fechas_fin: fechas_fin,
      }),
    })

    const result = await response.json()

    if (result.status === "error") {
      toast({ title: "❌ Error", description: result.message, variant: "destructive" })
      return
    }

    // ✅ Reserva creada exitosamente
    console.log("Reserva creada:", result.data)
    // result.data contiene:
    // - reserva_id
    // - numero_reserva
    // - subtotal
    // - total
    // - millas_obtenidas

    // Guardar datos para el siguiente paso
    const purchaseData = {
      itinerary,
      selections,
      reservaInfo: result.data, // ← Info de la reserva creada
      customerInfo: { name: user.name, email: user.email },
    }

    localStorage.setItem("itineraryPurchase", JSON.stringify(purchaseData))

    toast({
      title: "✅ ¡Reserva creada!",
      description: `Número de reserva: ${result.data.numero_reserva}`,
    })

    // Ir a la página de pago
    router.push(`/itinerario/pago/${itinerary.id}`)

  } catch (error) {
    console.error("Error:", error)
    toast({ title: "Error", description: "No se pudo crear la reserva" })
  }
}
```

#### Respuesta de la API:

```json
{
  "status": "success",
  "message": "Reserva e itinerario(s) creados correctamente",
  "data": {
    "reserva_id": 1,
    "numero_reserva": 5678,
    "subtotal": 2150.00,
    "total": 2150.00,
    "millas_obtenidas": 215,
    "millas_totales_servicios": 215,
    "itinerarios_creados": 1
  }
}
```

### 3. Usuario Procesa el Pago

**Componente**: `app/itinerario/pago/[id]/page.tsx`

#### Acción del Usuario:
1. Ingresa datos de la tarjeta
2. Click en "Confirmar y Pagar"

#### Código de Integración:

```typescript
const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault()

  try {
    toast({ title: "Procesando pago...", description: "Por favor espera" })

    // ✅ PASO 1: Registrar el método de pago
    const registrarMetodoPagoResponse = await fetch("/api/metodo-pago/registrar", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        tipo: "Tarjeta_Credito",
        num_tarjeta: parseInt(formData.cardNumber.replace(/\s/g, "")),
        cod_seguridad: parseInt(formData.cvv),
        emisor: "Banco ViajesUCAB",
        marca: "Visa", // Detectar automáticamente según el número
        fecha_vencimiento: `20${formData.expiryDate.split("/")[1]}-${formData.expiryDate.split("/")[0]}-01`,
        nombre_titular: formData.cardName,
      }),
    })

    const metodoPagoResult = await registrarMetodoPagoResponse.json()

    if (metodoPagoResult.status === "error") {
      toast({ title: "Error", description: metodoPagoResult.message })
      return
    }

    const metodo_pago_id = metodoPagoResult.data.metodo_pago_id
    console.log("✅ Método de pago registrado:", metodo_pago_id)

    // ✅ PASO 2: Obtener datos de la reserva
    const storedData = JSON.parse(localStorage.getItem("itineraryPurchase") || "{}")
    const reserva_id = storedData.reservaInfo?.reserva_id

    if (!reserva_id) {
      toast({ title: "Error", description: "No se encontró información de la reserva" })
      return
    }

    // ✅ PASO 3: Procesar el pago
    const procesarPagoResponse = await fetch("/api/pago/procesar", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        reserva_id: reserva_id,
        cliente_id: parseInt(user.id),
        metodo_pago_id: metodo_pago_id,
        monto_pago: totalPrice,
        pago_con_millas: false, // Cambiar si el usuario quiere usar millas
        cantidad_millas: 0,
      }),
    })

    const pagoResult = await procesarPagoResponse.json()

    if (pagoResult.status === "error") {
      toast({ title: "❌ Error", description: pagoResult.message })
      return
    }

    console.log("✅ Pago procesado:", pagoResult.data)
    // pagoResult.data contiene:
    // - pago_id
    // - monto_pagado
    // - millas_usadas
    // - millas_obtenidas
    // - millas_actuales_cliente

    const milesEarned = pagoResult.data.millas_obtenidas

    // Guardar confirmación
    const confirmationData = {
      reservationNumber: storedData.reservaInfo.numero_reserva,
      customerInfo: { name: user.name, email: user.email },
      totalPrice,
      purchaseDate: new Date().toISOString(),
      pagoInfo: pagoResult.data,
    }

    localStorage.setItem("lastPurchase", JSON.stringify(confirmationData))
    localStorage.removeItem("itineraryPurchase")

    toast({
      title: "✅ ¡Pago exitoso!",
      description: `Has ganado ${milesEarned} millas`,
    })

    // Ir a confirmación
    router.push(`/confirmacion?reservation=${storedData.reservaInfo.numero_reserva}`)

  } catch (error) {
    console.error("Error:", error)
    toast({ title: "Error", description: "No se pudo procesar el pago" })
  }
}
```

#### Respuesta de la API:

```json
{
  "status": "success",
  "message": "Pago procesado correctamente",
  "data": {
    "pago_id": 1,
    "reserva_id": 1,
    "monto_pagado": 2150.00,
    "millas_usadas": 0,
    "millas_obtenidas": 215,
    "millas_actuales_cliente": 715,
    "financiamiento_id": null,
    "cuotas_creadas": 0
  }
}
```

### 4. Usuario Ve el Detalle de su Reserva

**Componente**: `app/reserva/[id]/page.tsx` (NUEVO)

#### Código de Integración:

```typescript
const cargarReserva = async () => {
  try {
    const response = await fetch(`/api/reserva/${reservaId}`)
    const result = await response.json()

    if (result.status === "error") {
      toast({ title: "Error", description: result.message })
      return
    }

    setReserva(result.data)
    // result.data contiene toda la info de la reserva e itinerarios
  } catch (error) {
    toast({ title: "Error", description: "No se pudo cargar la reserva" })
  }
}
```

## 💳 Casos de Uso Especiales

### Pago con Millas Acumuladas

```typescript
// En el componente de pago
const [usarMillas, setUsarMillas] = useState(false)
const [cantidadMillas, setCantidadMillas] = useState(0)

const handleSubmit = async () => {
  // ... registro de método de pago ...

  const procesarPagoResponse = await fetch("/api/pago/procesar", {
    method: "POST",
    body: JSON.stringify({
      reserva_id,
      cliente_id,
      metodo_pago_id,
      monto_pago: totalPrice,
      pago_con_millas: usarMillas,          // ← TRUE si usa millas
      cantidad_millas: cantidadMillas,       // ← Cantidad de millas a usar
    }),
  })

  // El sistema:
  // 1. Verifica que el cliente tenga suficientes millas
  // 2. Resta las millas usadas
  // 3. Suma las millas obtenidas por la compra
}
```

### Pago con Financiamiento

```typescript
const [usarFinanciamiento, setUsarFinanciamiento] = useState(false)
const [numeroCuotas, setNumeroCuotas] = useState(6)

const handleSubmit = async () => {
  // ... registro de método de pago ...

  const pagoInicial = totalPrice * 0.20 // 20% inicial
  const montoFinanciado = totalPrice - pagoInicial

  const procesarPagoResponse = await fetch("/api/pago/procesar", {
    method: "POST",
    body: JSON.stringify({
      reserva_id,
      cliente_id,
      metodo_pago_id,
      monto_pago: pagoInicial,              // ← Pago inicial
      usar_financiamiento: true,            // ← TRUE para financiar
      numero_cuotas: numeroCuotas,          // ← 3, 6, 12, etc.
      monto_financiado: montoFinanciado,    // ← Resto a financiar
    }),
  })

  // El sistema crea automáticamente:
  // - 1 registro en Financiamiento
  // - N registros en Cuota (uno por cada cuota)
}
```

### Cancelar una Reserva

```typescript
const cancelarReserva = async (reservaId: number) => {
  try {
    const response = await fetch("/api/reserva/cancelar", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        reserva_id: reservaId,
        porcentaje_retencion: 10.0,        // 10% de retención
        metodo_pago_reembolso_id: 3,       // ID del método de pago
      }),
    })

    const result = await response.json()

    if (result.status === "success") {
      toast({
        title: "Reserva cancelada",
        description: `Se reembolsará ${result.data.monto_devuelto} (retenido: ${result.data.monto_retenido})`,
      })
    }
  } catch (error) {
    toast({ title: "Error", description: "No se pudo cancelar la reserva" })
  }
}
```

## 🔍 Consultar Información

### Ver Detalle de una Reserva

```typescript
// GET /api/reserva/[id]
const verReserva = async (reservaId: number) => {
  const response = await fetch(`/api/reserva/${reservaId}`)
  const result = await response.json()

  console.log(result.data)
  // {
  //   reserva: { reserva_id, numero_reserva, total, millas_obtenidas, ... },
  //   itinerarios: [{ itinerario_id, costo_total, fecha_inicio, ... }]
  // }
}
```

## 🎨 Ejemplos de UI Components

### Selector de Millas

```tsx
<div className="space-y-4">
  <div className="flex items-center space-x-2">
    <Checkbox 
      checked={usarMillas} 
      onCheckedChange={setUsarMillas}
    />
    <label>Usar millas acumuladas</label>
  </div>
  
  {usarMillas && (
    <div>
      <Label>Cantidad de millas a usar</Label>
      <Input 
        type="number"
        value={cantidadMillas}
        onChange={(e) => setCantidadMillas(parseInt(e.target.value))}
        max={millasDisponibles}
      />
      <p className="text-sm text-muted-foreground">
        Tienes {millasDisponibles} millas disponibles
      </p>
    </div>
  )}
</div>
```

### Selector de Financiamiento

```tsx
<div className="space-y-4">
  <div className="flex items-center space-x-2">
    <Checkbox 
      checked={usarFinanciamiento} 
      onCheckedChange={setUsarFinanciamiento}
    />
    <label>Financiar compra</label>
  </div>
  
  {usarFinanciamiento && (
    <div>
      <Label>Número de cuotas</Label>
      <Select value={numeroCuotas.toString()} onValueChange={(v) => setNumeroCuotas(parseInt(v))}>
        <SelectTrigger>
          <SelectValue placeholder="Selecciona cuotas" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="3">3 cuotas</SelectItem>
          <SelectItem value="6">6 cuotas</SelectItem>
          <SelectItem value="12">12 cuotas</SelectItem>
        </SelectContent>
      </Select>
      <p className="text-sm text-muted-foreground">
        Cada cuota: {formatPrice((totalPrice - pagoInicial) / numeroCuotas)}
      </p>
    </div>
  )}
</div>
```

## 🚨 Manejo de Errores

### Errores Comunes y Soluciones

```typescript
try {
  const response = await fetch("/api/itinerario/crear", { /* ... */ })
  const result = await response.json()

  if (result.status === "error") {
    // Manejar errores específicos
    switch (result.message) {
      case "El cliente especificado no existe":
        toast({ title: "Error", description: "Usuario no válido. Por favor inicia sesión nuevamente." })
        router.push("/auth/login")
        break

      case "Debe incluir al menos un servicio en el itinerario":
        toast({ title: "Error", description: "Agrega al menos un servicio a tu itinerario" })
        break

      case "El cliente no tiene suficientes millas acumuladas":
        toast({ title: "Error", description: "No tienes suficientes millas. Usa otro método de pago." })
        setUsarMillas(false)
        break

      default:
        toast({ title: "Error", description: result.message })
    }
  }
} catch (error) {
  // Error de red o del servidor
  toast({ 
    title: "Error de conexión", 
    description: "No se pudo conectar con el servidor. Verifica tu conexión." 
  })
}
```

## 📊 Estados de Carga

```typescript
const [loading, setLoading] = useState(false)

const handleAction = async () => {
  setLoading(true)
  try {
    const response = await fetch(/* ... */)
    // ... lógica ...
  } catch (error) {
    // ... manejo de errores ...
  } finally {
    setLoading(false)
  }
}

// En el JSX
<Button onClick={handleAction} disabled={loading}>
  {loading ? (
    <>
      <Loader2 className="mr-2 h-4 w-4 animate-spin" />
      Procesando...
    </>
  ) : (
    "Confirmar"
  )}
</Button>
```

## ✅ Checklist de Implementación

### Backend
- [x] Crear funciones SQL en la base de datos
- [x] Crear API route `/api/itinerario/crear`
- [x] Crear API route `/api/pago/procesar`
- [x] Crear API route `/api/metodo-pago/registrar`
- [x] Crear API route `/api/reserva/[id]`
- [x] Crear API route `/api/reserva/cancelar`

### Frontend
- [x] Actualizar `app/itinerario/page.tsx`
- [x] Actualizar `app/itinerario/comprar/[id]/page.tsx`
- [x] Actualizar `app/itinerario/pago/[id]/page.tsx`
- [x] Crear `app/reserva/[id]/page.tsx`
- [ ] Agregar selector de millas en pago
- [ ] Agregar selector de financiamiento
- [ ] Agregar botón de cancelar reserva
- [ ] Actualizar perfil de usuario para mostrar millas actuales

### Testing
- [ ] Probar flujo completo de creación de itinerario
- [ ] Probar flujo de pago normal
- [ ] Probar pago con millas
- [ ] Probar pago con financiamiento
- [ ] Probar cancelación de reserva
- [ ] Probar manejo de errores

## 📞 Troubleshooting

### Problema: "El cliente especificado no existe"
- Verificar que `user.id` sea un número válido
- Verificar que el usuario esté autenticado

### Problema: "No se encontró información de la reserva"
- Verificar que el flujo guarde correctamente en localStorage
- Verificar que `reservaInfo.reserva_id` exista

### Problema: Número de tarjeta inválido
- Asegurarse de convertir a número sin espacios
- Validar formato de fecha de vencimiento

---

**Última actualización**: Diciembre 2024  
**Versión**: 1.0

