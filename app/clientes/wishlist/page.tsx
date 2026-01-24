"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent, CardFooter } from "@/components/ui/card"
import { useWishlist } from "@/lib/wishlist-context"
import { useCurrency } from "@/lib/currency-context"
import { Heart, Trash2, ArrowLeft, Loader2 } from "lucide-react"
import Link from "next/link"
import { useRouter } from "next/navigation"

export default function WishlistPage() {
  const { wishlist, isLoading, removeFromWishlist } = useWishlist()
  const { formatPrice } = useCurrency()
  const router = useRouter()

  if (isLoading) {
    return (
      <main className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="max-w-2xl mx-auto">
            <div className="flex justify-center items-center py-16">
              <Loader2 className="h-8 w-8 animate-spin text-primary" />
              <p className="ml-4 text-muted-foreground">Cargando wishlist...</p>
            </div>
          </div>
        </div>
      </main>
    )
  }

  if (!wishlist || wishlist.length === 0) {
    return (
      <main className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="max-w-2xl mx-auto">
            <div className="mb-6">
              <Button variant="ghost" onClick={() => router.push("/")} className="gap-2">
                <ArrowLeft className="h-4 w-4" />
                Volver
              </Button>
            </div>
            <div className="text-center py-16">
              <Heart className="h-24 w-24 mx-auto text-muted-foreground mb-6" />
              <h1 className="text-3xl font-bold mb-4">Tu wishlist está vacía</h1>
              <p className="text-muted-foreground mb-8">
                Crea itinerarios y agrega los que más te gusten a tu wishlist
              </p>
              <Link href="/clientes/itinerario">
                <Button size="lg">Crear Itinerario</Button>
              </Link>
            </div>
          </div>
        </div>
      </main>
    )
  }

  return (
    <main className="min-h-screen bg-background py-12">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-6xl mx-auto">
          <div className="mb-6">
            <Button variant="ghost" onClick={() => router.push("/")} className="gap-2">
              <ArrowLeft className="h-4 w-4" />
              Volver
            </Button>
          </div>
          <div className="mb-8">
            <h1 className="text-3xl font-bold mb-2">Mi Wishlist ({wishlist.length})</h1>
            <p className="text-muted-foreground">Tus itinerarios guardados para consultar más tarde</p>
          </div>

          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {wishlist.map((item) => {
              return (
                <Card key={item.wishlist_id} className="overflow-hidden hover:shadow-lg transition-shadow">
                  <div className="relative">
                    <div
                      className="h-48 w-full bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center cursor-pointer"
                      onClick={() => router.push(`/clientes/itinerario`)}
                    >
                      <Heart className="h-16 w-16 text-primary/30" />
                    </div>
                    <button
                      onClick={() => removeFromWishlist(item.wishlist_id)}
                      className="absolute top-3 right-3 p-2 rounded-full bg-background/80 backdrop-blur-sm hover:bg-background transition-all"
                    >
                      <Trash2 className="h-4 w-4 text-destructive" />
                    </button>
                    <div className="absolute top-3 left-3 p-2 rounded-full bg-primary/80 backdrop-blur-sm">
                      <Heart className="h-4 w-4 text-primary-foreground fill-current" />
                    </div>
                  </div>
                  <CardContent className="p-4">
                    <h3 className="font-bold text-lg mb-1 line-clamp-1">Itinerario #{item.itinerario_id}</h3>
                    <p className="text-sm text-muted-foreground mb-3 line-clamp-2">{item.descripcion}</p>
                    <div className="space-y-2 text-sm">
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">Fecha inicio:</span>
                        <span className="font-medium">
                          {new Date(item.fecha_inicio).toLocaleDateString("es-ES", {
                            day: "numeric",
                            month: "short",
                            year: "numeric",
                          })}
                        </span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">Fecha fin:</span>
                        <span className="font-medium">
                          {new Date(item.fecha_fin).toLocaleDateString("es-ES", {
                            day: "numeric",
                            month: "short",
                            year: "numeric",
                          })}
                        </span>
                      </div>
                      <div className="flex justify-between items-baseline pt-2 border-t">
                        <span className="text-muted-foreground">Costo total:</span>
                        <span className="text-xl font-bold text-primary">{formatPrice(item.costo_total)}</span>
                      </div>
                    </div>
                  </CardContent>
                  <CardFooter className="p-4 pt-0">
                    <Button className="w-full" onClick={() => router.push(`/clientes/itinerario`)}>
                      Ver Itinerario
                    </Button>
                  </CardFooter>
                </Card>
              )
            })}
          </div>
        </div>
      </div>
    </main>
  )
}
