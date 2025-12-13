"use client"

import { useState, useEffect } from "react"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Plane, Ship, Bus, Briefcase, Hotel as HotelIcon, UtensilsCrossed, MapPin, Clock, DollarSign } from "lucide-react"
import { useToast } from "@/hooks/use-toast"
import Link from "next/link"

type Vuelo = {
  id: string
  numero: string
  origen: string
  destino: string
  fecha: string
  fechaLlegada?: string
  asientosTotal: number
  asientosDisponibles: number
  huellaCarbono?: number
  cantidadMillas?: number
  costo: number
}

type Crucero = {
  id: string
  origen: string
  destino: string
  fechaSalida: string
  fechaLlegada: string
  costo: number
  cantidadMillas?: number
  huellaCarbono?: number
}

type Traslado = {
  id: string
  origen: string
  destino: string
  fechaSalida: string
  fechaLlegada: string
  costo: number
  cantidadMillas?: number
  huellaCarbono?: number
}

type Hospedaje = {
  id: string
  hotelNombre: string
  fechaInicio: string
  fechaFin: string
  costo: number
  cantidadMillas?: number
}

type ServicioAdicional = {
  id: string
  nombre: string
  descripcion: string
  costo: number
  tipo: string
  cantidadMillas?: number
}

type Restaurante = {
  id: string
  nombre: string
  direccion: string
  clasificacion: string
  tipoComida: string
  ambiente: string
}

const flightImages = [
  "https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=800",
  "https://images.unsplash.com/photo-1464037866556-6812c9d1c72e?w=800",
  "https://images.unsplash.com/photo-1583308345959-fdb7154e3502?w=800"
]

const cruiseImages = [
  "https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800",
  "https://images.unsplash.com/photo-1548574505-5e239809ee19?w=800",
  "https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800"
]

const busImages = [
  "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
  "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800",
  "https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800"
]

const hotelImages = [
  "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
  "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800",
  "https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800"
]

const serviceImages = [
  "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800", // Parque con terrazas verdes
  "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800", // Mismo parque
  "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800", // Mismo parque
  "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800"  // Mismo parque
]

const restaurantImages = [
  "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800",
  "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800",
  "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800"
]

export function ServicesShowcase() {
  const [vuelos, setVuelos] = useState<Vuelo[]>([])
  const [cruceros, setCruceros] = useState<Crucero[]>([])
  const [traslados, setTraslados] = useState<Traslado[]>([])
  const [hospedajes, setHospedajes] = useState<Hospedaje[]>([])
  const [servicios, setServicios] = useState<ServicioAdicional[]>([])
  const [restaurantes, setRestaurantes] = useState<Restaurante[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const { toast } = useToast()

  useEffect(() => {
    cargarServicios()
  }, [])

  const mapearVuelo = (v: any, index: number): Vuelo => {
    const idRaw = v.vue_cod || v.Vue_COD || v.vue_COD || v.Vue_cod || v.id || Object.values(v).find((val: any) => typeof val === 'number' && val > 0)
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-${index}`
    
    // Generar número de vuelo
    const origen = v.origen || v.Origen || ""
    const destino = v.destino || v.Destino || ""
    const numero = `VU-${id}`
    
    // Guardar la fecha completa con hora (timestamp)
    const fechaSalida = v.vue_fecha_hora_salida || v.Vue_Fecha_Hora_Salida || v.fecha || ""
    const fechaLlegada = v.vue_fecha_hora_llegada || v.Vue_Fecha_Hora_Llegada || ""
    
    // Extraer valores numéricos (vienen como strings de la BD)
    const huellaRaw = v.vue_huella_carbono || v.Vue_Huella_Carbono || v.VUE_HUELLA_CARBONO || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    const millasRaw = v.vue_cant_millas || v.Vue_Cant_Millas || v.VUE_CANT_MILLAS || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const costoRaw = v.vue_costo || v.Vue_Costo || v.VUE_COSTO || v.costo || v.Costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    return {
      id: id,
      numero: numero,
      origen: origen,
      destino: destino,
      fecha: fechaSalida,
      fechaLlegada: fechaLlegada,
      asientosTotal: 0,
      asientosDisponibles: 0,
      huellaCarbono: huellaCarbono,
      cantidadMillas: cantidadMillas,
      costo: costo,
    }
  }

  const mapearCrucero = (c: any, index: number): Crucero => {
    const idRaw = c.Cru_COD || c.cru_cod || c.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-crucero-${index}`
    
    const costoRaw = c.Cru_Costo || c.cru_costo || c.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = c.Cru_Cant_Millas || c.cru_cant_millas || c.cantidadMillas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const huellaRaw = c.Cru_Huella_Carbono || c.cru_huella_carbono || c.huellaCarbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    return {
      id: id,
      origen: c.origen || "Origen",
      destino: c.destino || "Destino",
      fechaSalida: c.Cru_Fecha_Hora_Salida || c.cru_fecha_hora_salida || c.fechaSalida || new Date().toISOString(),
      fechaLlegada: c.Cru_Fecha_Hora_Llegada || c.cru_fecha_hora_lllegada || c.fechaLlegada || new Date().toISOString(),
      costo: costo,
      cantidadMillas: cantidadMillas,
      huellaCarbono: huellaCarbono
    }
  }

  const mapearTraslado = (t: any, index: number): Traslado => {
    const idRaw = t.TT_COD || t.tt_cod || t.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-traslado-${index}`
    
    const costoRaw = t.TT_Costo || t.tt_costo || t.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = t.TT_Cant_Millas || t.tt_cant_millas || t.cantidadMillas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    const huellaRaw = t.TT_Huella_Carbono || t.tt_huella_carbono || t.huellaCarbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    
    return {
      id: id,
      origen: t.origen || "Origen",
      destino: t.destino || "Destino",
      fechaSalida: t.TT_Fecha_Hora_Salida || t.tt_fecha_hora_salida || t.fechaSalida || new Date().toISOString(),
      fechaLlegada: t.TT_Fecha_Hora_Llegada || t.tt_fecha_hora_llegada || t.fechaLlegada || new Date().toISOString(),
      costo: costo,
      cantidadMillas: cantidadMillas,
      huellaCarbono: huellaCarbono
    }
  }

  const mapearHospedaje = (h: any, index: number): Hospedaje => {
    const idRaw = h.Hos_COD || h.hos_cod || h.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-hospedaje-${index}`
    
    const costoRaw = h.Hos_Costo || h.hos_costo || h.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = h.Hot_Cant_Milla || h.hot_cant_milla || h.cantidadMillas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    return {
      id: id,
      hotelNombre: h.hotel_nombre || h.hotelNombre || "Hotel",
      fechaInicio: h.Hos_Fecha_Hora_Inicio || h.hos_fecha_hora_inicio || h.fechaInicio || new Date().toISOString(),
      fechaFin: h.Hos_Fecha_Hora_Fin || h.hos_fecha_hora_fin || h.fechaFin || new Date().toISOString(),
      costo: costo,
      cantidadMillas: cantidadMillas
    }
  }

  const mapearServicio = (s: any, index: number): ServicioAdicional => {
    const idRaw = s.sa_cod || s.id
    const id = idRaw != null ? idRaw.toString() : `temp-servicio-${index}`
    
    const costoRaw = s.sa_costo || s.costo || "0"
    const costo = parseFloat(costoRaw) || 0
    
    const millasRaw = s.sa_cant_milla || s.Sa_Cant_Milla || s.cantidadMillas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    
    return {
      id: id,
      nombre: s.sa_nombre || s.nombre || "Servicio",
      descripcion: s.sa_descripcion || s.descripcion || "",
      costo: costo,
      tipo: s.sa_tipo || s.tipo || "",
      cantidadMillas: cantidadMillas
    }
  }

  const mapearRestaurante = (r: any, index: number): Restaurante => {
    const idRaw = r.rest_cod || r.id
    const id = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : `temp-restaurante-${index}`
    
    return {
      id: id,
      nombre: r.rest_nombre || r.nombre || "Restaurante",
      direccion: r.rest_direccion || r.direccion || "",
      clasificacion: r.rest_clasificacion || r.clasificacion || "",
      tipoComida: r.rest_tipo_comida || r.tipoComida || "",
      ambiente: r.rest_ambiente || r.ambiente || ""
    }
  }

  const cargarServicios = async () => {
    try {
      // Cargar todos los servicios en paralelo
      const [vuelosRes, crucerosRes, trasladosRes, hospedajesRes, serviciosRes, restaurantesRes] = await Promise.all([
        fetch("/api/vuelo"),
        fetch("/api/crucero"),
        fetch("/api/traslado"),
        fetch("/api/hospedaje"),
        fetch("/api/servicio-adicional"),
        fetch("/api/restaurante")
      ])

      if (vuelosRes.ok) {
        const data = await vuelosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const vuelosMapeados = data.data.slice(0, 10).map((v, index) => mapearVuelo(v, index))
          setVuelos(vuelosMapeados)
        }
      }

      if (crucerosRes.ok) {
        const data = await crucerosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const crucerosMapeados = data.data.slice(0, 10).map((c, index) => mapearCrucero(c, index))
          setCruceros(crucerosMapeados)
        }
      }

      if (trasladosRes.ok) {
        const data = await trasladosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const trasladosMapeados = data.data.slice(0, 10).map((t, index) => mapearTraslado(t, index))
          setTraslados(trasladosMapeados)
        }
      }

      if (hospedajesRes.ok) {
        const data = await hospedajesRes.json()
        if (data.data && Array.isArray(data.data)) {
          const hospedajesMapeados = data.data.slice(0, 10).map((h, index) => mapearHospedaje(h, index))
          setHospedajes(hospedajesMapeados)
        }
      }

      if (serviciosRes.ok) {
        const data = await serviciosRes.json()
        if (data.data && Array.isArray(data.data)) {
          const serviciosMapeados = data.data.slice(0, 10).map((s, index) => mapearServicio(s, index))
          setServicios(serviciosMapeados)
        }
      }

      if (restaurantesRes.ok) {
        const data = await restaurantesRes.json()
        if (data.data && Array.isArray(data.data)) {
          const restaurantesMapeados = data.data.slice(0, 10).map((r, index) => mapearRestaurante(r, index))
          setRestaurantes(restaurantesMapeados)
        }
      }

    } catch (error) {
      console.error("Error cargando servicios:", error)
    } finally {
      setIsLoading(false)
    }
  }

  const formatDate = (dateString: string) => {
    try {
      return new Date(dateString).toLocaleDateString('es-ES', { 
        day: 'numeric', 
        month: 'short', 
        year: 'numeric' 
      })
    } catch {
      return dateString
    }
  }

  if (isLoading) {
    return (
      <div className="py-20 text-center">
        <p className="text-muted-foreground">Cargando servicios...</p>
      </div>
    )
  }

  return (
    <div className="w-full bg-background">
      <div className="container mx-auto px-4 lg:px-8 py-12 space-y-20">
      {/* Vuelos */}
      {vuelos.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
              <Plane className="h-10 w-10 text-primary" />
              Vuelos Disponibles
            </h2>
            <p className="text-muted-foreground text-lg">Descubre nuestros mejores destinos aéreos</p>
          </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {vuelos.map((vuelo, index) => (
              <Card key={vuelo.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={flightImages[index % flightImages.length]} 
                    alt="Vuelo"
                    className="w-full h-full object-cover"
                  />
                </div>
                <CardContent className="p-6 space-y-3">
                  <div className="flex items-center gap-2 text-sm font-mono text-muted-foreground">
                    {vuelo.numero}
                  </div>
                  <div className="flex items-center gap-2 text-sm">
                    <MapPin className="h-4 w-4 text-muted-foreground" />
                    <span className="font-semibold">{vuelo.origen}</span>
                    <span className="text-muted-foreground">→</span>
                    <span className="font-semibold">{vuelo.destino}</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Clock className="h-4 w-4" />
                    {formatDate(vuelo.fecha)}
                  </div>
                  {vuelo.fechaLlegada && (
                    <div className="text-xs text-muted-foreground">
                      Llegada: {formatDate(vuelo.fechaLlegada)}
                    </div>
                  )}
                  
                  {/* Información adicional */}
                  <div className="flex gap-2 flex-wrap pt-2">
                    {vuelo.cantidadMillas && vuelo.cantidadMillas > 0 && (
                      <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                        ✈️ {Number(vuelo.cantidadMillas).toLocaleString()} millas
                      </Badge>
                    )}
                    {vuelo.huellaCarbono && vuelo.huellaCarbono > 0 && (
                      <Badge variant="secondary" className="bg-green-100 text-green-700">
                        🌱 {Number(vuelo.huellaCarbono).toFixed(2)} kg CO₂
                      </Badge>
                    )}
                  </div>
                  
                  <div className="flex items-center justify-between pt-3 border-t">
                    {vuelo.costo && vuelo.costo > 0 ? (
                      <span className="text-2xl font-bold text-primary">${Number(vuelo.costo).toFixed(2)}</span>
                    ) : (
                      <span className="text-sm text-muted-foreground">Consultar precio</span>
                    )}
                    <Button size="sm" className="text-xs px-3 py-1 h-8">+ Agregar</Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}

      {/* Cruceros */}
      {cruceros.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
              <Ship className="h-10 w-10 text-primary" />
              Cruceros de Lujo
            </h2>
            <p className="text-muted-foreground text-lg">Experiencias inolvidables en alta mar</p>
          </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {cruceros.map((crucero, index) => (
              <Card key={crucero.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={cruiseImages[index % cruiseImages.length]} 
                    alt="Crucero"
                    className="w-full h-full object-cover"
                  />
                </div>
                <CardContent className="p-6 space-y-3">
                  <div className="flex items-center gap-2 text-sm">
                    <MapPin className="h-4 w-4 text-muted-foreground" />
                    <span className="font-semibold">{crucero.origen}</span>
                    <span className="text-muted-foreground">→</span>
                    <span className="font-semibold">{crucero.destino}</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Clock className="h-4 w-4" />
                    {formatDate(crucero.fechaSalida)}
                  </div>
                  
                  {/* Información adicional */}
                  <div className="flex gap-2 flex-wrap pt-2">
                    {crucero.cantidadMillas && crucero.cantidadMillas > 0 && (
                      <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                        🚢 {Number(crucero.cantidadMillas).toLocaleString()} millas
                      </Badge>
                    )}
                    {crucero.huellaCarbono && crucero.huellaCarbono > 0 && (
                      <Badge variant="secondary" className="bg-green-100 text-green-700">
                        🌱 {Number(crucero.huellaCarbono).toFixed(2)} kg CO₂
                      </Badge>
                    )}
                  </div>
                  
                  <div className="flex items-center justify-between pt-3 border-t">
                    {crucero.costo && crucero.costo > 0 ? (
                      <span className="text-2xl font-bold text-primary">${Number(crucero.costo).toFixed(2)}</span>
                    ) : (
                      <span className="text-sm text-muted-foreground">Consultar precio</span>
                    )}
                    <Button size="sm" className="text-xs px-3 py-1 h-8">+ Agregar</Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}

      {/* Traslados */}
      {traslados.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
                <Bus className="h-10 w-10 text-primary" />
                Traslados Terrestres
              </h2>
              <p className="text-muted-foreground text-lg">Viaja cómodo por tierra</p>
            </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {traslados.map((traslado, index) => (
              <Card key={traslado.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={busImages[index % busImages.length]} 
                    alt="Traslado"
                    className="w-full h-full object-cover"
                  />
                </div>
                <CardContent className="p-6 space-y-3">
                  <div className="flex items-center gap-2 text-sm">
                    <MapPin className="h-4 w-4 text-muted-foreground" />
                    <span className="font-semibold">{traslado.origen}</span>
                    <span className="text-muted-foreground">→</span>
                    <span className="font-semibold">{traslado.destino}</span>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Clock className="h-4 w-4" />
                    {formatDate(traslado.fechaSalida)}
                  </div>
                  
                  {/* Información adicional */}
                  <div className="flex gap-2 flex-wrap pt-2">
                    {traslado.cantidadMillas && traslado.cantidadMillas > 0 && (
                      <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                        🚌 {Number(traslado.cantidadMillas).toLocaleString()} millas
                      </Badge>
                    )}
                    {traslado.huellaCarbono && traslado.huellaCarbono > 0 && (
                      <Badge variant="secondary" className="bg-green-100 text-green-700">
                        🌱 {Number(traslado.huellaCarbono).toFixed(2)} kg CO₂
                      </Badge>
                    )}
                  </div>
                  
                  <div className="flex items-center justify-between pt-3 border-t">
                    {traslado.costo && traslado.costo > 0 ? (
                      <span className="text-2xl font-bold text-primary">${Number(traslado.costo).toFixed(2)}</span>
                    ) : (
                      <span className="text-sm text-muted-foreground">Consultar precio</span>
                    )}
                    <Button size="sm" className="text-xs px-3 py-1 h-8">+ Agregar</Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}

      {/* Hospedajes */}
      {hospedajes.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
                <HotelIcon className="h-10 w-10 text-primary" />
                Hospedajes
              </h2>
              <p className="text-muted-foreground text-lg">Los mejores hoteles para tu estadía</p>
            </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {hospedajes.map((hospedaje, index) => (
              <Card key={hospedaje.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={hotelImages[index % hotelImages.length]} 
                    alt="Hotel"
                    className="w-full h-full object-cover"
                  />
                </div>
                <CardContent className="p-6 space-y-3">
                  <h3 className="font-bold text-lg">{hospedaje.hotelNombre}</h3>
                  <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <Clock className="h-4 w-4" />
                    {formatDate(hospedaje.fechaInicio)} - {formatDate(hospedaje.fechaFin)}
                  </div>
                  
                  {/* Información adicional */}
                  {hospedaje.cantidadMillas && hospedaje.cantidadMillas > 0 && (
                    <div className="flex gap-2 flex-wrap pt-2">
                      <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                        🏨 {Number(hospedaje.cantidadMillas).toLocaleString()} millas
                      </Badge>
                    </div>
                  )}
                  
                  <div className="flex items-center justify-between pt-3 border-t">
                    {hospedaje.costo && hospedaje.costo > 0 ? (
                      <span className="text-2xl font-bold text-primary">${Number(hospedaje.costo).toFixed(2)}</span>
                    ) : (
                      <span className="text-sm text-muted-foreground">Consultar precio</span>
                    )}
                    <Button size="sm" className="text-xs px-3 py-1 h-8">+ Agregar</Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}

      {/* Servicios Adicionales */}
      {servicios.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
                <Briefcase className="h-10 w-10 text-primary" />
                Servicios Adicionales
              </h2>
              <p className="text-muted-foreground text-lg">Complementa tu viaje con servicios exclusivos</p>
            </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {servicios.map((servicio, index) => (
              <Card key={servicio.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={serviceImages[index % serviceImages.length]} 
                    alt="Servicio"
                    className="w-full h-full object-cover"
                  />
                </div>
                <CardContent className="p-6 space-y-3">
                  <h3 className="font-bold text-lg">{servicio.nombre}</h3>
                  <p className="text-sm text-muted-foreground line-clamp-2">{servicio.descripcion}</p>
                  
                  {/* Información adicional */}
                  <div className="flex gap-2 flex-wrap pt-2">
                    {servicio.tipo && (
                      <Badge variant="outline">{servicio.tipo}</Badge>
                    )}
                    {servicio.cantidadMillas && servicio.cantidadMillas > 0 && (
                      <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                        💼 {Number(servicio.cantidadMillas).toLocaleString()} millas
                      </Badge>
                    )}
                  </div>
                  
                  <div className="flex items-center justify-between pt-3 border-t">
                    {servicio.costo && servicio.costo > 0 ? (
                      <span className="text-2xl font-bold text-primary">${Number(servicio.costo).toFixed(2)}</span>
                    ) : (
                      <span className="text-sm text-muted-foreground">Consultar precio</span>
                    )}
                    <Button size="sm" className="text-xs px-3 py-1 h-8">+ Agregar</Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}

      {/* Restaurantes */}
      {restaurantes.length > 0 && (
        <section>
          <div className="mb-10">
            <h2 className="text-4xl font-bold flex items-center gap-3 mb-2">
                <UtensilsCrossed className="h-10 w-10 text-primary" />
                Restaurantes
              </h2>
              <p className="text-muted-foreground text-lg">Disfruta de la mejor gastronomía</p>
            </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {restaurantes.map((restaurante, index) => (
              <Card key={restaurante.id} className="overflow-hidden hover:shadow-lg transition-all duration-300">
                <div className="relative h-52">
                  <img 
                    src={restaurantImages[index % restaurantImages.length]} 
                    alt="Restaurante"
                    className="w-full h-full object-cover"
                  />
                  <Badge className="absolute top-3 right-3 bg-green-600">
                    {restaurante.clasificacion}
                  </Badge>
                </div>
                <CardContent className="p-6 space-y-3">
                  <h3 className="font-bold text-lg">{restaurante.nombre}</h3>
                  <p className="text-sm text-muted-foreground">{restaurante.direccion}</p>
                  <div className="flex gap-2">
                    <Badge variant="outline">{restaurante.tipoComida}</Badge>
                    <Badge variant="outline">{restaurante.ambiente}</Badge>
                  </div>
                  <Button size="sm" className="w-full">Ver Menú</Button>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}
      </div>
    </div>
  )
}

