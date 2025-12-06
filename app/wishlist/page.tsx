"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent, CardFooter } from "@/components/ui/card"
import { useWishlist } from "@/lib/wishlist-context"
import { useCurrency } from "@/lib/currency-context"
import { Heart, Trash2, ArrowLeft } from "lucide-react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import Image from "next/image"
import { getMainServiceImage } from "@/lib/image-mapper"

export default function WishlistPage() {
  const { items, removeFromWishlist } = useWishlist()
  const { convertPrice } = useCurrency()
  const router = useRouter()

  if (items.length === 0) {
    return (
      <main className="min-h-screen bg-background py-12">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="max-w-2xl mx-auto text-center py-16">
            <Heart className="h-24 w-24 mx-auto text-muted-foreground mb-6" />
            <h1 className="text-3xl font-bold mb-4">Tu wishlist está vacía</h1>
            <p className="text-muted-foreground mb-8">
              Guarda tus servicios favoritos y podrás acceder a ellos fácilmente
            </p>
            <Link href="/">
              <Button size="lg">Explorar servicios</Button>
            </Link>
          </div>
        </div>
      </main>
    )
  }

  return (
    <main className="min-h-screen bg-background py-12">
      <div className="container mx-auto px-4 lg:px-8">
        <div className="max-w-6xl mx-auto">
          <Button variant="ghost" onClick={() => router.push("/")} className="mb-6 gap-2">
            <ArrowLeft className="h-4 w-4" />
            Volver
          </Button>
          <div className="mb-8">
            <h1 className="text-3xl font-bold mb-2">Mi Wishlist ({items.length})</h1>
            <p className="text-muted-foreground">Tus servicios guardados para consultar más tarde</p>
          </div>

          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {items.map((item) => {
              const convertedPrice = convertPrice(item.price)

              return (
                <Card key={item.id} className="overflow-hidden hover:shadow-lg transition-shadow">
                  <div className="relative">
                    <div
                      className="h-48 w-full relative overflow-hidden cursor-pointer group"
                      onClick={() => router.push(`/servicio/${item.id}`)}
                    >
                      <Image
                        src={getMainServiceImage(item.type, item.location, item.title, undefined, item.id)}
                        alt={item.title}
                        fill
                        className="object-cover transition-transform duration-300 group-hover:scale-105"
                        sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent" />
                      <div className="absolute bottom-2 left-2 right-2">
                        <span className="text-xs font-bold text-white bg-primary/80 px-2 py-1 rounded uppercase">
                          {item.type}
                        </span>
                      </div>
                    </div>
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        removeFromWishlist(item.id)
                      }}
                      className="absolute top-3 left-3 p-2 rounded-full bg-background/80 backdrop-blur-sm hover:bg-background transition-all z-10"
                    >
                      <Trash2 className="h-4 w-4 text-destructive" />
                    </button>
                  </div>
                  <CardContent className="p-4">
                    <h3 className="font-bold text-lg mb-1 line-clamp-1">{item.title}</h3>
                    <p className="text-sm text-muted-foreground mb-3">{item.location}</p>
                    <div className="flex items-baseline gap-2">
                      {item.originalPrice && (
                        <span className="text-sm text-muted-foreground line-through">
                          {convertPrice(item.originalPrice).symbol}
                          {convertPrice(item.originalPrice).value.toLocaleString()}
                        </span>
                      )}
                      <span className="text-xl font-bold text-primary">
                        {convertedPrice.symbol}
                        {convertedPrice.value.toLocaleString()}
                      </span>
                    </div>
                  </CardContent>
                  <CardFooter className="p-4 pt-0">
                    <Button className="w-full" onClick={() => router.push(`/servicio/${item.id}`)}>
                      Ver detalle
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
