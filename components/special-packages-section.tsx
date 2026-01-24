"use client"

import { useState, useEffect } from "react"
import Image from "next/image"
import { Package as PackageIcon } from "lucide-react"
import { Card, CardContent } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { useCurrency } from "@/lib/currency-context"
import { useRouter } from "next/navigation"
import { useToast } from "@/hooks/use-toast"

type PaqueteBD = {
  id: number
  nombre: string
  descripcion: string
  costo: number
  costoMillas?: number
  cantidadMillas?: number
  tipo: string
}

export function SpecialPackagesSection() {
  const { formatPrice } = useCurrency()
  const router = useRouter()
  const { toast } = useToast()
  const [paquetes, setPaquetes] = useState<PaqueteBD[]>([])
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const cargarPaquetes = async () => {
      try {
        const res = await fetch("/api/paquete-turistico?id=0")
        if (res.ok) {
          const data = await res.json()
          console.log("📦 Paquetes BD en home:", data)
          if (data.status === "success" && Array.isArray(data.data)) {
            console.log("✅ Paquetes cargados:", data.data.length)
            setPaquetes(data.data)
          }
        }
      } catch (error) {
        console.error("❌ Error cargando paquetes:", error)
        toast({
          title: "Error",
          description: "No se pudieron cargar los paquetes turísticos",
          variant: "destructive",
        })
      } finally {
        setIsLoading(false)
      }
    }
    cargarPaquetes()
  }, [toast])

  const handleViewPackage = (packageId: number) => {
    router.push(`/clientes/itinerario`)
  }

  if (isLoading) {
    return (
      <section className="py-16 lg:py-24 bg-background">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="mb-12 text-center">
            <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4">Paquetes Turísticos</h2>
            <p className="text-lg text-muted-foreground">Explora nuestros mejores paquetes de viaje</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {[1, 2, 3, 4, 5, 6].map((i) => (
              <Card key={i} className="animate-pulse overflow-hidden">
                <div className="h-48 w-full bg-gray-200" />
                <CardContent className="p-6 space-y-4">
                  <div className="h-6 bg-gray-200 rounded w-3/4" />
                  <div className="h-4 bg-gray-200 rounded w-1/2" />
                  <div className="h-4 bg-gray-200 rounded w-full" />
                  <div className="h-4 bg-gray-200 rounded w-5/6" />
                  <div className="h-10 bg-gray-200 rounded w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>
    )
  }

  if (paquetes.length === 0) {
    return (
      <section className="py-16 lg:py-24 bg-background">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="mb-12 text-center">
            <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4">Paquetes Turísticos</h2>
            <p className="text-lg text-muted-foreground">No hay paquetes disponibles en este momento</p>
          </div>
        </div>
      </section>
    )
  }

  return (
    <section className="py-16 lg:py-24 bg-background">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="mb-12 text-center">
          <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4">Paquetes Turísticos</h2>
          <p className="text-lg text-muted-foreground">Descubre nuestros mejores paquetes de viaje</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {paquetes.map((pkg) => {
            const esEspecial = pkg.tipo?.toLowerCase() === "especial"
            
            return (
              <Card
                key={pkg.id}
                className="overflow-hidden hover:shadow-xl transition-all duration-300 cursor-pointer group"
                onClick={() => handleViewPackage(pkg.id)}
              >
                <div className="relative h-48 w-full overflow-hidden bg-gradient-to-br from-blue-100 to-blue-200 dark:from-blue-900 dark:to-blue-800">
                  <div className="absolute inset-0 flex items-center justify-center">
                    <PackageIcon className="h-20 w-20 text-blue-500 dark:text-blue-300 opacity-50" />
                  </div>
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/10 to-transparent" />
                  
                  {esEspecial && (
                    <Badge className="absolute top-3 right-3 bg-gradient-to-r from-yellow-500 to-orange-500">
                      ⭐ Especial
                    </Badge>
                  )}
                  
                  <div className="absolute bottom-3 left-3 flex items-center gap-2 text-white">
                    <PackageIcon className="h-5 w-5" />
                    <span className="text-sm font-semibold">{pkg.nombre}</span>
                  </div>
                </div>

                <CardContent className="p-6">
                  <h3 className="text-xl font-bold mb-2 line-clamp-1">{pkg.nombre}</h3>
                  <p className="text-sm text-muted-foreground mb-4 line-clamp-2">
                    {pkg.descripcion}
                  </p>

                  <div className="flex flex-wrap gap-2 mb-4">
                    <Badge variant="secondary" className="text-xs">
                      💰 {formatPrice(pkg.costo)}
                    </Badge>
                    {pkg.cantidadMillas && pkg.cantidadMillas > 0 && (
                      <Badge variant="outline" className="text-xs text-blue-600">
                        ✈️ +{pkg.cantidadMillas} millas
                      </Badge>
                    )}
                    {pkg.costoMillas && pkg.costoMillas > 0 && (
                      <Badge variant="outline" className="text-xs">
                        💎 {pkg.costoMillas} millas
                      </Badge>
                    )}
                  </div>

                  <Button className="w-full" onClick={() => handleViewPackage(pkg.id)}>
                    Ver detalles
                  </Button>
                </CardContent>
              </Card>
            )
          })}
        </div>
      </div>
    </section>
  )
}
