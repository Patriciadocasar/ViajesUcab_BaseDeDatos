"use client"

import { useEffect } from "react"
import { useRouter } from "next/navigation"
import { useUser } from "@/lib/user-context"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { 
  Package, 
  Plane, 
  Ship, 
  Bus, 
  Hotel, 
  Palmtree,
  BarChart3,
  Calendar,
  DollarSign,
  Users,
  Settings
} from "lucide-react"
import Link from "next/link"

export default function ProveedorDashboard() {
  const { user, isAuthenticated } = useUser()
  const router = useRouter()

  useEffect(() => {
    if (!isAuthenticated) {
      router.push("/auth/login?redirect=/proveedores")
    } else if (user?.role !== 2) {
      // Si no es proveedor, redirigir según su rol
      if (user?.role === 1) {
        router.push("/admin")
      } else {
        router.push("/")
      }
    }
  }, [isAuthenticated, user, router])

  if (!user || user.role !== 2) {
    return null
  }

  const quickActions = [
    {
      title: "Mis Servicios",
      description: "Ver y gestionar servicios ofrecidos",
      icon: Package,
      href: "/proveedores/servicios",
      color: "text-blue-600 bg-blue-50",
    },
    {
      title: "Reservaciones",
      description: "Ver reservaciones activas",
      icon: Calendar,
      href: "/proveedores/reservaciones",
      color: "text-green-600 bg-green-50",
    },
    {
      title: "Estadísticas",
      description: "Analizar rendimiento",
      icon: BarChart3,
      href: "/proveedores/estadisticas",
      color: "text-purple-600 bg-purple-50",
    },
    {
      title: "Facturación",
      description: "Ver ingresos y pagos",
      icon: DollarSign,
      href: "/proveedores/facturacion",
      color: "text-emerald-600 bg-emerald-50",
    },
    {
      title: "Clientes",
      description: "Gestionar clientes",
      icon: Users,
      href: "/proveedores/clientes",
      color: "text-orange-600 bg-orange-50",
    },
    {
      title: "Configuración",
      description: "Ajustes de la cuenta",
      icon: Settings,
      href: "/proveedores/configuracion",
      color: "text-gray-600 bg-gray-50",
    },
  ]

  const servicioIcons = {
    vuelo: Plane,
    crucero: Ship,
    transporte: Bus,
    hospedaje: Hotel,
    operador: Palmtree,
  }

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="border-b bg-card">
        <div className="container mx-auto px-4 py-6">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold">Dashboard de Proveedor</h1>
              <p className="text-muted-foreground mt-1">
                Bienvenido, {user.name}
              </p>
            </div>
            <Button variant="outline" onClick={() => router.push("/")}>
              Volver al Inicio
            </Button>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-8">
        {/* Stats Cards */}
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4 mb-8">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Servicios Activos</CardTitle>
              <Package className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">12</div>
              <p className="text-xs text-muted-foreground">+2 desde el último mes</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Reservaciones</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">45</div>
              <p className="text-xs text-muted-foreground">+12% vs mes anterior</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Ingresos</CardTitle>
              <DollarSign className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">$12,450</div>
              <p className="text-xs text-muted-foreground">+18% vs mes anterior</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Clientes</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">89</div>
              <p className="text-xs text-muted-foreground">+5 nuevos clientes</p>
            </CardContent>
          </Card>
        </div>

        {/* Quick Actions */}
        <div className="mb-8">
          <h2 className="text-2xl font-bold mb-4">Acciones Rápidas</h2>
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {quickActions.map((action) => {
              const Icon = action.icon
              return (
                <Link key={action.href} href={action.href}>
                  <Card className="hover:shadow-lg transition-shadow cursor-pointer h-full">
                    <CardHeader>
                      <div className={`w-12 h-12 rounded-lg ${action.color} flex items-center justify-center mb-2`}>
                        <Icon className="h-6 w-6" />
                      </div>
                      <CardTitle>{action.title}</CardTitle>
                      <CardDescription>{action.description}</CardDescription>
                    </CardHeader>
                  </Card>
                </Link>
              )
            })}
          </div>
        </div>

        {/* Recent Activity */}
        <div className="grid gap-6 lg:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle>Reservaciones Recientes</CardTitle>
              <CardDescription>Últimas reservaciones de tus servicios</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {[
                  { id: "1234", cliente: "Juan Pérez", servicio: "Vuelo CCS-MIA", fecha: "2025-12-20", monto: "$450" },
                  { id: "1235", cliente: "María González", servicio: "Crucero Caribe", fecha: "2025-12-22", monto: "$1,200" },
                  { id: "1236", cliente: "Carlos Rodríguez", servicio: "Hotel Plaza", fecha: "2025-12-25", monto: "$320" },
                ].map((reserva) => (
                  <div key={reserva.id} className="flex items-center justify-between border-b pb-3 last:border-0">
                    <div className="flex-1">
                      <p className="font-medium">{reserva.cliente}</p>
                      <p className="text-sm text-muted-foreground">{reserva.servicio}</p>
                      <p className="text-xs text-muted-foreground">{reserva.fecha}</p>
                    </div>
                    <div className="text-right">
                      <p className="font-bold text-green-600">{reserva.monto}</p>
                      <p className="text-xs text-muted-foreground">#{reserva.id}</p>
                    </div>
                  </div>
                ))}
              </div>
              <Button variant="outline" className="w-full mt-4">
                Ver Todas las Reservaciones
              </Button>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Servicios Destacados</CardTitle>
              <CardDescription>Tus servicios más solicitados</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {[
                  { nombre: "Vuelo CCS-MIA", tipo: "vuelo", reservas: 25, rating: 4.8 },
                  { nombre: "Crucero Caribe Premium", tipo: "crucero", reservas: 18, rating: 4.9 },
                  { nombre: "Hotel Plaza 5*", tipo: "hospedaje", reservas: 32, rating: 4.7 },
                ].map((servicio, index) => {
                  const Icon = servicioIcons[servicio.tipo as keyof typeof servicioIcons]
                  return (
                    <div key={index} className="flex items-center justify-between border-b pb-3 last:border-0">
                      <div className="flex items-center gap-3 flex-1">
                        <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center">
                          <Icon className="h-5 w-5 text-primary" />
                        </div>
                        <div>
                          <p className="font-medium">{servicio.nombre}</p>
                          <p className="text-sm text-muted-foreground">{servicio.reservas} reservaciones</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="font-bold">⭐ {servicio.rating}</p>
                      </div>
                    </div>
                  )
                })}
              </div>
              <Button variant="outline" className="w-full mt-4">
                Ver Todos los Servicios
              </Button>
            </CardContent>
          </Card>
        </div>

        {/* Quick Tips */}
        <Card className="mt-8 border-primary/20 bg-primary/5">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              💡 Consejo Rápido
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-muted-foreground">
              Mantén tus servicios actualizados y responde rápidamente a las reservaciones para mejorar tu calificación.
              Los proveedores con mejor rating reciben hasta un 40% más de reservaciones.
            </p>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
