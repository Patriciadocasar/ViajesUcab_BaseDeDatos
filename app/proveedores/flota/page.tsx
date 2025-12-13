"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Plane, Ship, MapPin, Plus, Pencil, Trash2, Bus, Hotel, Briefcase, UtensilsCrossed } from "lucide-react"
import { useToast } from "@/hooks/use-toast"

type Vuelo = {
  id: string
  numero: string
  origen: string
  destino: string
  fecha: string
  fechaLlegada?: string
  huellaCarbono?: number
  cantidadMillas?: number
  costo: number
}

type Crucero = {
  id: string
  nombre: string
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

type ServicioAdicional = {
  id: string
  nombre: string
  descripcion: string
  costo: number
  tipo: string
  cantidadMillas?: number
}

type Hospedaje = {
  id: string
  hotelNombre: string
  fechaInicio: string
  fechaFin: string
  costo: number
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

export default function FlotaPage() {
  const [vuelos, setVuelos] = useState<Vuelo[]>([])
  const [cruceros, setCruceros] = useState<Crucero[]>([])
  const [traslados, setTraslados] = useState<Traslado[]>([])
  const [serviciosAdicionales, setServiciosAdicionales] = useState<ServicioAdicional[]>([])
  const [hospedajes, setHospedajes] = useState<Hospedaje[]>([])
  const [restaurantes, setRestaurantes] = useState<Restaurante[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const { toast } = useToast()

  // Funciones de mapeo
  const mapearVuelo = (v: any): Vuelo => {
    const idRaw = v.vue_cod || v.Vue_COD
    const id = idRaw?.toString() || ""
    const origen = v.origen || v.Origen || ""
    const destino = v.destino || v.Destino || ""
    const numero = `VU-${id}`
    const fechaSalida = v.vue_fecha_hora_salida || v.Vue_Fecha_Hora_Salida || ""
    const fechaLlegada = v.vue_fecha_hora_llegada || v.Vue_Fecha_Hora_Llegada || ""
    const huellaRaw = v.vue_huella_carbono || v.Vue_Huella_Carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0
    const millasRaw = v.vue_cant_millas || v.Vue_Cant_Millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    const costoRaw = v.vue_costo || v.Vue_Costo || "0"
    const costo = parseFloat(costoRaw) || 0

    return { id, numero, origen, destino, fecha: fechaSalida, fechaLlegada, huellaCarbono, cantidadMillas, costo }
  }

  const mapearCrucero = (c: any): Crucero => {
    const idRaw = c.Cru_COD || c.cru_cod
    const id = idRaw?.toString() || ""
    const nombre = c.Cru_nombre || c.cru_nombre || "Crucero"
    const costoRaw = c.Cru_Costo || c.cru_costo || "0"
    const costo = parseFloat(costoRaw) || 0
    const millasRaw = c.Cru_Cant_Millas || c.cru_cant_millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    const huellaRaw = c.Cru_Huella_Carbono || c.cru_huella_carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0

    return {
      id,
      nombre,
      origen: c.origen || "Origen",
      destino: c.destino || "Destino",
      fechaSalida: c.Cru_Fecha_Hora_Salida || c.cru_fecha_hora_salida || "",
      fechaLlegada: c.Cru_Fecha_Hora_Llegada || c.cru_fecha_hora_lllegada || "",
      costo,
      cantidadMillas,
      huellaCarbono
    }
  }

  const mapearTraslado = (t: any): Traslado => {
    const idRaw = t.TT_COD || t.tt_cod
    const id = idRaw?.toString() || ""
    const costoRaw = t.TT_Costo || t.tt_costo || "0"
    const costo = parseFloat(costoRaw) || 0
    const millasRaw = t.TT_Cant_Millas || t.tt_cant_millas || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0
    const huellaRaw = t.TT_Huella_Carbono || t.tt_huella_carbono || "0"
    const huellaCarbono = parseFloat(huellaRaw) || 0

    return {
      id,
      origen: t.origen || "Origen",
      destino: t.destino || "Destino",
      fechaSalida: t.TT_Fecha_Hora_Salida || t.tt_fecha_hora_salida || "",
      fechaLlegada: t.TT_Fecha_Hora_Llegada || t.tt_fecha_hora_llegada || "",
      costo,
      cantidadMillas,
      huellaCarbono
    }
  }

  const mapearServicio = (s: any): ServicioAdicional => {
    const idRaw = s.sa_cod
    const id = idRaw?.toString() || ""
    const costoRaw = s.sa_costo || "0"
    const costo = parseFloat(costoRaw) || 0
    const millasRaw = s.sa_cant_milla || s.Sa_Cant_Milla || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0

    return {
      id,
      nombre: s.sa_nombre || "Servicio",
      descripcion: s.sa_descripcion || "",
      costo,
      tipo: s.sa_tipo || "",
      cantidadMillas
    }
  }

  const mapearHospedaje = (h: any): Hospedaje => {
    const idRaw = h.Hos_COD || h.hos_cod
    const id = idRaw?.toString() || ""
    const costoRaw = h.Hos_Costo || h.hos_costo || "0"
    const costo = parseFloat(costoRaw) || 0
    const millasRaw = h.Hot_Cant_Milla || h.hot_cant_milla || "0"
    const cantidadMillas = parseFloat(millasRaw) || 0

    return {
      id,
      hotelNombre: h.hotel_nombre || h.hotelNombre || "Hotel",
      fechaInicio: h.Hos_Fecha_Hora_Inicio || h.hos_fecha_hora_inicio || "",
      fechaFin: h.Hos_Fecha_Hora_Fin || h.hos_fecha_hora_fin || "",
      costo,
      cantidadMillas
    }
  }

  const mapearRestaurante = (r: any): Restaurante => {
    const idRaw = r.rest_cod
    const id = idRaw?.toString() || ""

    return {
      id,
      nombre: r.rest_nombre || "Restaurante",
      direccion: r.rest_direccion || "",
      clasificacion: r.rest_clasificacion || "",
      tipoComida: r.rest_tipo_comida || "",
      ambiente: r.rest_ambiente || ""
    }
  }

  useEffect(() => {
    const cargarDatos = async () => {
      try {
        setIsLoading(true)

        // Cargar todos los datos en paralelo
        const [vuelosRes, crucerosRes, trasladosRes, serviciosRes, hospedajesRes, restaurantesRes] = await Promise.all([
          fetch("/api/vuelo"),
          fetch("/api/crucero"),
          fetch("/api/traslado"),
          fetch("/api/servicio-adicional"),
          fetch("/api/hospedaje"),
          fetch("/api/restaurante"),
        ])

        if (vuelosRes.ok) {
          const data = await vuelosRes.json()
          if (data.data && Array.isArray(data.data)) {
            setVuelos(data.data.map(mapearVuelo))
          }
        }

        if (crucerosRes.ok) {
          const data = await crucerosRes.json()
          if (data.data && Array.isArray(data.data)) {
            setCruceros(data.data.map(mapearCrucero))
          }
        }

        if (trasladosRes.ok) {
          const data = await trasladosRes.json()
          if (data.data && Array.isArray(data.data)) {
            setTraslados(data.data.map(mapearTraslado))
          }
        }

        if (serviciosRes.ok) {
          const data = await serviciosRes.json()
          if (data.data && Array.isArray(data.data)) {
            setServiciosAdicionales(data.data.map(mapearServicio))
          }
        }

        if (hospedajesRes.ok) {
          const data = await hospedajesRes.json()
          if (data.data && Array.isArray(data.data)) {
            setHospedajes(data.data.map(mapearHospedaje))
          }
        }

        if (restaurantesRes.ok) {
          const data = await restaurantesRes.json()
          if (data.data && Array.isArray(data.data)) {
            setRestaurantes(data.data.map(mapearRestaurante))
          }
        }
      } catch (error) {
        console.error("Error al cargar datos:", error)
        toast({
          title: "Error",
          description: "No se pudieron cargar los servicios",
          variant: "destructive",
        })
      } finally {
        setIsLoading(false)
      }
    }

    cargarDatos()
  }, [toast])

  const formatDate = (dateString: string) => {
    try {
      return new Date(dateString).toLocaleString("es-ES", {
        year: "numeric",
        month: "short",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      })
    } catch {
      return dateString
    }
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Cargando servicios...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Gestión de Flota</h1>
        <p className="text-muted-foreground">Administra tus vuelos, cruceros, traslados, servicios adicionales, hospedajes y restaurantes</p>
      </div>

      <Tabs defaultValue="vuelos" className="space-y-4">
        <TabsList className="grid w-full grid-cols-6">
          <TabsTrigger value="vuelos" className="gap-2">
            <Plane className="h-4 w-4" />
            Vuelos ({vuelos.length})
          </TabsTrigger>
          <TabsTrigger value="cruceros" className="gap-2">
            <Ship className="h-4 w-4" />
            Cruceros ({cruceros.length})
          </TabsTrigger>
          <TabsTrigger value="traslados" className="gap-2">
            <Bus className="h-4 w-4" />
            Traslados ({traslados.length})
          </TabsTrigger>
          <TabsTrigger value="serviciosAdicionales" className="gap-2">
            <Briefcase className="h-4 w-4" />
            Servicios ({serviciosAdicionales.length})
          </TabsTrigger>
          <TabsTrigger value="hospedajes" className="gap-2">
            <Hotel className="h-4 w-4" />
            Hospedajes ({hospedajes.length})
          </TabsTrigger>
          <TabsTrigger value="restaurantes" className="gap-2">
            <UtensilsCrossed className="h-4 w-4" />
            Restaurantes ({restaurantes.length})
          </TabsTrigger>
        </TabsList>

        <TabsContent value="vuelos" className="space-y-4">
          {vuelos.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay vuelos registrados
              </CardContent>
            </Card>
          ) : (
            vuelos.map((vuelo) => (
              <Card key={vuelo.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <Plane className="h-5 w-5 text-primary" />
                        {vuelo.numero}
                      </CardTitle>
                      <CardDescription>
                        {vuelo.origen} → {vuelo.destino}
                      </CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {vuelo.cantidadMillas && vuelo.cantidadMillas > 0 && (
                        <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                          ✈️ {vuelo.cantidadMillas.toLocaleString()} millas
                        </Badge>
                      )}
                      {vuelo.huellaCarbono && vuelo.huellaCarbono > 0 && (
                        <Badge variant="secondary" className="bg-green-100 text-green-700">
                          🌱 {vuelo.huellaCarbono.toFixed(2)} kg CO₂
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-3 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha Salida</p>
                      <p className="font-medium">{formatDate(vuelo.fecha)}</p>
                    </div>
                    {vuelo.fechaLlegada && (
                      <div>
                        <p className="text-muted-foreground">Fecha Llegada</p>
                        <p className="font-medium">{formatDate(vuelo.fechaLlegada)}</p>
                      </div>
                    )}
                    <div>
                      <p className="text-muted-foreground">Precio</p>
                      <p className="font-medium text-primary">${vuelo.costo.toFixed(2)}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>

        <TabsContent value="cruceros" className="space-y-4">
          {cruceros.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay cruceros registrados
              </CardContent>
            </Card>
          ) : (
            cruceros.map((crucero) => (
              <Card key={crucero.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <Ship className="h-5 w-5 text-accent" />
                        {crucero.nombre}
                      </CardTitle>
                      <CardDescription>
                        {crucero.origen} → {crucero.destino}
                      </CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {crucero.cantidadMillas && crucero.cantidadMillas > 0 && (
                        <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                          🚢 {crucero.cantidadMillas.toLocaleString()} millas
                        </Badge>
                      )}
                      {crucero.huellaCarbono && crucero.huellaCarbono > 0 && (
                        <Badge variant="secondary" className="bg-green-100 text-green-700">
                          🌱 {crucero.huellaCarbono.toFixed(2)} kg CO₂
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-3 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha Salida</p>
                      <p className="font-medium">{formatDate(crucero.fechaSalida)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha Llegada</p>
                      <p className="font-medium">{formatDate(crucero.fechaLlegada)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Precio</p>
                      <p className="font-medium text-primary">${crucero.costo.toFixed(2)}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>

        <TabsContent value="traslados" className="space-y-4">
          {traslados.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay traslados registrados
              </CardContent>
            </Card>
          ) : (
            traslados.map((traslado) => (
              <Card key={traslado.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <Bus className="h-5 w-5 text-secondary" />
                        Traslado #{traslado.id}
                      </CardTitle>
                      <CardDescription>
                        {traslado.origen} → {traslado.destino}
                      </CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {traslado.cantidadMillas && traslado.cantidadMillas > 0 && (
                        <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                          🚌 {traslado.cantidadMillas.toLocaleString()} millas
                        </Badge>
                      )}
                      {traslado.huellaCarbono && traslado.huellaCarbono > 0 && (
                        <Badge variant="secondary" className="bg-green-100 text-green-700">
                          🌱 {traslado.huellaCarbono.toFixed(2)} kg CO₂
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-3 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha Salida</p>
                      <p className="font-medium">{formatDate(traslado.fechaSalida)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha Llegada</p>
                      <p className="font-medium">{formatDate(traslado.fechaLlegada)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Precio</p>
                      <p className="font-medium text-primary">${traslado.costo.toFixed(2)}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>

        <TabsContent value="serviciosAdicionales" className="space-y-4">
          {serviciosAdicionales.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay servicios adicionales registrados
              </CardContent>
            </Card>
          ) : (
            serviciosAdicionales.map((servicio) => (
              <Card key={servicio.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <Briefcase className="h-5 w-5 text-primary" />
                        {servicio.nombre}
                      </CardTitle>
                      <CardDescription>{servicio.descripcion}</CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {servicio.tipo && (
                        <Badge variant="outline">{servicio.tipo}</Badge>
                      )}
                      {servicio.cantidadMillas && servicio.cantidadMillas > 0 && (
                        <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                          💼 {servicio.cantidadMillas.toLocaleString()} millas
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="flex justify-between items-center">
                    <div>
                      <p className="text-muted-foreground text-sm">Precio</p>
                      <p className="font-medium text-primary text-lg">${servicio.costo.toFixed(2)}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>

        <TabsContent value="hospedajes" className="space-y-4">
          {hospedajes.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay hospedajes registrados
              </CardContent>
            </Card>
          ) : (
            hospedajes.map((hospedaje) => (
              <Card key={hospedaje.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <Hotel className="h-5 w-5 text-accent" />
                        {hospedaje.hotelNombre}
                      </CardTitle>
                      <CardDescription>Hospedaje #{hospedaje.id}</CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {hospedaje.cantidadMillas && hospedaje.cantidadMillas > 0 && (
                        <Badge variant="secondary" className="bg-blue-100 text-blue-700">
                          🏨 {hospedaje.cantidadMillas.toLocaleString()} millas
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-3 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha Inicio</p>
                      <p className="font-medium">{formatDate(hospedaje.fechaInicio)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha Fin</p>
                      <p className="font-medium">{formatDate(hospedaje.fechaFin)}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Precio</p>
                      <p className="font-medium text-primary">${hospedaje.costo.toFixed(2)}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>

        <TabsContent value="restaurantes" className="space-y-4">
          {restaurantes.length === 0 ? (
            <Card>
              <CardContent className="p-6 text-center text-muted-foreground">
                No hay restaurantes registrados
              </CardContent>
            </Card>
          ) : (
            restaurantes.map((restaurante) => (
              <Card key={restaurante.id} className="transition-shadow hover:shadow-md">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="flex items-center gap-2">
                        <UtensilsCrossed className="h-5 w-5 text-orange-500" />
                        {restaurante.nombre}
                      </CardTitle>
                      <CardDescription>{restaurante.direccion}</CardDescription>
                    </div>
                    <div className="flex gap-2">
                      {restaurante.clasificacion && (
                        <Badge variant="secondary" className="bg-yellow-100 text-yellow-700">
                          ⭐ {restaurante.clasificacion}
                        </Badge>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    {restaurante.tipoComida && (
                      <div>
                        <p className="text-muted-foreground">Tipo de Comida</p>
                        <p className="font-medium">{restaurante.tipoComida}</p>
                      </div>
                    )}
                    {restaurante.ambiente && (
                      <div>
                        <p className="text-muted-foreground">Ambiente</p>
                        <p className="font-medium">{restaurante.ambiente}</p>
                      </div>
                    )}
                  </div>
                </CardContent>
              </Card>
            ))
          )}
        </TabsContent>
      </Tabs>
    </div>
  )
}

