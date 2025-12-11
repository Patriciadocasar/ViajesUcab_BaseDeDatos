"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"

type MonedaDialogProps = {
  open: boolean
  onOpenChange: (open: boolean) => void
  onGuardar: (moneda: any) => void
}

export default function MonedaDialog({ open, onOpenChange, onGuardar }: MonedaDialogProps) {
  const [codigo, setCodigo] = useState("")
  const [tasaActual, setTasaActual] = useState("")
  const [cantMilla, setCantMilla] = useState("")
  const [fechaFinal, setFechaFinal] = useState("")
  const [lugarCod, setLugarCod] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    onGuardar({
      TC_Tipo_Moneda: codigo.toUpperCase(),
      TC_Valor: Number(tasaActual),
      TC_Cant_Milla: Number(cantMilla) || 0,
      TC_Fecha_Actualizacion: new Date().toISOString(),
      TC_Fecha_Final: fechaFinal || null,
      Lugar_Lug_COD: Number(lugarCod) || null,
    })
    // limpiar campos
    setCodigo("")
    setTasaActual("")
    setCantMilla("")
    setFechaFinal("")
    setLugarCod("")
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px]">
        <form onSubmit={handleSubmit}>
          <DialogHeader>
            <DialogTitle>Agregar Nueva Moneda</DialogTitle>
            <DialogDescription>
              Ingresa los datos de la nueva moneda a registrar
            </DialogDescription>
          </DialogHeader>

          <div className="grid gap-4 py-4">
            <div className="space-y-2">
              <Label htmlFor="codigo">Tipo de moneda</Label>
              <Input
                id="codigo"
                value={codigo}
                onChange={(e) => setCodigo(e.target.value)}
                placeholder="Ej: USD, EUR, COP"
                maxLength={3}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="tasa">Tasa actual (en Bolívares)</Label>
              <Input
                id="tasa"
                type="number"
                step="0.0001"
                min="0"
                value={tasaActual}
                onChange={(e) => setTasaActual(e.target.value)}
                placeholder="Ej: 36.5000"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="cantMilla">Cantidad de millas (opcional)</Label>
              <Input
                id="cantMilla"
                type="number"
                min="0"
                value={cantMilla}
                onChange={(e) => setCantMilla(e.target.value)}
                placeholder="Ej: 3"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="fechaFinal">Fecha final</Label>
              <Input
                id="fechaFinal"
                type="date"
                value={fechaFinal}
                onChange={(e) => setFechaFinal(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="lugarCod">Código de lugar (opcional)</Label>
              <Input
                id="lugarCod"
                type="number"
                min="0"
                value={lugarCod}
                onChange={(e) => setLugarCod(e.target.value)}
                placeholder="Ej: 1"
              />
            </div>
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              Cancelar
            </Button><Button type="submit">Guardar</Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}