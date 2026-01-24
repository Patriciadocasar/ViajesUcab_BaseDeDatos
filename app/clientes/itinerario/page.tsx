"use client"

import { useState, useEffect } from "react"
import {
  Plus,
  Trash2,
  Calendar,
  MapPin,
  Plane,
  Hotel,
  Compass,
  Package,
  Heart,
  ArrowLeft,
  ShoppingCart,
  ShoppingBag,
  Ship,
  Bus,
  Utensils,
} from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Badge } from "@/components/ui/badge"
import { useToast } from "@/hooks/use-toast"
import { useCurrency } from "@/lib/currency-context"
import { useItinerary } from "@/lib/itinerary-context"
import { useUser } from "@/lib/user-context"
import { useWishlist } from "@/lib/wishlist-context"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { useCart } from "@/lib/cart-context"

// Extender el tipo del contexto
interface ItineraryItem {
  id: string
  realId?: number // ID real de la base de datos
  type: "destination" | "transport" | "accommodation" | "activity" | "vuelo" | "crucero" | "traslado" | "hospedaje" | "servicio" | "restaurante" | "paquete"
  title: string
  description: string
  date: string
  price: number
  location?: string
  millas?: number
  huellaCarbono?: number
  companyName?: string
  selectedSeat?: string
  selectedCabin?: string
}

interface SavedItinerary {
  id: string
  name: string
  startDate?: string
  endDate?: string
  items: ItineraryItem[]
  totalPrice: number
  createdAt: string
}

// Interfaces para los servicios de la BD
interface VueloBD {
  id: number
  numero: string
  origen: string
  destino: string
  fecha: string
  fechaLlegada?: string
  costo: number
  cantidadMillas?: number
  huellaCarbono?: number
}

interface CruceroBD {
  id: number
  origen: string
  destino: string
  fechaSalida: string
  fechaLlegada: string
  costo: number
  cantidadMillas?: number
  huellaCarbono?: number
}

interface TrasladoBD {
  id: number
  origen: string
  destino: string
  fechaSalida: string
  fechaLlegada: string
  costo: number
  cantidadMillas?: number
  huellaCarbono?: number
}

interface HospedajeBD {
  id: number
  hotelNombre: string
  fechaInicio: string
  fechaFin: string
  costo: number
  cantidadMillas?: number
}

interface ServicioAdicionalBD {
  id: number
  nombre: string
  descripcion: string
  costo: number
  tipo: string
  cantidadMillas?: number
}

interface RestauranteBD {
  id: number
  nombre: string
  direccion: string
  clasificacion: string
  tipoComida: string
  ambiente: string
}

interface PaqueteTuristicoBD {
  id: number
  nombre: string
  descripcion: string
  costo: number
  costoMillas: number
  millasOtorga: number
  tipo: "especial" | "regular"
}

export default function ItinerarioPage() {
  const [itineraryName, setItineraryName] = useState("")
  const [startDate, setStartDate] = useState("")
  const [endDate, setEndDate] = useState("")
  const [items, setItems] = useState<ItineraryItem[]>([])
  const [showAddForm, setShowAddForm] = useState(true)
  const [selectedType, setSelectedType] = useState<string>("vuelo")
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split("T")[0])
  const { savedItineraries, addItinerary, deleteItinerary } = useItinerary()
  const { user } = useUser()
  const { toast } = useToast()
  const { formatPrice } = useCurrency()
  const router = useRouter()
  const { addToCart } = useCart()
  const { addToWishlist } = useWishlist()

  // Estados para servicios de la BD
  const [vuelos, setVuelos] = useState<VueloBD[]>([])
  const [cruceros, setCruceros] = useState<CruceroBD[]>([])
  const [traslados, setTraslados] = useState<TrasladoBD[]>([])
  const [hospedajes, setHospedajes] = useState<HospedajeBD[]>([])
  const [servicios, setServicios] = useState<ServicioAdicionalBD[]>([])
  const [restaurantes, setRestaurantes] = useState<RestauranteBD[]>([])
  const [paquetes, setPaquetes] = useState<PaqueteTuristicoBD[]>([])
  const [isLoadingServices, setIsLoadingServices] = useState(true)

  // Cargar servicios al montar el componente
  useEffect(() => {
    cargarServicios()
  }, [])

  // Funciones de mapeo (similares a services-showcase.tsx)
  const mapearVuelo = (v: any): VueloBD => {
    const idRaw = v.vue_cod || v.Vue_COD || v.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    const origen = v.origen || v.Origen || ""
    const destino = v.destino || v.Destino || ""
    const numero = `VU-${id}`
    
    const fechaSalida = v.vue_fecha_hora_salida || v.Vue_Fecha_Hora_Salida || v.fecha || ""
    const fechaLlegada = v.vue_fecha_hora_llegada || v.Vue_Fecha_Hora_Llegada || ""
    
    const huellaRaw = v.vue_huella_carbono || v.Vue_Huella_Carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    const millasRaw = v.vue_cant_millas || v.Vue_Cant_Millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const costoRaw = v.vue_costo || v.Vue_Costo || v.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    return {
      id,
      numero,
      origen,
      destino,
      fecha: fechaSalida,
      fechaLlegada,
      costo,
      cantidadMillas,
      huellaCarbono,
    }
  }

  const mapearCrucero = (c: any): CruceroBD => {
    const idRaw = c.Cru_COD || c.cru_cod || c.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    const costoRaw = c.Cru_Costo || c.cru_costo || c.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = c.Cru_Cant_Millas || c.cru_cant_millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const huellaRaw = c.Cru_Huella_Carbono || c.cru_huella_carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    return {
      id,
      origen: c.origen || "Origen",
      destino: c.destino || "Destino",
      fechaSalida: c.Cru_Fecha_Hora_Salida || c.cru_fecha_hora_salida || new Date().toISOString(),
      fechaLlegada: c.Cru_Fecha_Hora_Llegada || c.cru_fecha_hora_lllegada || new Date().toISOString(),
      costo,
      cantidadMillas,
      huellaCarbono,
    }
  }

  const mapearTraslado = (t: any): TrasladoBD => {
    const idRaw = t.TT_COD || t.tt_cod || t.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    const costoRaw = t.TT_Costo || t.tt_costo || t.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = t.TT_Cant_Millas || t.tt_cant_millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const huellaRaw = t.TT_Huella_Carbono || t.tt_huella_carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    return {
      id,
      origen: t.origen || "Origen",
      destino: t.destino || "Destino",
      fechaSalida: t.TT_Fecha_Hora_Salida || t.tt_fecha_hora_salida || new Date().toISOString(),
      fechaLlegada: t.TT_Fecha_Hora_Llegada || t.tt_fecha_hora_llegada || new Date().toISOString(),
      costo,
      cantidadMillas,
      huellaCarbono,
    }
  }

  const mapearHospedaje = (h: any): HospedajeBD => {
    const idRaw = h.Hos_COD || h.hos_cod || h.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    const costoRaw = h.Hos_Costo || h.hos_costo || h.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = h.Hot_Cant_Milla || h.hot_cant_milla || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    return {
      id,
      hotelNombre: h.hotel_nombre || h.hotelNombre || "Hotel",
      fechaInicio: h.Hos_Fecha_Hora_Inicio || h.hos_fecha_hora_inicio || new Date().toISOString(),
      fechaFin: h.Hos_Fecha_Hora_Fin || h.hos_fecha_hora_fin || new Date().toISOString(),
      costo,
      cantidadMillas,
    }
  }

  const mapearServicio = (s: any): ServicioAdicionalBD => {
    const idRaw = s.sa_cod || s.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    const costoRaw = s.sa_costo || s.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = s.sa_cant_milla || s.Sa_Cant_Milla || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    return {
      id,
      nombre: s.sa_nombre || s.nombre || "Servicio",
      descripcion: s.sa_descripcion || s.descripcion || "",
      costo,
      tipo: s.sa_tipo || s.tipo || "",
      cantidadMillas,
    }
  }

  const mapearRestaurante = (r: any): RestauranteBD => {
    const idRaw = r.rest_cod || r.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    return {
      id,
      nombre: r.rest_nombre || r.nombre || "Restaurante",
      direccion: r.rest_direccion || r.direccion || "",
      clasificacion: r.rest_clasificacion || r.clasificacion || "",
      tipoComida: r.rest_tipo_comida || r.tipoComida || "",
      ambiente: r.rest_ambiente || r.ambiente || "",
    }
  }

  const mapearPaquete = (p: any): PaqueteTuristicoBD => {
    const idRaw = p.pt_cod || p.PT_COD || p.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? Number(idRaw) : 0
    
    return {
      id,
      nombre: p.nombre || p.pt_nombre || p.PT_Nombre || "Paquete",
      descripcion: p.descripcion || p.pt_descripcion || p.PT_Descripcion || "",
      costo: parseFloat(p.costo || p.pt_costo || p.PT_Costo || "0"),
      costoMillas: parseFloat(p.costoMillas || p.pt_costo_millas || p.PT_Costo_Millas || "0"),
      millasOtorga: parseFloat(p.cantidadMillas || p.pt_cant_milla || p.PT_Cant_Milla || p.millasOtorga || "0"),
      tipo: (p.tipo || p.pt_tipo || p.PT_Tipo || "regular").toLowerCase() as "especial" | "regular",
    }
  }

  const cargarServicios = async () => {
    try {
      setIsLoadingServices(true)
      
      const [vuelosRes, crucerosRes, trasladosRes, hospedajesRes, serviciosRes, restaurantesRes, paquetesRes] = await Promise.all([
        fetch("/api/vuelo"),
        fetch("/api/crucero"),
        fetch("/api/traslado"),
        fetch("/api/hospedaje"),
        fetch("/api/servicio-adicional"),
        fetch("/api/restaurante"),
        fetch("/api/paquete-turistico?id=0"),
      ])

      if (vuelosRes.ok) {
        const data = await vuelosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const vuelosMapeados = data.data.map(mapearVuelo)
          setVuelos(vuelosMapeados)
        }
      }

      if (crucerosRes.ok) {
        const data = await crucerosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const crucerosMapeados = data.data.map(mapearCrucero)
          setCruceros(crucerosMapeados)
        }
      }

      if (trasladosRes.ok) {
        const data = await trasladosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const trasladosMapeados = data.data.map(mapearTraslado)
          setTraslados(trasladosMapeados)
        }
      }

      if (hospedajesRes.ok) {
        const data = await hospedajesRes.json()
        if (data.data && Array.isArray(data.data)) {
          const hospedajesMapeados = data.data.map(mapearHospedaje)
          setHospedajes(hospedajesMapeados)
        }
      }

      if (serviciosRes.ok) {
        const data = await serviciosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const serviciosMapeados = data.data.map(mapearServicio)
          setServicios(serviciosMapeados)
        }
      }

      if (restaurantesRes.ok) {
        const data = await restaurantesRes.json()
        if (data.data && Array.isArray(data.data)) {
          const restaurantesMapeados = data.data.map(mapearRestaurante)
          setRestaurantes(restaurantesMapeados)
        }
      }

      if (paquetesRes.ok) {
        const data = await paquetesRes.json()
        console.log("📦 Respuesta paquetes:", data)
        if (data.status === "success" && data.data && Array.isArray(data.data)) {
          const paquetesMapeados = data.data.map(mapearPaquete)
          console.log("📦 Paquetes mapeados:", paquetesMapeados)
          setPaquetes(paquetesMapeados)
        }
      }
    } catch (error) {
      console.error("❌ Error cargando servicios:", error)
      toast({
        title: "Error",
        description: "No se pudieron cargar los servicios",
        variant: "destructive",
      })
    } finally {
      setIsLoadingServices(false)
    }
  }

  const addPredefinedItem = (option: any, serviceType: string) => {
    if (!selectedDate) {
      toast({
        title: "Fecha requerida",
        description: "Por favor selecciona una fecha primero",
        variant: "destructive",
      })
      return
    }

    let item: ItineraryItem

    // Construir el item según el tipo de servicio
    // IMPORTANTE: Usar los tipos específicos (vuelo, crucero, etc.) no los genéricos
    switch (serviceType) {
      case "vuelo":
        item = {
          id: Date.now().toString(),
          realId: option.id, // ID real de la BD
          type: "vuelo" as any, // Tipo específico
          title: `${option.numero}: ${option.origen} → ${option.destino}`,
          description: `Vuelo de ${option.origen} a ${option.destino}`,
          date: selectedDate,
          price: option.costo || 0,
          location: `${option.origen} - ${option.destino}`,
          millas: option.cantidadMillas,
          huellaCarbono: option.huellaCarbono,
        }
        break

      case "crucero":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "crucero" as any, // Tipo específico
          title: `Crucero: ${option.origen} → ${option.destino}`,
          description: `Crucero de ${option.origen} a ${option.destino}`,
          date: selectedDate,
          price: option.costo || 0,
          location: `${option.origen} - ${option.destino}`,
          millas: option.cantidadMillas,
          huellaCarbono: option.huellaCarbono,
        }
        break

      case "traslado":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "traslado" as any, // Tipo específico
          title: `Traslado: ${option.origen} → ${option.destino}`,
          description: `Traslado terrestre de ${option.origen} a ${option.destino}`,
          date: selectedDate,
          price: option.costo || 0,
          location: `${option.origen} - ${option.destino}`,
          millas: option.cantidadMillas,
          huellaCarbono: option.huellaCarbono,
        }
        break

      case "hospedaje":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "hospedaje" as any, // Tipo específico
          title: option.hotelNombre,
          description: `Hospedaje en ${option.hotelNombre}`,
          date: selectedDate,
          price: option.costo || 0,
          location: option.hotelNombre,
          millas: option.cantidadMillas,
        }
        break

      case "servicio":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "servicio" as any, // Tipo específico
          title: option.nombre,
          description: option.descripcion || `Servicio: ${option.nombre}`,
          date: selectedDate,
          price: option.costo || 0,
          location: option.tipo,
          millas: option.cantidadMillas,
        }
        break

      case "restaurante":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "restaurante" as any, // Tipo específico
          title: option.nombre,
          description: `${option.tipoComida} - ${option.ambiente}`,
          date: selectedDate,
          price: 0, // Restaurantes generalmente no tienen precio fijo
          location: option.direccion,
        }
        break

      case "paquete":
        item = {
          id: Date.now().toString(),
          realId: option.id,
          type: "paquete" as any, // Tipo específico
          title: option.nombre,
          description: option.descripcion,
          date: selectedDate,
          price: option.costo,
          millas: option.millasOtorga,
        }
        break

      default:
        return
    }

    setItems([...items, item])
    toast({
      title: "Elemento agregado",
      description: `${item.title} se agregó a tu itinerario`,
    })
  }

  const removeItem = (id: string) => {
    setItems(items.filter((item) => item.id !== id))
    toast({
      title: "Elemento eliminado",
      description: "El elemento se eliminó de tu itinerario",
    })
  }

  const saveItinerary = async () => {
    console.log("[v0] saveItinerary called")
    console.log("[v0] itineraryName:", itineraryName)
    console.log("[v0] items:", items)

    if (!itineraryName) {
      toast({
        title: "Nombre requerido",
        description: "Por favor ingresa un nombre para tu itinerario",
        variant: "destructive",
      })
      return
    }

    if (items.length === 0) {
      toast({
        title: "Itinerario vacío",
        description: "Agrega al menos un elemento a tu itinerario",
        variant: "destructive",
      })
      return
    }

    // Crear el itinerario localmente primero (para la UI)
    const newItinerary = {
      id: Date.now().toString(),
      name: itineraryName,
      startDate: startDate || undefined,
      endDate: endDate || undefined,
      items: [...items],
      totalPrice: items.reduce((sum, item) => sum + item.price, 0),
      createdAt: new Date().toISOString(),
    }

    console.log("[v0] Calling addItinerary with:", newItinerary)
    addItinerary(newItinerary)
    console.log("[v0] addItinerary called successfully")

    setItineraryName("")
    setStartDate("")
    setEndDate("")
    setItems([])

    toast({
      title: "Itinerario guardado",
      description: `"${newItinerary.name}" se guardó exitosamente en tu perfil`,
    })
  }

  const handleDeleteItinerary = (id: string) => {
    deleteItinerary(id)
    toast({
      title: "Itinerario eliminado",
      description: "El itinerario se eliminó correctamente",
    })
  }

  const handlePurchaseItinerary = (itinerary: SavedItinerary) => {
    const cartItem = {
      id: Number.parseInt(itinerary.id),
      title: itinerary.name,
      location: `${itinerary.items.length} elementos incluidos`,
      price: itinerary.totalPrice,
      image: "/travel-itinerary.jpg",
      type: "package" as const,
      dates:
        itinerary.items.length > 0
          ? {
              checkIn: itinerary.items[0].date,
              checkOut: itinerary.items[itinerary.items.length - 1].date,
            }
          : undefined,
    }

    addToCart(cartItem)
  }

  const handlePurchaseCurrentItinerary = async () => {
    if (items.length === 0) {
      toast({
        title: "Itinerario vacío",
        description: "Agrega elementos a tu itinerario antes de comprar",
        variant: "destructive",
      })
      return
    }

    if (!user) {
      toast({
        title: "Inicia sesión",
        description: "Debes iniciar sesión para comprar un itinerario",
        variant: "destructive",
      })
      router.push("/auth/login")
      return
    }

    // Validar que hay servicios agregados
    if (items.length === 0) {
      toast({
        title: "Itinerario vacío",
        description: "Debes agregar al menos un servicio al itinerario",
        variant: "destructive",
      })
      return
    }

    // Validar que hay fechas de inicio y fin
    if (!startDate || !endDate) {
      toast({
        title: "Fechas requeridas",
        description: "Debes seleccionar fechas de inicio y fin para el itinerario",
        variant: "destructive",
      })
      return
    }

    // Validar que la fecha de inicio es antes de la fecha de fin
    if (new Date(startDate) > new Date(endDate)) {
      toast({
        title: "Fechas inválidas",
        description: "La fecha de inicio debe ser anterior a la fecha de fin",
        variant: "destructive",
      })
      return
    }

    // Crear el itinerario temporal para la UI
    const tempItinerary = {
      id: `temp-${Date.now()}`,
      name: itineraryName || "Itinerario sin nombre",
      startDate: startDate,
      endDate: endDate,
      items: [...items],
      totalPrice: items.reduce((sum, item) => sum + item.price, 0),
      createdAt: new Date().toISOString(),
    }

    console.log("🛒 Itinerario para compra:", tempItinerary)
    console.log("🛒 Items con realId:", items.map(i => ({ title: i.title, realId: i.realId, type: i.type })))

    // Guardar localmente para el flujo de compra
    localStorage.setItem("currentItineraryPurchase", JSON.stringify(tempItinerary))

    // Preparar para la página de compra
    router.push(`/clientes/itinerario/comprar/${tempItinerary.id}`)
  }

  const handleAddToWishlist = async () => {
    if (!user) {
      toast({
        title: "Inicia sesión",
        description: "Debes iniciar sesión para agregar a tu wishlist",
        variant: "destructive",
      })
      router.push("/auth/login")
      return
    }

    if (items.length === 0) {
      toast({
        title: "Itinerario vacío",
        description: "Agrega elementos a tu itinerario antes de guardarlo",
        variant: "destructive",
      })
      return
    }

    // Primero guardar el itinerario para obtener un ID
    const itineraryToSave = {
      id: `temp-${Date.now()}`,
      name: itineraryName || "Itinerario sin nombre",
      startDate: startDate,
      endDate: endDate,
      items: [...items],
      totalPrice: items.reduce((sum, item) => sum + item.price, 0),
      createdAt: new Date().toISOString(),
    }

    addItinerary(itineraryToSave)

    // Aquí necesitaríamos el ID real del itinerario desde la BD
    // Por ahora, usaremos el primer item como referencia
    const firstItemId = items[0].realId || 0

    if (firstItemId === 0) {
      toast({
        title: "Error",
        description: "No se puede agregar a wishlist sin un itinerario válido",
        variant: "destructive",
      })
      return
    }

    const descripcion = `${itineraryToSave.name} - ${items.length} servicio(s)`
    const success = await addToWishlist(firstItemId, descripcion)

    if (success) {
      console.log("✅ Itinerario agregado a wishlist")
    }
  }

  const totalPrice = items.reduce((sum, item) => sum + item.price, 0)
  const totalMillas = items.reduce((sum, item) => sum + (item.millas || 0), 0)

  const getIcon = (type: ItineraryItem["type"]) => {
    switch (type) {
      case "destination":
        return <MapPin className="h-5 w-5" />
      case "transport":
        return <Plane className="h-5 w-5" />
      case "accommodation":
        return <Hotel className="h-5 w-5" />
      case "activity":
        return <Compass className="h-5 w-5" />
      case "vuelo":
        return <Plane className="h-5 w-5" />
      case "crucero":
        return <Ship className="h-5 w-5" />
      case "traslado":
        return <Bus className="h-5 w-5" />
      case "hospedaje":
        return <Hotel className="h-5 w-5" />
      case "servicio":
        return <Compass className="h-5 w-5" />
      case "restaurante":
        return <Utensils className="h-5 w-5" />
      case "paquete":
        return <Package className="h-5 w-5" />
      default:
        return <MapPin className="h-5 w-5" />
    }
  }

  const getTypeLabel = (type: ItineraryItem["type"]) => {
    switch (type) {
      case "destination":
        return "Destino"
      case "transport":
        return "Transporte"
      case "accommodation":
        return "Hospedaje"
      case "activity":
        return "Actividad"
      case "vuelo":
        return "Vuelo"
      case "crucero":
        return "Crucero"
      case "traslado":
        return "Traslado"
      case "hospedaje":
        return "Hospedaje"
      case "servicio":
        return "Servicio"
      case "restaurante":
        return "Restaurante"
      case "paquete":
        return "Paquete"
      default:
        return "Servicio"
    }
  }

  const formatDate = (dateString: string) => {
    try {
      return new Date(dateString).toLocaleDateString("es-ES", {
        day: "numeric",
        month: "short",
        year: "numeric",
      })
    } catch {
      return dateString
    }
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8 lg:px-8">
        <div className="mb-6">
          <Button variant="ghost" onClick={() => router.push("/")} className="gap-2">
            <ArrowLeft className="h-4 w-4" />
            Volver
          </Button>
        </div>

        <div className="mb-8 flex items-center justify-between">
          <div>
            <h1 className="text-4xl font-bold mb-2">Crear Itinerario</h1>
            <p className="text-muted-foreground">
              Combina destinos, transporte, hospedaje y actividades para crear tu viaje perfecto
            </p>
          </div>
        </div>

        <div className="grid gap-6 lg:grid-cols-3">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-6">
            {/* Itinerary Name */}
            <Card>
              <CardHeader>
                <CardTitle>Información del Itinerario</CardTitle>
                <CardDescription>Dale un nombre y define las fechas de tu viaje</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <Label>Nombre del Itinerario</Label>
                  <Input
                    placeholder="Ej: Vacaciones en Europa 2024"
                    value={itineraryName}
                    onChange={(e) => setItineraryName(e.target.value)}
                  />
                </div>
                <div className="grid gap-4 sm:grid-cols-2">
                  <div className="space-y-2">
                    <Label>Fecha de Inicio</Label>
                    <Input 
                      type="date" 
                      value={startDate} 
                      onChange={(e) => setStartDate(e.target.value)}
                      min={new Date().toISOString().split("T")[0]}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>Fecha de Fin</Label>
                    <Input 
                      type="date" 
                      value={endDate} 
                      onChange={(e) => setEndDate(e.target.value)} 
                      min={startDate || new Date().toISOString().split("T")[0]} 
                    />
                  </div>
                </div>
                {startDate && endDate && (
                  <p className="text-sm text-muted-foreground">
                    Duración:{" "}
                    {Math.ceil((new Date(endDate).getTime() - new Date(startDate).getTime()) / (1000 * 60 * 60 * 24))}{" "}
                    días
                  </p>
                )}
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div>
                    <CardTitle>Agregar Elementos</CardTitle>
                    <CardDescription>
                      Selecciona una fecha y haz clic en el botón + para agregar opciones
                    </CardDescription>
                  </div>
                  <Button onClick={() => setShowAddForm(!showAddForm)} variant="outline" size="sm">
                    {showAddForm ? "Ocultar" : "Mostrar"} Opciones
                  </Button>
                </div>
              </CardHeader>
              {showAddForm && (
                <CardContent>
                  <div className="space-y-4">
                    <div className="space-y-2">
                      <Label className="text-base font-semibold">Fecha para el elemento *</Label>
                      <Input
                        type="date"
                        value={selectedDate}
                        onChange={(e) => setSelectedDate(e.target.value)}
                        className="border-2"
                        min={new Date().toISOString().split("T")[0]}
                      />
                      <p className="text-xs text-muted-foreground">
                        Selecciona la fecha en la que deseas realizar esta actividad
                      </p>
                    </div>

{isLoadingServices ? (
                      <div className="py-8 text-center">
                        <p className="text-muted-foreground">Cargando servicios...</p>
                      </div>
                    ) : (
                      <Tabs value={selectedType} onValueChange={setSelectedType}>
                        <TabsList className="grid w-full grid-cols-3">
                          <TabsTrigger value="vuelo">✈️ Vuelos</TabsTrigger>
                          <TabsTrigger value="hospedaje">🏨 Hospedaje</TabsTrigger>
                          <TabsTrigger value="servicio">🎯 Servicios</TabsTrigger>
                        </TabsList>
                        <div className="mt-2">
                          <TabsList className="grid w-full grid-cols-4">
                            <TabsTrigger value="crucero">🚢 Cruceros</TabsTrigger>
                            <TabsTrigger value="traslado">🚌 Traslados</TabsTrigger>
                            <TabsTrigger value="restaurante">🍽️ Restaurantes</TabsTrigger>
                            <TabsTrigger value="paquete">📦 Paquetes</TabsTrigger>
                          </TabsList>
                        </div>

                        {/* Vuelos */}
                        <TabsContent value="vuelo" className="space-y-3 mt-4">
                          {vuelos.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay vuelos disponibles</p>
                          ) : (
                            vuelos.map((vuelo) => (
                              <Card key={vuelo.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Plane className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">{vuelo.numero}</h4>
                                      </div>
                                      <p className="text-sm text-muted-foreground">
                                        {vuelo.origen} → {vuelo.destino}
                                      </p>
                                      <div className="flex items-center gap-3 mt-2">
                                        <p className="text-sm font-semibold text-primary">{formatPrice(vuelo.costo)}</p>
                                        {vuelo.cantidadMillas && vuelo.cantidadMillas > 0 && (
                                          <Badge variant="secondary" className="text-xs">
                                            ✈️ {vuelo.cantidadMillas} millas
                                          </Badge>
                                        )}
                                      </div>
                                      <p className="text-xs text-muted-foreground mt-1">
                                        {formatDate(vuelo.fecha)}
                                      </p>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(vuelo, "vuelo")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Cruceros */}
                        <TabsContent value="crucero" className="space-y-3 mt-4">
                          {cruceros.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay cruceros disponibles</p>
                          ) : (
                            cruceros.map((crucero) => (
                              <Card key={crucero.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Ship className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">Crucero de Lujo</h4>
                                      </div>
                                      <p className="text-sm text-muted-foreground">
                                        {crucero.origen} → {crucero.destino}
                                      </p>
                                      <div className="flex items-center gap-3 mt-2">
                                        <p className="text-sm font-semibold text-primary">{formatPrice(crucero.costo)}</p>
                                        {crucero.cantidadMillas && crucero.cantidadMillas > 0 && (
                                          <Badge variant="secondary" className="text-xs">
                                            🚢 {crucero.cantidadMillas} millas
                                          </Badge>
                                        )}
                                      </div>
                                      <p className="text-xs text-muted-foreground mt-1">
                                        Salida: {formatDate(crucero.fechaSalida)}
                                      </p>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(crucero, "crucero")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Traslados */}
                        <TabsContent value="traslado" className="space-y-3 mt-4">
                          {traslados.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay traslados disponibles</p>
                          ) : (
                            traslados.map((traslado) => (
                              <Card key={traslado.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Bus className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">Traslado Terrestre</h4>
                                      </div>
                                      <p className="text-sm text-muted-foreground">
                                        {traslado.origen} → {traslado.destino}
                                      </p>
                                      <div className="flex items-center gap-3 mt-2">
                                        <p className="text-sm font-semibold text-primary">{formatPrice(traslado.costo)}</p>
                                        {traslado.cantidadMillas && traslado.cantidadMillas > 0 && (
                                          <Badge variant="secondary" className="text-xs">
                                            🚌 {traslado.cantidadMillas} millas
                                          </Badge>
                                        )}
                                      </div>
                                      <p className="text-xs text-muted-foreground mt-1">
                                        {formatDate(traslado.fechaSalida)}
                                      </p>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(traslado, "traslado")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Hospedajes */}
                        <TabsContent value="hospedaje" className="space-y-3 mt-4">
                          {hospedajes.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay hospedajes disponibles</p>
                          ) : (
                            hospedajes.map((hospedaje) => (
                              <Card key={hospedaje.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Hotel className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">{hospedaje.hotelNombre}</h4>
                                      </div>
                                      <div className="flex items-center gap-3 mt-2">
                                        <p className="text-sm font-semibold text-primary">{formatPrice(hospedaje.costo)}</p>
                                        {hospedaje.cantidadMillas && hospedaje.cantidadMillas > 0 && (
                                          <Badge variant="secondary" className="text-xs">
                                            🏨 {hospedaje.cantidadMillas} millas
                                          </Badge>
                                        )}
                                      </div>
                                      <p className="text-xs text-muted-foreground mt-1">
                                        {formatDate(hospedaje.fechaInicio)} - {formatDate(hospedaje.fechaFin)}
                                      </p>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(hospedaje, "hospedaje")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Servicios Adicionales */}
                        <TabsContent value="servicio" className="space-y-3 mt-4">
                          {servicios.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay servicios disponibles</p>
                          ) : (
                            servicios.map((servicio) => (
                              <Card key={servicio.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Compass className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">{servicio.nombre}</h4>
                                      </div>
                                      <p className="text-sm text-muted-foreground line-clamp-2">{servicio.descripcion}</p>
                                      <div className="flex items-center gap-3 mt-2">
                                        <p className="text-sm font-semibold text-primary">{formatPrice(servicio.costo)}</p>
                                        {servicio.cantidadMillas && servicio.cantidadMillas > 0 && (
                                          <Badge variant="secondary" className="text-xs">
                                            🎯 {servicio.cantidadMillas} millas
                                          </Badge>
                                        )}
                                        {servicio.tipo && (
                                          <Badge variant="outline" className="text-xs">
                                            {servicio.tipo}
                                          </Badge>
                                        )}
                                      </div>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(servicio, "servicio")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Restaurantes */}
                        <TabsContent value="restaurante" className="space-y-3 mt-4">
                          {restaurantes.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay restaurantes disponibles</p>
                          ) : (
                            restaurantes.map((restaurante) => (
                              <Card key={restaurante.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Utensils className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">{restaurante.nombre}</h4>
                                      </div>
                                      <p className="text-sm text-muted-foreground">{restaurante.direccion}</p>
                                      <div className="flex items-center gap-2 mt-2">
                                        <Badge variant="outline" className="text-xs">{restaurante.tipoComida}</Badge>
                                        <Badge variant="outline" className="text-xs">{restaurante.ambiente}</Badge>
                                        {restaurante.clasificacion && (
                                          <Badge variant="secondary" className="text-xs">
                                            ⭐ {restaurante.clasificacion}
                                          </Badge>
                                        )}
                                      </div>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(restaurante, "restaurante")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>

                        {/* Paquetes Turísticos */}
                        <TabsContent value="paquete" className="space-y-3 mt-4">
                          {paquetes.length === 0 ? (
                            <p className="text-center text-muted-foreground py-4">No hay paquetes turísticos disponibles</p>
                          ) : (
                            paquetes.map((paquete) => (
                              <Card key={paquete.id} className="hover:border-primary transition-colors">
                                <CardContent className="pt-4">
                                  <div className="flex items-center justify-between gap-3">
                                    <div className="flex-1">
                                      <div className="flex items-center gap-2 mb-1">
                                        <Package className="h-4 w-4 text-primary" />
                                        <h4 className="font-semibold">{paquete.nombre}</h4>
                                        {paquete.tipo === "especial" && (
                                          <Badge className="bg-gradient-to-r from-yellow-500 to-orange-500 text-xs">
                                            ⭐ Especial
                                          </Badge>
                                        )}
                                      </div>
                                      <p className="text-sm text-muted-foreground line-clamp-2">{paquete.descripcion}</p>
                                      <div className="flex items-center gap-2 mt-2">
                                        <Badge variant="secondary" className="text-xs">
                                          💰 ${paquete.costo.toFixed(2)}
                                        </Badge>
                                        {paquete.millasOtorga > 0 && (
                                          <Badge variant="outline" className="text-xs text-blue-600">
                                            ✈️ +{paquete.millasOtorga} millas
                                          </Badge>
                                        )}
                                        {paquete.costoMillas > 0 && (
                                          <Badge variant="outline" className="text-xs">
                                            💎 {paquete.costoMillas} millas
                                          </Badge>
                                        )}
                                      </div>
                                    </div>
                                    <Button
                                      size="sm"
                                      onClick={() => addPredefinedItem(paquete, "paquete")}
                                      className="shrink-0"
                                    >
                                      <Plus className="h-4 w-4 mr-1" />
                                      Agregar
                                    </Button>
                                  </div>
                                </CardContent>
                              </Card>
                            ))
                          )}
                        </TabsContent>
                      </Tabs>
                    )}
                  </div>
                </CardContent>
              )}
            </Card>

            {/* Items List */}
            <Card>
              <CardHeader>
                <CardTitle>Tu Itinerario</CardTitle>
                <CardDescription>Elementos organizados cronológicamente</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                {items.length === 0 && (
                  <div className="text-center py-12 text-muted-foreground">
                    <Package className="h-12 w-12 mx-auto mb-4 opacity-50" />
                    <p>No hay elementos en tu itinerario</p>
                    <p className="text-sm">Selecciona opciones arriba para comenzar</p>
                  </div>
                )}

                {items
                  .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
                  .map((item) => (
                    <Card key={item.id}>
                      <CardContent className="pt-6">
                        <div className="flex gap-4">
                          <div className="flex-shrink-0">
                            <div className="h-12 w-12 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                              {getIcon(item.type)}
                            </div>
                          </div>
                          <div className="flex-1 min-w-0">
                            <div className="flex items-start justify-between gap-2 mb-2">
                              <div>
                                <Badge variant="secondary" className="mb-2">
                                  {getTypeLabel(item.type)}
                                </Badge>
                                <h3 className="font-semibold text-lg">{item.title}</h3>
                                {item.location && (
                                  <p className="text-sm text-muted-foreground flex items-center gap-1 mt-1">
                                    <MapPin className="h-3 w-3" />
                                    {item.location}
                                  </p>
                                )}
                              </div>
                              <Button
                                variant="ghost"
                                size="icon"
                                onClick={() => removeItem(item.id)}
                                className="text-destructive hover:text-destructive"
                              >
                                <Trash2 className="h-4 w-4" />
                              </Button>
                            </div>
                            {item.description && (
                              <p className="text-sm text-muted-foreground mb-2">{item.description}</p>
                            )}
                            <div className="flex items-center gap-4 text-sm flex-wrap">
                              <span className="flex items-center gap-1 text-muted-foreground">
                                <Calendar className="h-4 w-4" />
                                {new Date(item.date).toLocaleDateString("es-ES", {
                                  day: "numeric",
                                  month: "long",
                                  year: "numeric",
                                })}
                              </span>
                              {item.price > 0 && (
                                <span className="font-semibold text-primary">{formatPrice(item.price)}</span>
                              )}
                              {item.millas && item.millas > 0 && (
                                <Badge variant="secondary" className="text-xs">
                                  ✈️ {item.millas} millas
                                </Badge>
                              )}
                              {item.huellaCarbono && item.huellaCarbono > 0 && (
                                <Badge variant="secondary" className="text-xs bg-green-100 text-green-700">
                                  🌱 {item.huellaCarbono.toFixed(2)} kg CO₂
                                </Badge>
                              )}
                            </div>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Summary */}
            <Card>
              <CardHeader>
                <CardTitle>Resumen</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-muted-foreground">Total de elementos</span>
                  <span className="font-semibold">{items.length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-muted-foreground">Destinos</span>
                  <span className="font-semibold">{items.filter((i) => i.type === "destination").length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-muted-foreground">Transporte</span>
                  <span className="font-semibold">{items.filter((i) => i.type === "transport").length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-muted-foreground">Hospedaje</span>
                  <span className="font-semibold">{items.filter((i) => i.type === "accommodation").length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-muted-foreground">Actividades</span>
                  <span className="font-semibold">{items.filter((i) => i.type === "activity").length}</span>
                </div>
                <div className="border-t pt-4">
                  <div className="flex justify-between items-center">
                    <span className="font-semibold">Precio Total</span>
                    <span className="text-xl font-bold text-primary">{formatPrice(totalPrice)}</span>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Actions */}
            <Card>
              <CardContent className="pt-6 space-y-3">
                <Button onClick={saveItinerary} className="w-full" size="lg">
                  Guardar Itinerario
                </Button>
                <Button
                  onClick={handlePurchaseCurrentItinerary}
                  className="w-full gap-2"
                  size="lg"
                  variant="default"
                  disabled={items.length === 0}
                >
                  <ShoppingBag className="h-4 w-4" />
                  Comprar Itinerario
                </Button>
                <Button 
                  variant="outline" 
                  className="w-full gap-2 bg-transparent"
                  onClick={handleAddToWishlist}
                  disabled={items.length === 0}
                >
                  <Heart className="h-4 w-4" />
                  Agregar a wishlist
                </Button>
              </CardContent>
            </Card>

            {savedItineraries.length > 0 && (
              <Card>
                <CardHeader>
                  <CardTitle className="text-base">Wishlist</CardTitle>
                  <CardDescription>Tus itinerarios guardados</CardDescription>
                </CardHeader>
                <CardContent className="space-y-3">
                  {savedItineraries.map((itinerary) => (
                    <Card key={itinerary.id} className="border-2">
                      <CardContent className="pt-4">
                        <div className="space-y-3">
                          <div className="flex items-start justify-between gap-2">
                            <div className="flex-1 min-w-0">
                              <h4 className="font-semibold truncate">{itinerary.name}</h4>
                              <p className="text-sm text-muted-foreground">{itinerary.items.length} elementos</p>
                              {itinerary.startDate && itinerary.endDate && (
                                <p className="text-xs text-muted-foreground mt-1">
                                  {new Date(itinerary.startDate).toLocaleDateString("es-ES")} -{" "}
                                  {new Date(itinerary.endDate).toLocaleDateString("es-ES")}
                                </p>
                              )}
                              <p className="text-sm font-semibold text-primary mt-1">
                                {formatPrice(itinerary.totalPrice)}
                              </p>
                            </div>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() => handleDeleteItinerary(itinerary.id)}
                              className="text-destructive hover:text-destructive"
                            >
                              <Trash2 className="h-4 w-4" />
                            </Button>
                          </div>
                          <Button onClick={() => handlePurchaseItinerary(itinerary)} className="w-full gap-2" size="sm">
                            <ShoppingBag className="h-4 w-4" />
                            Comprar
                          </Button>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </CardContent>
              </Card>
            )}

            {/* Tips */}
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Consejos</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2 text-sm text-muted-foreground">
                <p>• Organiza tu viaje cronológicamente</p>
                <p>• Incluye tiempo de traslado entre destinos</p>
                <p>• Reserva hospedaje cerca de tus actividades</p>
                <p>• Considera días de descanso en tu itinerario</p>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}
