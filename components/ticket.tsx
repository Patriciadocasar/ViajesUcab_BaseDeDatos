"use client"

import { useMemo } from "react"
import { BoardingPass } from "@/components/boarding-pass"
import type { CartItem } from "@/lib/cart-context"

interface TicketProps {
  item: CartItem
  customerName: string
  reservationNumber: string
  purchaseDate: string
}

// Helper function to generate deterministic "random" values based on a seed
function seededRandom(seed: string): number {
  let hash = 0
  for (let i = 0; i < seed.length; i++) {
    const char = seed.charCodeAt(i)
    hash = ((hash << 5) - hash) + char
    hash = hash & hash // Convert to 32-bit integer
  }
  return Math.abs(hash) / 2147483647 // Normalize to 0-1
}

export function Ticket({ item, customerName, reservationNumber, purchaseDate }: TicketProps) {
  // Generate deterministic random values based on reservationNumber to avoid hydration mismatch
  const randomValues = useMemo(() => {
    const seed = reservationNumber + item.id + (item.dates?.checkIn || "")
    const r1 = seededRandom(seed + "1")
    const r2 = seededRandom(seed + "2")
    const r3 = seededRandom(seed + "3")
    const r4 = seededRandom(seed + "4")
    const r5 = seededRandom(seed + "5")
    const r6 = seededRandom(seed + "6")
    const r7 = seededRandom(seed + "7")
    const r8 = seededRandom(seed + "8")
    const r9 = seededRandom(seed + "9")
    const r10 = seededRandom(seed + "10")
    
    return { r1, r2, r3, r4, r5, r6, r7, r8, r9, r10 }
  }, [reservationNumber, item.id, item.dates?.checkIn])

  const getServiceType = () => {
    switch (item.type) {
      case "flight":
        return "vuelos"
      case "cruise":
        return "cruceros"
      case "hotel":
        return "hoteles"
      default:
        return "traslados"
    }
  }

  const getServiceDetails = () => {
    const serviceType = getServiceType()

    // Extract origin and destination from location or title
    const [from, to] = item.location?.split(" - ") || [item.location || "ORIGEN", "DESTINO"]

    // Calculate arrival time/date based on service type
    // Use a fixed date if checkIn is not available to avoid hydration mismatch
    const departureDate = item.dates?.checkIn 
      ? new Date(item.dates.checkIn) 
      : new Date("2024-01-01T12:00:00.000Z")
    const arrivalDate = new Date(departureDate)

    if (serviceType === "vuelos") {
      arrivalDate.setHours(arrivalDate.getHours() + 3)
      const arrivalTime = arrivalDate.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit", hour12: false })

      return {
        number: `AV${Math.floor(randomValues.r1 * 900) + 100}`,
        from: from.toUpperCase().substring(0, 15),
        to: to.toUpperCase().substring(0, 15),
        date: departureDate
          .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
          .toUpperCase(),
        arrivalTime: arrivalTime,
        seat: `${Math.floor(randomValues.r2 * 30) + 1}${String.fromCharCode(65 + Math.floor(randomValues.r3 * 6))}`,
        gate: `${String.fromCharCode(65 + Math.floor(randomValues.r4 * 10))}${Math.floor(randomValues.r5 * 20) + 1}`,
        boardingTime: departureDate.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit", hour12: false }),
      }
    } else if (serviceType === "cruceros") {
      arrivalDate.setDate(arrivalDate.getDate() + 6)
      const arrivalDateStr = arrivalDate
        .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
        .toUpperCase()

      return {
        number: `CR${Math.floor(randomValues.r1 * 900) + 100}`,
        from: from.toUpperCase().substring(0, 15),
        to: to.toUpperCase().substring(0, 15),
        date: departureDate
          .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
          .toUpperCase(),
        arrivalDate: arrivalDateStr,
        cabin: `${Math.floor(randomValues.r2 * 200) + 100}`,
        embarkationPort: `Puerto ${from} - Terminal ${Math.floor(randomValues.r3 * 5) + 1}`,
        boardingTime: "14:00",
      }
    } else if (serviceType === "traslados") {
      arrivalDate.setHours(arrivalDate.getHours() + 4)
      const arrivalTime = arrivalDate.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit", hour12: false })

      return {
        number: `TR${Math.floor(randomValues.r1 * 900) + 100}`,
        from: from.toUpperCase().substring(0, 15),
        to: to.toUpperCase().substring(0, 15),
        date: departureDate
          .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
          .toUpperCase(),
        arrivalTime: arrivalTime,
        seat: `${Math.floor(randomValues.r2 * 40) + 1}`,
        station: `Estación ${from}`,
        boardingTime: departureDate.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit", hour12: false }),
      }
    } else {
      return {
        number: `HT${Math.floor(randomValues.r1 * 900) + 100}`,
        from: "HOTEL",
        to: from.toUpperCase().substring(0, 15),
        date: departureDate
          .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
          .toUpperCase(),
        room: `${Math.floor(randomValues.r2 * 500) + 100}`,
        boardingTime: "15:00",
      }
    }
  }

  const serviceType = getServiceType()
  const serviceDetails = getServiceDetails()

  const getReturnServiceDetails = () => {
    // Use a fixed date if checkOut is not available to avoid hydration mismatch
    const returnDate = item.dates?.checkOut 
      ? new Date(item.dates.checkOut) 
      : new Date("2024-01-01T12:00:00.000Z")
    const returnArrivalDate = new Date(returnDate)

    if (serviceType === "vuelos") {
      returnArrivalDate.setHours(returnArrivalDate.getHours() + 3)
    } else if (serviceType === "traslados") {
      returnArrivalDate.setHours(returnArrivalDate.getHours() + 4)
    }

    return {
      ...serviceDetails,
      from: serviceDetails.to,
      to: serviceDetails.from,
      date: returnDate.toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" }).toUpperCase(),
      boardingTime: returnDate.toLocaleTimeString("es-ES", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: false,
      }),
      arrivalTime: returnArrivalDate.toLocaleTimeString("es-ES", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: false,
      }),
      number: `${serviceDetails.number.substring(0, 2)}${Math.floor(randomValues.r6 * 900) + 100}`,
    }
  }

  return (
    <div className="space-y-8">
      <div className="space-y-3">
        <div className="flex items-center gap-3">
          <span className="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-bold">✈️ VUELO DE IDA</span>
          <span className="text-muted-foreground text-sm font-medium">{serviceDetails.date}</span>
        </div>
        <BoardingPass
          passenger={{
            name: customerName,
            passportNumber: "A12345678",
          }}
          serviceType={serviceType}
          serviceDetails={serviceDetails}
          reservationNumber={reservationNumber}
        />
      </div>

      {(serviceType === "vuelos" || serviceType === "traslados") && item.dates?.checkOut && (
        <div className="space-y-3">
          <div className="flex items-center gap-3">
            <span className="bg-green-600 text-white px-4 py-2 rounded-lg text-sm font-bold">🔄 VUELO DE REGRESO</span>
            <span className="text-muted-foreground text-sm font-medium">
              {new Date(item.dates.checkOut)
                .toLocaleDateString("es-ES", { day: "2-digit", month: "short", year: "numeric" })
                .toUpperCase()}
            </span>
          </div>
          <BoardingPass
            passenger={{
              name: customerName,
              passportNumber: "A12345678",
            }}
            serviceType={serviceType}
            serviceDetails={getReturnServiceDetails()}
            reservationNumber={reservationNumber}
          />
        </div>
      )}
    </div>
  )
}
