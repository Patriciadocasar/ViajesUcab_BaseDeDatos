"use client"

import Link from "next/link"
import { useState } from "react"
import { ChevronDown, Heart, Globe, Map, User, LogOut, Shield } from "lucide-react"
import { Button } from "@/components/ui/button"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu"
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback } from "@/components/ui/avatar"
import { useCurrency } from "@/lib/currency-context"
import { useWishlist } from "@/lib/wishlist-context"
import { useUser } from "@/lib/user-context"
import { useToast } from "@/hooks/use-toast"
import { Logo } from "@/components/logo"
import { useRouter, usePathname } from "next/navigation"
import { NotificationsDropdown } from "@/components/notifications-dropdown"

export function Header() {
  const [showLoginModal, setShowLoginModal] = useState(false)
  const [showRegisterModal, setShowRegisterModal] = useState(false)
  const [isRegistering, setIsRegistering] = useState(false)
  const { currency, setCurrency } = useCurrency()
  const { totalItems: wishlistItems } = useWishlist()
  const { user, isAuthenticated, login, logout, hasRole } = useUser()
  const { toast } = useToast()
  const router = useRouter()
  const pathname = usePathname()

  // No mostrar header en rutas de admin o proveedores (tienen su propia navegación)
  if (pathname?.startsWith("/admin") || pathname?.startsWith("/proveedores") || pathname?.startsWith("/auth")) {
    return null
  }

  const handleCurrencyChange = (newCurrency: "USD" | "BS" | "EUR") => {
    setCurrency(newCurrency)
    toast({
      title: "Moneda actualizada",
      description: `Los precios ahora se muestran en ${newCurrency}`,
    })
  }

  const handleLogout = () => {
    logout()
    toast({
      title: "Sesión cerrada",
      description: "Has cerrado sesión exitosamente",
    })
    router.push("/")
  }

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2)
  }

  return (
    <>
      <header className="sticky top-0 z-50 w-full border-b border-border bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="container mx-auto px-4 lg:px-8">
          <div className="flex h-16 items-center justify-between">
            <Link href="/" className="hover:opacity-80 transition-opacity">
              <Logo />
            </Link>

            <div className="flex items-center gap-3">
              {/* Mostrar navegación según rol */}
              {isAuthenticated && user && (
                <>
                  {hasRole([3, 1]) && (
                    <Link href="/clientes/itinerario">
                      <Button variant="ghost" size="sm" className="hidden md:inline-flex gap-2 cursor-pointer">
                        <Map className="h-4 w-4" />
                        Crear Itinerario
                      </Button>
                    </Link>
                  )}
                  {hasRole(1) && (
                    <Link href="/admin">
                      <Button variant="ghost" size="sm" className="hidden md:inline-flex gap-2 cursor-pointer">
                        Dashboard Admin
                      </Button>
                    </Link>
                  )}
                  {hasRole(2) && !hasRole(3) && (
                    <Link href="/proveedores">
                      <Button variant="ghost" size="sm" className="hidden md:inline-flex gap-2 cursor-pointer">
                        Dashboard Proveedor
                      </Button>
                    </Link>
                  )}
                </>
              )}

              {hasRole([3, 1]) && (
                <>
                  <NotificationsDropdown />
                  <Link href="/clientes/wishlist">
                    <Button variant="ghost" size="icon" className="relative cursor-pointer">
                      <Heart className="h-5 w-5" />
                      {wishlistItems > 0 && (
                        <Badge className="absolute -top-1 -right-1 h-5 w-5 flex items-center justify-center p-0 text-xs">
                          {wishlistItems}
                        </Badge>
                      )}
                    </Button>
                  </Link>
                </>
              )}

              {/* Currency Selector */}
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="sm" className="hidden sm:inline-flex gap-1 cursor-pointer">
                    <Globe className="h-4 w-4" />
                    {currency}
                    <ChevronDown className="h-3 w-3" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={() => handleCurrencyChange("USD")} className="cursor-pointer">USD - Dólar</DropdownMenuItem>
                  <DropdownMenuItem onClick={() => handleCurrencyChange("BS")} className="cursor-pointer">BS - Bolívar</DropdownMenuItem>
                  <DropdownMenuItem onClick={() => handleCurrencyChange("EUR")} className="cursor-pointer">EUR - Euro</DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>

              {isAuthenticated && user ? (
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="sm" className="gap-2 cursor-pointer">
                      <Avatar className="h-6 w-6">
                        <AvatarFallback className="text-xs bg-primary text-primary-foreground">
                          {getInitials(user.name)}
                        </AvatarFallback>
                      </Avatar>
                      <span className="hidden md:inline">{user.name.split(" ")[0]}</span>
                      <ChevronDown className="h-3 w-3" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end" className="w-56">
                    <div className="px-2 py-1.5">
                      <p className="text-sm font-medium">{user.name}</p>
                      <p className="text-xs text-muted-foreground">{user.email}</p>
                    </div>
                    <DropdownMenuSeparator />
                    {hasRole(3) && (
                      <DropdownMenuItem onClick={() => router.push("/clientes/perfil")}>
                        <User className="mr-2 h-4 w-4" />
                        Mi Perfil
                      </DropdownMenuItem>
                    )}
                    {hasRole(1) && (
                      <>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem onClick={() => router.push("/admin")}>
                          Panel Administrador
                        </DropdownMenuItem>
                        <DropdownMenuItem onClick={() => router.push("/admin/roles")}>
                          <Shield className="mr-2 h-4 w-4" />
                          Administrar Roles
                        </DropdownMenuItem>
                      </>
                    )}
                    {hasRole(2) && !hasRole(3) && (
                      <DropdownMenuItem onClick={() => router.push("/proveedores")}>
                        Panel Proveedor
                      </DropdownMenuItem>
                    )}
                    <DropdownMenuSeparator />
                    <DropdownMenuItem onClick={handleLogout} className="text-destructive">
                      <LogOut className="mr-2 h-4 w-4" />
                      Cerrar Sesión
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              ) : (
                <>
                  <Button
                    variant="ghost"
                    size="sm"
                    className="hidden sm:inline-flex cursor-pointer"
                    onClick={() => setShowLoginModal(true)}
                  >
                    Iniciar Sesión
                  </Button>
                  <Button
                    size="sm"
                    className="bg-primary hover:bg-primary/90 cursor-pointer"
                    onClick={() => setShowRegisterModal(true)}
                  >
                    Registrarse
                  </Button>
                </>
              )}
            </div>
          </div>
        </div>
      </header>

      <Dialog open={showLoginModal} onOpenChange={setShowLoginModal}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>Iniciar Sesión</DialogTitle>
          </DialogHeader>
          <form
            className="space-y-4"
            onSubmit={async (e) => {
              e.preventDefault()
              const formData = new FormData(e.currentTarget)
              const email = formData.get("email") as string
              const password = formData.get("password") as string

              try {
                await login(email, password)

                // Obtener el usuario actualizado después del login
                const currentUser = JSON.parse(localStorage.getItem("currentUser") || "null")

                toast({
                  title: "Inicio de sesión exitoso",
                  description: "Bienvenido de vuelta a ViajesUCAB",
                })
                setShowLoginModal(false)

                // Redirigir según rol
                if (currentUser?.role === 1) {
                  router.push("/admin")
                } else if (currentUser?.role === 2) {
                  router.push("/proveedores")
                } else {
                  router.push("/")
                }
              } catch (error) {
                toast({
                  title: "Error",
                  description: error instanceof Error ? error.message : "Error al iniciar sesión",
                  variant: "destructive",
                })
              }
            }}
          >
            <div className="space-y-2">
              <Label htmlFor="login-email">Correo electrónico</Label>
              <Input id="login-email" name="email" type="email" placeholder="tu@email.com" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="login-password">Contraseña</Label>
              <Input id="login-password" name="password" type="password" placeholder="••••••••" required />
            </div>
            <Button type="submit" className="w-full cursor-pointer">
              Iniciar Sesión
            </Button>
            <p className="text-center text-sm text-muted-foreground">
              ¿No tienes cuenta?{" "}
              <button
                type="button"
                className="text-primary hover:underline cursor-pointer"
                onClick={() => {
                  setShowLoginModal(false)
                  setShowRegisterModal(true)
                }}
              >
                Regístrate aquí
              </button>
            </p>
          </form>
        </DialogContent>
      </Dialog>

      <Dialog open={showRegisterModal} onOpenChange={setShowRegisterModal}>
        <DialogContent className="sm:max-w-md max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Crear Cuenta</DialogTitle>
          </DialogHeader>
          <form
            className="space-y-4"
            onSubmit={async (e) => {
              e.preventDefault()
              setIsRegistering(true)
              const formData = new FormData(e.currentTarget)

              const primerNombre = formData.get("primerNombre") as string
              const segundoNombre = formData.get("segundoNombre") as string
              const primerApellido = formData.get("primerApellido") as string
              const segundoApellido = formData.get("segundoApellido") as string
              const email = formData.get("email") as string
              const password = formData.get("password") as string
              const confirmPassword = formData.get("confirmPassword") as string
              const fechaNacimiento = formData.get("fechaNacimiento") as string
              const estadoCivil = formData.get("estadoCivil") as string
              const lugarId = formData.get("lugarId") as string

              if (password !== confirmPassword) {
                toast({
                  title: "Error",
                  description: "Las contraseñas no coinciden",
                  variant: "destructive",
                })
                setIsRegistering(false)
                return
              }

              try {
                const payload = {
                  U_Primer_Nombre: primerNombre,
                  U_Primer_Apellido: primerApellido,
                  U_Correo: email,
                  U_Contrasena: password,
                  U_Rol_ID: 3,

                  // Datos de Cliente
                  C_Primer_Nombre: primerNombre,
                  C_Segundo_Nombre: segundoNombre || null,
                  C_Apellido: primerApellido,
                  C_Segundo_Apellido: segundoApellido || null,
                  C_Fecha_Nacimiento: fechaNacimiento,
                  C_Estado_Civil: estadoCivil,
                  C_Lugar_ID: lugarId || null,
                }

                const res = await fetch("/api/auth/register", {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  body: JSON.stringify(payload),
                })

                const data = await res.json()

                if (data.status === "success") {
                  login(email, password)
                  toast({
                    title: "Cuenta creada exitosamente",
                    description: "¡Bienvenido a ViajesUCAB! Ya puedes comenzar a buscar ofertas.",
                  })
                  setShowRegisterModal(false)
                  router.push("/clientes")
                } else {
                  toast({
                    title: "Error",
                    description: data.message || "No se pudo crear la cuenta",
                    variant: "destructive",
                  })
                }
              } catch (error) {
                toast({
                  title: "Error",
                  description: "Error de conexión con el servidor",
                  variant: "destructive",
                })
              } finally {
                setIsRegistering(false)
              }
            }}
          >
            {/* Usuario */}
            <div className="space-y-2">
              <Label htmlFor="primerNombre">Primer Nombre</Label>
              <Input id="primerNombre" name="primerNombre" type="text" placeholder="Juan" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="segundoNombre">Segundo Nombre</Label>
              <Input id="segundoNombre" name="segundoNombre" type="text" placeholder="Carlos" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="primerApellido">Primer Apellido</Label>
              <Input id="primerApellido" name="primerApellido" type="text" placeholder="Pérez" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="segundoApellido">Segundo Apellido</Label>
              <Input id="segundoApellido" name="segundoApellido" type="text" placeholder="Gómez" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="register-email">Correo electrónico</Label>
              <Input id="register-email" name="email" type="email" placeholder="tu@email.com" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="register-password">Contraseña</Label>
              <Input id="register-password" name="password" type="password" placeholder="••••••••" required minLength={8} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="confirm-password">Confirmar Contraseña</Label>
              <Input id="confirm-password" name="confirmPassword" type="password" placeholder="••••••••" required minLength={8} />
            </div>

            {/* Cliente */}
            <div className="space-y-2">
              <Label htmlFor="fechaNacimiento">Fecha de Nacimiento</Label>
              <Input id="fechaNacimiento" name="fechaNacimiento" type="date" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="estadoCivil">Estado Civil</Label>
              <select id="estadoCivil" name="estadoCivil" className="w-full border rounded p-2" required>
                <option value="">Selecciona tu estado civil</option>
                <option value="Soltero">Soltero</option>
                <option value="Casado">Casado</option>
                <option value="Divorciado">Divorciado</option>
                <option value="Viudo">Viudo</option>
              </select>
            </div>
            <div className="space-y-2">
              <Label htmlFor="lugarId">Lugar</Label>
              <Input id="lugarId" name="lugarId" type="number" placeholder="ID del lugar (opcional)" />
            </div>

            <Button type="submit" className="w-full cursor-pointer" disabled={isRegistering}>
              {isRegistering ? "Creando cuenta..." : "Crear Cuenta"}
            </Button>
            <p className="text-center text-sm text-muted-foreground">
              ¿Ya tienes cuenta?{" "}
              <button
                type="button"
                className="text-primary hover:underline cursor-pointer"
                onClick={() => {
                  setShowRegisterModal(false)
                  setShowLoginModal(true)
                }}
              >
                Inicia sesión aquí
              </button>
            </p>
          </form>
        </DialogContent>
      </Dialog>
    </>
  )
}