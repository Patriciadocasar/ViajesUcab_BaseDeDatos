# Itinerario Store - Usage Guide

This Zustand store manages the shopping cart (itinerario) for the ViajesUcab application.

## Installation

The store uses Zustand with persistence:

```bash
npm install zustand
```

## Features

- **User Authentication**: Manages logged-in user state
- **Shopping Cart**: Tracks all selected items for the trip itinerary
- **Auto-calculated Totals**: Automatically calculates total cost and miles
- **Carbon Footprint Tracking**: Calculates total carbon emissions
- **LocalStorage Persistence**: Cart persists across page refreshes

## Usage Examples

### 1. Authentication

```typescript
import { useItinerarioStore } from '@/store/itinerario-store'

function LoginComponent() {
  const { login, logout, usuario, isAuthenticated } = useItinerarioStore()

  const handleLogin = async () => {
    const userData = {
      usu_cod: 1,
      usu_primer_nombre: "Juan",
      usu_primer_apellido: "Pérez",
      usu_correo: "juan@example.com",
      cliente_cli_cod: 1,
      rol_rol_cod: 1
    }
    login(userData)
  }

  return (
    <div>
      {isAuthenticated ? (
        <div>
          <p>Welcome, {usuario?.usu_primer_nombre}!</p>
          <button onClick={logout}>Logout</button>
        </div>
      ) : (
        <button onClick={handleLogin}>Login</button>
      )}
    </div>
  )
}
```

### 2. Adding Items to Cart

```typescript
import { useItinerarioStore } from '@/store/itinerario-store'

function HospedajeCard({ hospedaje }) {
  const { addHospedaje } = useItinerarioStore()

  const handleAddToCart = () => {
    addHospedaje({
      hos_cod: hospedaje.hos_cod,
      hos_fecha_hora_inicio: "2024-12-15T14:00:00",
      hos_fecha_hora_fin: "2024-12-20T12:00:00",
      hos_costo: 500.00,
      hotel_pro_cod: 1,
      hot_cant_milla: 50,
      hotel_nombre: "Hotel Paradise",
      imagen: "/images/hotel.jpg"
    })
  }

  return <button onClick={handleAddToCart}>Add to Cart</button>
}
```

### 3. Adding Flights

```typescript
function VueloCard({ vuelo }) {
  const { addVuelo } = useItinerarioStore()

  const handleAddFlight = () => {
    addVuelo({
      vue_cod: vuelo.vue_cod,
      vue_huella_carbono: 2.5,
      vue_fecha_hora_salida: "2024-12-15T08:00:00",
      vue_fecha_hora_llegada: "2024-12-15T12:00:00",
      vue_cant_millas: 150,
      costo: 300.00,
      origen: "Caracas",
      destino: "Miami",
      aerolinea_nombre: "Conviasa"
    })
  }

  return <button onClick={handleAddFlight}>Add Flight</button>
}
```

### 4. Viewing Cart Summary

```typescript
function CartSummary() {
  const {
    itinerario,
    getTotalItems,
    getTotalCosto,
    getTotalMillas,
    getHuellaCarbono
  } = useItinerarioStore()

  return (
    <div>
      <h2>Cart Summary</h2>
      <p>Total Items: {getTotalItems()}</p>
      <p>Total Cost: ${getTotalCosto().toFixed(2)}</p>
      <p>Total Miles: {getTotalMillas()}</p>
      <p>Carbon Footprint: {getHuellaCarbono()} kg CO2</p>

      <h3>Items in Cart:</h3>
      <ul>
        {itinerario.hospedajes.map(h => (
          <li key={h.hos_cod}>{h.hotel_nombre} - ${h.hos_costo}</li>
        ))}
        {itinerario.vuelos.map(v => (
          <li key={v.vue_cod}>{v.origen} → {v.destino} - ${v.costo}</li>
        ))}
        {itinerario.cruceros.map(c => (
          <li key={c.cru_cod}>{c.cru_nombre} - ${c.costo}</li>
        ))}
      </ul>
    </div>
  )
}
```

### 5. Removing Items

```typescript
function CartItem({ hospedaje }) {
  const { removeHospedaje } = useItinerarioStore()

  return (
    <div>
      <p>{hospedaje.hotel_nombre}</p>
      <button onClick={() => removeHospedaje(hospedaje.hos_cod)}>
        Remove
      </button>
    </div>
  )
}
```

### 6. Adding Services and Extras

```typescript
function ServicesSection() {
  const {
    addServicioAdicional,
    setCompensacionCarbono,
    getHuellaCarbono
  } = useItinerarioStore()

  const handleAddTour = () => {
    addServicioAdicional({
      sa_cod: 1,
      sa_tipo: "Tour",
      sa_nombre: "City Tour",
      sa_costo: 75.00,
      sa_cant_milla: 10,
      sa_fecha_hora_inicio: "2024-12-16T09:00:00",
      sa_fecha_hora_fin: "2024-12-16T17:00:00",
      operador_nombre: "Tours Paradise"
    })
  }

  const handleAddCarbonOffset = () => {
    const carbonFootprint = getHuellaCarbono()
    const offsetCost = carbonFootprint * 5 // $5 per kg
    setCompensacionCarbono(offsetCost)
  }

  return (
    <div>
      <button onClick={handleAddTour}>Add City Tour</button>
      <button onClick={handleAddCarbonOffset}>
        Offset Carbon (${(getHuellaCarbono() * 5).toFixed(2)})
      </button>
    </div>
  )
}
```

### 7. Setting Travel Dates

```typescript
function DateSelector() {
  const { setFechasItinerario } = useItinerarioStore()

  const handleSetDates = () => {
    setFechasItinerario("2024-12-15", "2024-12-20")
  }

  return <button onClick={handleSetDates}>Set Dates</button>
}
```

### 8. Clear Cart

```typescript
function ClearCartButton() {
  const { clearItinerario, getTotalItems } = useItinerarioStore()

  return (
    <button
      onClick={clearItinerario}
      disabled={getTotalItems() === 0}
    >
      Clear Cart ({getTotalItems()} items)
    </button>
  )
}
```

### 9. Adding Complete Package

```typescript
function PackageCard({ paquete }) {
  const { setPaqueteTuristico } = useItinerarioStore()

  const handleAddPackage = () => {
    setPaqueteTuristico({
      pt_cod: paquete.pt_cod,
      pt_nombre: "Caribbean Paradise",
      pt_descripcion: "7 días todo incluido",
      pt_costo: 1500.00,
      pt_costo_millas: 150000,
      pt_cant_milla: 200,
      pt_tipo: "Todo Incluido",
      imagen: "/images/package.jpg"
    })
  }

  return <button onClick={handleAddPackage}>Book Package</button>
}
```

## Store State Structure

```typescript
{
  // User authentication
  usuario: Usuario | null,
  isAuthenticated: boolean,

  // Shopping cart
  itinerario: {
    paquete_turistico?: PaqueteTuristico,
    hospedajes: Hospedaje[],
    restaurantes: Restaurante[],
    vuelos: Vuelo[],
    cruceros: Crucero[],
    transportes_terrestres: TransporteTerrestre[],
    servicios_adicionales: ServicioAdicional[],
    iti_costo_total: number,
    iti_cant_milla_total: number,
    iti_fecha_inicio?: string,
    iti_fecha_fin?: string,
    compensacion_carbono?: number
  }
}
```

## Available Actions

### Authentication
- `login(usuario)` - Log in user
- `logout()` - Log out and clear cart
- `updateUsuario(partial)` - Update user data

### Cart Management
- `addHospedaje(hospedaje)` - Add accommodation
- `addVuelo(vuelo)` - Add flight
- `addCrucero(crucero)` - Add cruise
- `addTransporteTerrestre(transporte)` - Add ground transport
- `addRestaurante(restaurante)` - Add restaurant
- `addServicioAdicional(servicio)` - Add additional service
- `setPaqueteTuristico(paquete)` - Set travel package

### Remove Items
- `removeHospedaje(hos_cod)` - Remove accommodation
- `removeVuelo(vue_cod)` - Remove flight
- `removeCrucero(cru_cod)` - Remove cruise
- `removeTransporteTerrestre(tt_cod)` - Remove transport
- `removeRestaurante(rest_cod)` - Remove restaurant
- `removeServicioAdicional(sa_cod)` - Remove service
- `removePaqueteTuristico()` - Remove package

### Clear Categories
- `clearHospedajes()` - Remove all accommodations
- `clearVuelos()` - Remove all flights
- `clearCruceros()` - Remove all cruises
- `clearTransportesTerrestres()` - Remove all transports
- `clearRestaurantes()` - Remove all restaurants
- `clearServiciosAdicionales()` - Remove all services
- `clearItinerario()` - Clear entire cart

### Other Actions
- `setCompensacionCarbono(monto)` - Set carbon offset amount
- `removeCompensacionCarbono()` - Remove carbon offset
- `setFechasItinerario(inicio, fin)` - Set trip dates

### Computed Values
- `getTotalItems()` - Get total number of items
- `getTotalCosto()` - Get total cost
- `getTotalMillas()` - Get total miles
- `getHuellaCarbono()` - Get carbon footprint

## Persistence

The store automatically persists to localStorage under the key `viajes-ucab-itinerario`. The following data is persisted:
- User authentication state
- Complete itinerario (cart) contents
- All calculated totals

Data is automatically loaded on app initialization and saved on every change.
