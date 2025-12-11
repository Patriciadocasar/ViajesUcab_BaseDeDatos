"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useUser } from "@/lib/user-context"
import { useToast } from "@/hooks/use-toast"
import { Logo } from "@/components/logo"

export default function RegisterPage() {
  const router = useRouter()
  const { login } = useUser()
  const { toast } = useToast()
  const [formData, setFormData] = useState({
    primerNombre: "",
    primerApellido: "",
    email: "",
    password: "",
    confirmPassword: "",
    role: 3,
  })
  const [isLoading, setIsLoading] = useState(false)

  /*const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)

    if (formData.password !== formData.confirmPassword) {
      toast({
        title: "Error",
        description: "Las contraseñas no coinciden",
        variant: "destructive",
      })
      setIsLoading(false)
      return
    }

    try {
      login(
        formData.email,
        formData.password,
        formData.role,
        formData.name,
        formData.phone,
        formData.address,
        {
          venezuelanId: formData.venezuelanId || undefined,
          passport: formData.passport || undefined,
        }
      )
      toast({
        title: "Cuenta creada exitosamente",
        description: "¡Bienvenido a ViajesUCAB!",
      })
      
      // Redirigir según el rol
      if (formData.role === "admin") {
        router.push("/admin")
      } else if (formData.role === "proveedor") {
        router.push("/proveedores")
      } else {
        router.push("/clientes")
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "No se pudo crear la cuenta",
        variant: "destructive",
      })
    } finally {
      setIsLoading(false)
    }
  }*/

    const handleSubmit = async (e: React.FormEvent) => {
      e.preventDefault();
      setIsLoading(true);
    
      if (formData.password !== formData.confirmPassword) {
        toast({
          title: "Error",
          description: "Las contraseñas no coinciden",
          variant: "destructive",
        });
        setIsLoading(false);
        return;
      }
    
      try {
        const payload = {
          U_Primer_Nombre: formData.primerNombre,
          U_Primer_Apellido: formData.primerApellido,
          U_Correo: formData.email,
          U_Contrasena: formData.password, // solo este campo
          U_Rol_ID: 3,
        };
    

        const res = await fetch("/api/auth/register", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
    
        const data = await res.json();
    
        if (data.status === "success") {

          // ✅ Guardar usuario en contexto
        login(
          payload.U_Correo,
          payload.U_Contrasena
        );


          toast({
            title: "Cuenta creada exitosamente",
            description: "¡Bienvenido a ViajesUCAB!",
          });
    
          // Redirigir según el rol
          if (formData.role === 1) {
            router.push("/admin");
          } else if (formData.role === 2) {
            router.push("/proveedores");
          } else {
            router.push("/clientes");
          }
        } else {
          toast({
            title: "Error",
            description: data.message || "No se pudo crear la cuenta",
            variant: "destructive",
          });
        }
      } catch (error) {
        toast({
          title: "Error",
          description: "Error de conexión con el servidor",
          variant: "destructive",
        });
      } finally {
        setIsLoading(false);
      }
    };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background p-4">
      <Card className="w-full max-w-md max-h-[90vh] overflow-y-auto">
        <CardHeader className="space-y-1 text-center">
          <div className="flex justify-center mb-4">
            <Logo />
          </div>
          <CardTitle className="text-2xl">Crear Cuenta</CardTitle>
          <CardDescription>Regístrate para comenzar a usar ViajesUCAB</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="primerNombre">Primer Nombre</Label>
              <Input
                id="primerNombre"
                type="text"
                placeholder="Juan"
                value={formData.primerNombre}
                onChange={(e) => setFormData({ ...formData, primerNombre: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="primerApellido">Primer Apellido</Label>
              <Input
                id="primerApellido"
                type="text"
                placeholder="Perez"
                value={formData.primerApellido}
                onChange={(e) => setFormData({ ...formData, primerApellido: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="email">Correo electrónico</Label>
              <Input
                id="email"
                type="email"
                placeholder="tu@email.com"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password">Contraseña</Label>
              <Input
                id="password"
                type="password"
                placeholder="••••••••"
                value={formData.password}
                onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                required
                minLength={8}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="confirmPassword">Confirmar Contraseña</Label>
              <Input
                id="confirmPassword"
                type="password"
                placeholder="••••••••"
                value={formData.confirmPassword}
                onChange={(e) => setFormData({ ...formData, confirmPassword: e.target.value })}
                required
                minLength={8}
              />
            </div>
            <Button type="submit" className="w-full" disabled={isLoading}>
              {isLoading ? "Creando cuenta..." : "Crear Cuenta"}
            </Button>
            <p className="text-center text-sm text-muted-foreground">
              ¿Ya tienes cuenta?{" "}
              <button
                type="button"
                className="text-primary hover:underline"
                onClick={() => router.push("/auth/login")}
              >
                Inicia sesión aquí
              </button>
            </p>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}

