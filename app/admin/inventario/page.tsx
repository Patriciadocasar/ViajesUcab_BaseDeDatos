"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Progress } from "@/components/ui/progress"
import { Plane, Ship, MapPin, AlertTriangle, Plus, Pencil, Trash2, Building2, Car, Package, Tag } from "lucide-react"
import { InventarioDialog } from "@/components/inventario-dialog"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useToast } from "@/hooks/use-toast"

type Vuelo = {
  id: string
  numero: string
  origen: string
  destino: string
  fecha: string
  asientosTotal: number
  asientosDisponibles: number
}

type Crucero = {
  id: string
  nombre: string
  ruta: string
  fechaSalida: string
  capacidadTotal: number
  capacidadDisponible: number
}

type Tour = {
  id: string
  nombre: string
  destino: string
  fecha: string
  capacidadTotal: number
  capacidadDisponible: number
}

type Aerolinea = {
  id: string
  idReal?: string | null
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type CompaniaCrucero = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type CompaniaTransporteTerrestre = {
  id: string
  nombre: string
  direccion: string
  telefono: string
  correo: string
  fechaFundacion: string
}

type PaqueteTuristico = {
  id: string
  nombre: string
  descripcion: string
  costo: number
  costoMillas: number
  millasOtorga: number
  tipo: "especial" | "regular"
}

type Promocion = {
  id: string
  tipo: string
  fechaInicio: string
  fechaFin: string
  porcentajeDescuento: number
}

const vuelosDataInicial: Vuelo[] = [
  {
    id: "1",
    numero: "VU-101",
    origen: "Caracas",
    destino: "Miami",
    fecha: "2025-03-25",
    asientosTotal: 180,
    asientosDisponibles: 12,
  },
  {
    id: "2",
    numero: "VU-202",
    origen: "Caracas",
    destino: "Madrid",
    fecha: "2025-03-28",
    asientosTotal: 250,
    asientosDisponibles: 45,
  },
  {
    id: "3",
    numero: "VU-303",
    origen: "Caracas",
    destino: "Cancún",
    fecha: "2025-03-30",
    asientosTotal: 150,
    asientosDisponibles: 3,
  },
]

const crucerosDataInicial: Crucero[] = [
  {
    id: "1",
    nombre: "Caribbean Dream",
    ruta: "Caribe Oriental",
    fechaSalida: "2025-04-10",
    capacidadTotal: 2000,
    capacidadDisponible: 150,
  },
  {
    id: "2",
    nombre: "Ocean Paradise",
    ruta: "Mediterráneo",
    fechaSalida: "2025-05-15",
    capacidadTotal: 3000,
    capacidadDisponible: 800,
  },
  {
    id: "3",
    nombre: "Tropical Explorer",
    ruta: "Caribe Sur",
    fechaSalida: "2025-04-20",
    capacidadTotal: 1500,
    capacidadDisponible: 50,
  },
]

const toursDataInicial: Tour[] = [
  {
    id: "1",
    nombre: "Tour Machu Picchu",
    destino: "Perú",
    fecha: "2025-04-05",
    capacidadTotal: 30,
    capacidadDisponible: 2,
  },
  {
    id: "2",
    nombre: "Safari Africano",
    destino: "Kenia",
    fecha: "2025-05-20",
    capacidadTotal: 25,
    capacidadDisponible: 15,
  },
  {
    id: "3",
    nombre: "Tour Patagonia",
    destino: "Argentina",
    fecha: "2025-06-10",
    capacidadTotal: 20,
    capacidadDisponible: 8,
  },
]

export default function InventarioPage() {
  const { toast } = useToast()
  const [vuelos, setVuelos] = useState<Vuelo[]>(vuelosDataInicial)
  const [cruceros, setCruceros] = useState<Crucero[]>(crucerosDataInicial)
  const [tours, setTours] = useState<Tour[]>(toursDataInicial)
  const [aerolineas, setAerolineas] = useState<Aerolinea[]>([])
  const [companiasCrucero, setCompaniasCrucero] = useState<CompaniaCrucero[]>([])
  const [companiasTransporte, setCompaniasTransporte] = useState<CompaniaTransporteTerrestre[]>([])
  const [paquetesTuristicos, setPaquetesTuristicos] = useState<PaqueteTuristico[]>([])
  const [promociones, setPromociones] = useState<Promocion[]>([])
  const [dialogOpen, setDialogOpen] = useState(false)
  const [tipoActual, setTipoActual] = useState<
    "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "promocion"
  >("vuelo")
  const [itemSeleccionado, setItemSeleccionado] = useState<
    Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Promocion | null
  >(null)
  const [modoEdicion, setModoEdicion] = useState(false)

  // Función helper para mapear aerolíneas de la base de datos
  const mapearAerolinea = (a: any, index: number): Aerolinea => {
    // Buscar el ID en todas las posibles variaciones de nombres de columnas
    const idRaw = a.Aerolinea_COD 
      || a.aerolinea_cod 
      || a.aerolinea_COD
      || a.Aerolinea_cod
      || a.AerolineaCod
      || a.aerolineaCod
      || a.cod
      || a.COD
      || a.id
      || Object.values(a).find((val: any) => typeof val === 'number' && val > 0)
    
    // Solo usar el ID si es un número válido
    const idReal = idRaw != null && !isNaN(Number(idRaw)) ? idRaw.toString() : null
    
    return {
      id: idReal || `temp-${index}`,
      idReal: idReal,
      nombre: a.Aerolinea_Nombre || a.aerolinea_nombre || a.Pro_Nombre || a.pro_nombre || a.nombre || a.Nombre || "",
      direccion: a.Aerolinea_Direccion || a.aerolinea_direccion || a.Pro_Direccion || a.pro_direccion || a.direccion || a.Direccion || "",
      telefono: a.Aerolinea_Telefono?.toString() || a.aerolinea_telefono?.toString() || a.Pro_Telefono?.toString() || a.pro_telefono?.toString() || a.telefono?.toString() || a.Telefono?.toString() || "",
      correo: a.Aerolinea_Correo || a.aerolinea_correo || a.Pro_Correo || a.pro_correo || a.correo || a.Correo || "",
      fechaFundacion: a.Aerolinea_Fecha_Fundacion || a.aerolinea_fecha_fundacion || a.A_Fecha_Fundacion || a.a_fecha_fundacion || a.fechaFundacion || a.fecha_fundacion || a.Fecha_Fundacion || "",
    }
  }

  // Cargar aerolíneas desde la base de datos al montar el componente
  useEffect(() => {
    const cargarAerolineas = async () => {
      try {
        const res = await fetch("/api/aerolinea")
        const data = await res.json()
        
        console.log("Respuesta completa de API aerolíneas:", data) // Debug
        
        if (data.status === "success" && Array.isArray(data.data)) {
          // Log para ver la estructura del primer elemento
          if (data.data.length > 0) {
            console.log("Estructura de una aerolínea:", data.data[0])
          }
          
          // Normalizar los datos usando la función helper
          const aerolineasFormateadas = data.data.map((a: any, index: number) => mapearAerolinea(a, index))
          
          console.log("Aerolíneas formateadas:", aerolineasFormateadas) // Debug
          setAerolineas(aerolineasFormateadas)
        } else {
          console.error("Estructura de respuesta inesperada:", data)
        }
      } catch (error) {
        console.error("Error cargando aerolíneas:", error)
      }
    }

    cargarAerolineas()
  }, [])

  const calcularPorcentaje = (disponible: number, total: number) => {
    return ((disponible / total) * 100).toFixed(0)
  }

  const obtenerEstado = (disponible: number, total: number) => {
    const porcentaje = (disponible / total) * 100
    if (porcentaje <= 10) return { label: "Crítico", variant: "destructive" as const }
    if (porcentaje <= 30) return { label: "Bajo", variant: "default" as const }
    return { label: "Disponible", variant: "secondary" as const }
  }

  const handleAgregar = (
    tipo: "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "promocion"
  ) => {
    setTipoActual(tipo)
    setItemSeleccionado(null)
    setModoEdicion(false)
    setDialogOpen(true)
  }

  const handleEditar = (
    item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Promocion,
    tipo: "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "promocion"
  ) => {
    setTipoActual(tipo)
    setItemSeleccionado(item)
    setModoEdicion(true)
    setDialogOpen(true)
  }

  const handleEliminar = async (
    id: string,
    tipo: "vuelo" | "crucero" | "tour" | "aerolinea" | "compania-crucero" | "compania-transporte" | "paquete" | "promocion"
  ) => {
    if (confirm("¿Estás seguro de que deseas eliminar este elemento?")) {
      if (tipo === "vuelo") {
        setVuelos(vuelos.filter((v) => v.id !== id))
      } else if (tipo === "crucero") {
        setCruceros(cruceros.filter((c) => c.id !== id))
      } else if (tipo === "tour") {
        setTours(tours.filter((t) => t.id !== id))
      } else if (tipo === "aerolinea") {
        // Buscar la aerolínea para obtener el ID real
        const aerolinea = aerolineas.find(a => a.id === id)
        const idReal = aerolinea?.idReal || (id.startsWith("temp-") ? null : id)
        
        // Validar que tengamos un ID válido (numérico)
        if (!idReal || idReal.startsWith("temp-") || idReal.startsWith("aerolinea-")) {
          toast({
            title: "Error",
            description: "No se puede eliminar esta aerolínea porque no tiene un ID válido de la base de datos",
            variant: "destructive",
          })
          return
        }
        
        try {
          const res = await fetch("/api/aerolinea", {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id: idReal }),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea eliminada",
              description: "La aerolínea se ha eliminado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo eliminar la aerolínea",
              variant: "destructive",
            })
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
        }
      } else if (tipo === "compania-crucero") {
        setCompaniasCrucero(companiasCrucero.filter((c) => c.id !== id))
      } else if (tipo === "compania-transporte") {
        setCompaniasTransporte(companiasTransporte.filter((c) => c.id !== id))
      } else if (tipo === "paquete") {
        setPaquetesTuristicos(paquetesTuristicos.filter((p) => p.id !== id))
      } else if (tipo === "promocion") {
        setPromociones(promociones.filter((p) => p.id !== id))
      }
    }
  }

  const handleGuardar = async (
    item: Vuelo | Crucero | Tour | Aerolinea | CompaniaCrucero | CompaniaTransporteTerrestre | PaqueteTuristico | Promocion
  ) => {
    if (tipoActual === "vuelo") {
      const vuelo = item as Vuelo
      if (modoEdicion) {
        setVuelos(vuelos.map((v) => (v.id === vuelo.id ? vuelo : v)))
      } else {
        setVuelos([...vuelos, { ...vuelo, id: Date.now().toString() }])
      }
    } else if (tipoActual === "crucero") {
      const crucero = item as Crucero
      if (modoEdicion) {
        setCruceros(cruceros.map((c) => (c.id === crucero.id ? crucero : c)))
      } else {
        setCruceros([...cruceros, { ...crucero, id: Date.now().toString() }])
      }
    } else if (tipoActual === "tour") {
      const tour = item as Tour
      if (modoEdicion) {
        setTours(tours.map((t) => (t.id === tour.id ? tour : t)))
      } else {
        setTours([...tours, { ...tour, id: Date.now().toString() }])
      }
    } else if (tipoActual === "aerolinea") {
      const aerolinea = item as Aerolinea
      if (modoEdicion) {
        try {
          const res = await fetch("/api/aerolinea", {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              id: aerolinea.id,
              nombre: aerolinea.nombre,
              direccion: aerolinea.direccion,
              telefono: aerolinea.telefono,
              correo: aerolinea.correo,
              fechaFundacion: aerolinea.fechaFundacion,
            }),
          })

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea actualizada",
              description: "La aerolínea se ha actualizado exitosamente",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo actualizar la aerolínea",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      } else {
        try {
          const res = await fetch("/api/aerolinea", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              nombre: aerolinea.nombre,
              direccion: aerolinea.direccion,
              telefono: aerolinea.telefono,
              correo: aerolinea.correo,
              fechaFundacion: aerolinea.fechaFundacion,
            }),
          })

          if (!res.ok) {
            const errorData = await res.json().catch(() => ({ message: "Error de conexión con el servidor" }))
            toast({
              title: "Error",
              description: errorData.message || `Error ${res.status}: ${res.statusText}`,
              variant: "destructive",
            })
            return
          }

          const data = await res.json()

          if (data.status === "success") {
            // Recargar aerolíneas desde la base de datos
            const resGet = await fetch("/api/aerolinea")
            const dataGet = await resGet.json()
            
            if (dataGet.status === "success" && Array.isArray(dataGet.data)) {
              const aerolineasFormateadas = dataGet.data.map((a: any, index: number) => mapearAerolinea(a, index))
              setAerolineas(aerolineasFormateadas)
            }
            toast({
              title: "Aerolínea agregada",
              description: "La aerolínea se ha guardado exitosamente en la base de datos",
            })
          } else {
            toast({
              title: "Error",
              description: data.message || "No se pudo guardar la aerolínea",
              variant: "destructive",
            })
            return
          }
        } catch (error) {
          toast({
            title: "Error",
            description: "Error de conexión con el servidor",
            variant: "destructive",
          })
          return
        }
      }
    } else if (tipoActual === "compania-crucero") {
      const compania = item as CompaniaCrucero
      if (modoEdicion) {
        setCompaniasCrucero(companiasCrucero.map((c) => (c.id === compania.id ? compania : c)))
      } else {
        setCompaniasCrucero([...companiasCrucero, { ...compania, id: Date.now().toString() }])
      }
    } else if (tipoActual === "compania-transporte") {
      const compania = item as CompaniaTransporteTerrestre
      if (modoEdicion) {
        setCompaniasTransporte(companiasTransporte.map((c) => (c.id === compania.id ? compania : c)))
      } else {
        setCompaniasTransporte([...companiasTransporte, { ...compania, id: Date.now().toString() }])
      }
    } else if (tipoActual === "paquete") {
      const paquete = item as PaqueteTuristico
      if (modoEdicion) {
        setPaquetesTuristicos(paquetesTuristicos.map((p) => (p.id === paquete.id ? paquete : p)))
      } else {
        setPaquetesTuristicos([...paquetesTuristicos, { ...paquete, id: Date.now().toString() }])
      }
    } else if (tipoActual === "promocion") {
      const promocion = item as Promocion
      if (modoEdicion) {
        setPromociones(promociones.map((p) => (p.id === promocion.id ? promocion : p)))
      } else {
        setPromociones([...promociones, { ...promocion, id: Date.now().toString() }])
      }
    }
    setDialogOpen(false)
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-foreground">Inventario</h1>
        <p className="text-muted-foreground">Monitorea la disponibilidad de vuelos, cruceros y tours</p>
      </div>

      <Tabs defaultValue="vuelos" className="space-y-4">
        <TabsList className="grid w-full grid-cols-4 lg:grid-cols-8">
          <TabsTrigger value="vuelos" className="gap-2">
            <Plane className="h-4 w-4" />
            Vuelos
          </TabsTrigger>
          <TabsTrigger value="cruceros" className="gap-2">
            <Ship className="h-4 w-4" />
            Cruceros
          </TabsTrigger>
          <TabsTrigger value="tours" className="gap-2">
            <MapPin className="h-4 w-4" />
            Tours
          </TabsTrigger>
          <TabsTrigger value="aerolineas" className="gap-2">
            <Building2 className="h-4 w-4" />
            Aerolíneas
          </TabsTrigger>
          <TabsTrigger value="companias-crucero" className="gap-2">
            <Ship className="h-4 w-4" />
            Cías. Crucero
          </TabsTrigger>
          <TabsTrigger value="companias-transporte" className="gap-2">
            <Car className="h-4 w-4" />
            Cías. Transporte
          </TabsTrigger>
          <TabsTrigger value="paquetes" className="gap-2">
            <Package className="h-4 w-4" />
            Paquetes
          </TabsTrigger>
          <TabsTrigger value="promociones" className="gap-2">
            <Tag className="h-4 w-4" />
            Promociones
          </TabsTrigger>
        </TabsList>

        <TabsContent value="vuelos" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("vuelo")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Vuelo
            </Button>
          </div>

          {vuelos.map((vuelo) => {
            const estado = obtenerEstado(vuelo.asientosDisponibles, vuelo.asientosTotal)
            const porcentaje = calcularPorcentaje(vuelo.asientosDisponibles, vuelo.asientosTotal)

            return (
              <Card key={vuelo.id} className="hover:shadow-lg transition-shadow">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="flex items-center gap-2">
                        <Plane className="h-5 w-5 text-primary" />
                        Vuelo {vuelo.numero}
                      </CardTitle>
                      <CardDescription>
                        {vuelo.origen} → {vuelo.destino}
                      </CardDescription>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={estado.variant} className="gap-1">
                        {Number(porcentaje) <= 10 && <AlertTriangle className="h-3 w-3" />}
                        {estado.label}
                      </Badge>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEditar(vuelo, "vuelo")}
                        className="h-8 w-8"
                      >
                        <Pencil className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEliminar(vuelo.id, "vuelo")}
                        className="h-8 w-8 text-destructive hover:text-destructive"
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha de salida</p>
                      <p className="font-medium">{new Date(vuelo.fecha).toLocaleDateString("es-ES")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Asientos disponibles</p>
                      <p className="font-medium">
                        {vuelo.asientosDisponibles} / {vuelo.asientosTotal}
                      </p>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">Ocupación</span>
                      <span className="font-medium">{100 - Number(porcentaje)}%</span>
                    </div>
                    <Progress value={100 - Number(porcentaje)} className="h-2" />
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </TabsContent>

        <TabsContent value="cruceros" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("crucero")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Crucero
            </Button>
          </div>

          {cruceros.map((crucero) => {
            const estado = obtenerEstado(crucero.capacidadDisponible, crucero.capacidadTotal)
            const porcentaje = calcularPorcentaje(crucero.capacidadDisponible, crucero.capacidadTotal)

            return (
              <Card key={crucero.id} className="hover:shadow-lg transition-shadow">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="flex items-center gap-2">
                        <Ship className="h-5 w-5 text-accent" />
                        {crucero.nombre}
                      </CardTitle>
                      <CardDescription>{crucero.ruta}</CardDescription>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={estado.variant} className="gap-1">
                        {Number(porcentaje) <= 10 && <AlertTriangle className="h-3 w-3" />}
                        {estado.label}
                      </Badge>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEditar(crucero, "crucero")}
                        className="h-8 w-8"
                      >
                        <Pencil className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEliminar(crucero.id, "crucero")}
                        className="h-8 w-8 text-destructive hover:text-destructive"
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha de salida</p>
                      <p className="font-medium">{new Date(crucero.fechaSalida).toLocaleDateString("es-ES")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Capacidad disponible</p>
                      <p className="font-medium">
                        {crucero.capacidadDisponible} / {crucero.capacidadTotal}
                      </p>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">Ocupación</span>
                      <span className="font-medium">{100 - Number(porcentaje)}%</span>
                    </div>
                    <Progress value={100 - Number(porcentaje)} className="h-2" />
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </TabsContent>

        <TabsContent value="tours" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("tour")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Tour
            </Button>
          </div>

          {tours.map((tour) => {
            const estado = obtenerEstado(tour.capacidadDisponible, tour.capacidadTotal)
            const porcentaje = calcularPorcentaje(tour.capacidadDisponible, tour.capacidadTotal)

            return (
              <Card key={tour.id} className="hover:shadow-lg transition-shadow">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="flex items-center gap-2">
                        <MapPin className="h-5 w-5 text-secondary" />
                        {tour.nombre}
                      </CardTitle>
                      <CardDescription>{tour.destino}</CardDescription>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={estado.variant} className="gap-1">
                        {Number(porcentaje) <= 10 && <AlertTriangle className="h-3 w-3" />}
                        {estado.label}
                      </Badge>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEditar(tour, "tour")}
                        className="h-8 w-8"
                      >
                        <Pencil className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEliminar(tour.id, "tour")}
                        className="h-8 w-8 text-destructive hover:text-destructive"
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha de salida</p>
                      <p className="font-medium">{new Date(tour.fecha).toLocaleDateString("es-ES")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Capacidad disponible</p>
                      <p className="font-medium">
                        {tour.capacidadDisponible} / {tour.capacidadTotal}
                      </p>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">Ocupación</span>
                      <span className="font-medium">{100 - Number(porcentaje)}%</span>
                    </div>
                    <Progress value={100 - Number(porcentaje)} className="h-2" />
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </TabsContent>

        {/* Aerolíneas */}
        <TabsContent value="aerolineas" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("aerolinea")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Aerolínea
            </Button>
          </div>

          {aerolineas.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Building2 className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay aerolíneas registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {aerolineas.map((aerolinea) => (
                <Card key={aerolinea.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Building2 className="h-5 w-5 text-primary" />
                          {aerolinea.nombre}
                        </CardTitle>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(aerolinea, "aerolinea")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(aerolinea.id, "aerolinea")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{aerolinea.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{aerolinea.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{aerolinea.correo}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fundación</p>
                      <p className="font-medium">
                        {aerolinea.fechaFundacion 
                          ? (aerolinea.fechaFundacion.includes("T") 
                              ? new Date(aerolinea.fechaFundacion).toLocaleDateString("es-ES")
                              : aerolinea.fechaFundacion.split("T")[0])
                          : "No disponible"}
                      </p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Compañías de Crucero */}
        <TabsContent value="companias-crucero" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("compania-crucero")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Compañía de Crucero
            </Button>
          </div>

          {companiasCrucero.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Ship className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay compañías de crucero registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {companiasCrucero.map((compania) => (
                <Card key={compania.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Ship className="h-5 w-5 text-accent" />
                          {compania.nombre}
                        </CardTitle>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(compania, "compania-crucero")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(compania.id, "compania-crucero")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{compania.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{compania.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{compania.correo}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fundación</p>
                      <p className="font-medium">{new Date(compania.fechaFundacion).toLocaleDateString("es-ES")}</p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Compañías de Transporte Terrestre */}
        <TabsContent value="companias-transporte" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("compania-transporte")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Compañía de Transporte
            </Button>
          </div>

          {companiasTransporte.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Car className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay compañías de transporte registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {companiasTransporte.map((compania) => (
                <Card key={compania.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Car className="h-5 w-5 text-secondary" />
                          {compania.nombre}
                        </CardTitle>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(compania, "compania-transporte")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(compania.id, "compania-transporte")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Dirección</p>
                      <p className="font-medium">{compania.direccion}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Teléfono</p>
                      <p className="font-medium">{compania.telefono}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Correo</p>
                      <p className="font-medium">{compania.correo}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fundación</p>
                      <p className="font-medium">{new Date(compania.fechaFundacion).toLocaleDateString("es-ES")}</p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Paquetes Turísticos */}
        <TabsContent value="paquetes" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("paquete")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Paquete Turístico
            </Button>
          </div>

          {paquetesTuristicos.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Package className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay paquetes turísticos registrados</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {paquetesTuristicos.map((paquete) => (
                <Card key={paquete.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Package className="h-5 w-5 text-primary" />
                          {paquete.nombre}
                        </CardTitle>
                        <CardDescription className="line-clamp-2">{paquete.descripcion}</CardDescription>
                      </div>
                      <div className="flex items-center gap-2">
                        <Badge variant={paquete.tipo === "especial" ? "default" : "secondary"}>
                          {paquete.tipo}
                        </Badge>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(paquete, "paquete")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(paquete.id, "paquete")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <p className="text-muted-foreground">Costo</p>
                        <p className="font-medium">${paquete.costo.toFixed(2)}</p>
                      </div>
                      <div>
                        <p className="text-muted-foreground">Costo en Millas</p>
                        <p className="font-medium">{paquete.costoMillas}</p>
                      </div>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Millas que Otorga</p>
                      <p className="font-medium">{paquete.millasOtorga}</p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>

        {/* Promociones */}
        <TabsContent value="promociones" className="space-y-4">
          <div className="flex justify-end">
            <Button onClick={() => handleAgregar("promocion")} className="gap-2">
              <Plus className="h-4 w-4" />
              Agregar Promoción
            </Button>
          </div>

          {promociones.length === 0 ? (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <Tag className="h-12 w-12 text-muted-foreground mb-4" />
                <p className="text-muted-foreground">No hay promociones registradas</p>
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
              {promociones.map((promocion) => (
                <Card key={promocion.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div>
                        <CardTitle className="flex items-center gap-2">
                          <Tag className="h-5 w-5 text-primary" />
                          {promocion.tipo}
                        </CardTitle>
                        <CardDescription>
                          {promocion.porcentajeDescuento}% de descuento
                        </CardDescription>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEditar(promocion, "promocion")}
                          className="h-8 w-8"
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleEliminar(promocion.id, "promocion")}
                          className="h-8 w-8 text-destructive hover:text-destructive"
                        >
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <div>
                      <p className="text-muted-foreground">Fecha de Inicio</p>
                      <p className="font-medium">{new Date(promocion.fechaInicio).toLocaleDateString("es-ES")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Fecha de Fin</p>
                      <p className="font-medium">{new Date(promocion.fechaFin).toLocaleDateString("es-ES")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">Descuento</p>
                      <p className="font-medium text-primary">{promocion.porcentajeDescuento}%</p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </TabsContent>
      </Tabs>

      <InventarioDialog
        open={dialogOpen}
        onOpenChange={setDialogOpen}
        tipo={tipoActual}
        item={itemSeleccionado}
        onGuardar={handleGuardar}
        modoEdicion={modoEdicion}
      />
    </div>
  )
}
