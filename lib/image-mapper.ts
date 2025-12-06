// Helper function to map services to images based on type and location
export function getServiceImages(
  type: string,
  location?: string,
  title?: string,
  destination?: string,
  serviceId?: number | string
): string[] {
  const images: Set<string> = new Set()
  const locationLower = location?.toLowerCase() || ""
  const titleLower = title?.toLowerCase() || ""
  const destinationLower = destination?.toLowerCase() || ""

  // Helper para agregar imágenes sin duplicados
  const addImage = (image: string) => {
    if (image && !images.has(image)) {
      images.add(image)
    }
  }

  // Usar el ID o título para crear variación única
  const idHash = serviceId ? Number(serviceId) % 10 : (titleLower.length % 10)

  // Vuelos - imágenes de aviones con variación según destino y servicio específico
  if (type === "vuelos" || type === "flight") {
    addImage("/airplane-in-flight.png")
    // Variar imágenes según destino específico y crear combinaciones únicas
    if (locationLower.includes("miami")) {
      if (idHash % 2 === 0) {
        addImage("/miami-beach-hotel.jpg")
        addImage("/luxury-hotel.jpg")
      } else {
        addImage("/city-tour.jpg")
        addImage("/travel-itinerary.jpg")
      }
    } else if (locationLower.includes("méxico") || locationLower.includes("mexico") || locationLower.includes("cdmx")) {
      if (idHash % 2 === 0) {
        addImage("/chichen-itza-pyramid.jpg")
        addImage("/buenos-aires-city-tour.jpg")
      } else {
        addImage("/cenote-mexico.jpg")
        addImage("/travel-itinerary.jpg")
      }
    } else if (locationLower.includes("parís") || locationLower.includes("paris")) {
      addImage("/eiffel-tower-paris.png")
      if (idHash % 2 === 0) {
        addImage("/louvre-museum.png")
      } else {
        addImage("/seine-river-cruise.png")
      }
    } else if (locationLower.includes("londres") || locationLower.includes("london")) {
      addImage("/big-ben-london.jpg")
      if (idHash % 2 === 0) {
        addImage("/eiffel-tower-paris.png")
      } else {
        addImage("/louvre-museum.png")
      }
    } else {
      // Para otros destinos, usar imágenes variadas según hash
      const altImages = ["/travel-itinerary.jpg", "/buenos-aires-city-tour.jpg", "/luxury-hotel.jpg"]
      addImage(altImages[idHash % altImages.length])
    }
  }

  // Cruceros - imágenes de cruceros variadas según ruta y servicio específico
  if (type === "cruceros" || type === "cruise") {
    // Variar según la ruta específica y crear combinaciones únicas
    if (locationLower.includes("caribe") || locationLower.includes("bahamas") || locationLower.includes("jamaica") || locationLower.includes("miami")) {
      if (idHash % 2 === 0) {
        addImage("/cruise-ship-caribbean.jpg")
        addImage("/beach-resort.jpg")
        addImage("/punta-cana-beach-resort.jpg")
      } else {
        addImage("/cruise-ship.jpg")
        addImage("/beach-resort.jpg")
        addImage("/luxury-resort.jpg")
      }
    } else if (locationLower.includes("mediterráneo") || locationLower.includes("barcelona") || locationLower.includes("roma") || locationLower.includes("atenas")) {
      if (idHash % 2 === 0) {
        addImage("/santorini-cruise.jpg")
        addImage("/seine-river-cruise.png")
        addImage("/cruise-ship.jpg")
      } else {
        addImage("/cruise-ship-caribbean.jpg")
        addImage("/santorini-cruise.jpg")
        addImage("/eiffel-tower-paris.png")
      }
    } else {
      // Cruceros genéricos - variar según hash
      if (idHash % 2 === 0) {
        addImage("/cruise-ship.jpg")
        addImage("/cruise-ship-caribbean.jpg")
      } else {
        addImage("/cruise-ship-caribbean.jpg")
        addImage("/beach-resort.jpg")
      }
    }
  }

  // Hoteles - imágenes de hoteles/resorts
  if (type === "hoteles" || type === "hotel") {
    if (locationLower.includes("cancún") || locationLower.includes("cancun")) {
      addImage("/luxury-cancun-resort.jpg")
      addImage("/cancun-beach-resort.png")
      addImage("/beach-resort.jpg")
    } else if (locationLower.includes("punta cana") || locationLower.includes("república dominicana")) {
      addImage("/punta-cana-beach-resort.jpg")
      addImage("/luxury-resort.jpg")
      addImage("/beach-resort.jpg")
    } else if (locationLower.includes("cartagena") || locationLower.includes("colombia")) {
      addImage("/cartagena-colonial-hotel.jpg")
      addImage("/luxury-hotel.jpg")
    } else if (locationLower.includes("miami")) {
      addImage("/miami-beach-hotel.jpg")
      addImage("/luxury-hotel.jpg")
    } else if (locationLower.includes("orlando")) {
      addImage("/luxury-hotel-room-orlando.jpg")
      addImage("/disney-castle-magic-kingdom.jpg")
    } else {
      addImage("/luxury-hotel.jpg")
      addImage("/luxury-resort.jpg")
    }
  }

  // Traslados - imágenes de carros/autobuses
  if (type === "traslados" || type === "transfer") {
    // Usar imágenes de lugares ya que no tenemos imágenes específicas de vehículos
    // Pero podemos usar imágenes relacionadas con el destino
    addImage("/city-tour.jpg")
    if (locationLower.includes("las vegas") || locationLower.includes("los angeles") || locationLower.includes("miami") || locationLower.includes("orlando")) {
      addImage("/miami-beach-hotel.jpg")
    }
  }

  // Trenes - imágenes relacionadas con ciudades y estaciones (NO autobuses)
  if (type === "trenes" || type === "train") {
    // Usar imágenes de ciudades/atractivos, NO autobuses - variar según servicio
    const trainImages = [
      "/eiffel-tower-paris.png",
      "/big-ben-london.jpg",
      "/louvre-museum.png",
      "/seine-river-cruise.png",
      "/travel-itinerary.jpg",
      "/buenos-aires-city-tour.jpg",
      "/luxury-hotel.jpg",
    ]
    
    if (locationLower.includes("parís") || locationLower.includes("paris") || locationLower.includes("londres") || locationLower.includes("london")) {
      if (idHash % 2 === 0) {
        addImage("/eiffel-tower-paris.png")
        addImage("/big-ben-london.jpg")
        addImage("/louvre-museum.png")
      } else {
        addImage("/seine-river-cruise.png")
        addImage("/eiffel-tower-paris.png")
        addImage("/big-ben-london.jpg")
      }
    } else if (locationLower.includes("madrid") || locationLower.includes("barcelona")) {
      addImage(trainImages[(idHash + 1) % trainImages.length])
      addImage(trainImages[(idHash + 2) % trainImages.length])
      addImage(trainImages[(idHash + 3) % trainImages.length])
    } else if (locationLower.includes("caracas") || locationLower.includes("valencia")) {
      addImage("/buenos-aires-city-tour.jpg")
      addImage(trainImages[(idHash + 4) % trainImages.length])
      addImage(trainImages[(idHash + 5) % trainImages.length])
    } else {
      // Para otros trenes, usar imágenes de ciudades/atractivos - variar según ID
      addImage(trainImages[idHash % trainImages.length])
      addImage(trainImages[(idHash + 1) % trainImages.length])
      addImage(trainImages[(idHash + 2) % trainImages.length])
    }
  }

  // Paquetes - imágenes según destino
  if (type === "paquetes" || type === "package") {
    if (locationLower.includes("miami") || titleLower.includes("miami")) {
      addImage("/miami-beach-hotel.jpg")
      addImage("/city-tour.jpg")
    } else if (locationLower.includes("europa") || locationLower.includes("parís") || locationLower.includes("roma") || locationLower.includes("madrid")) {
      addImage("/eiffel-tower-paris.png")
      addImage("/louvre-museum.png")
      addImage("/big-ben-london.jpg")
    } else if (locationLower.includes("caribe") || locationLower.includes("cancún") || locationLower.includes("punta cana")) {
      addImage("/cancun-beach-resort.png")
      addImage("/punta-cana-beach-resort.jpg")
      addImage("/beach-resort.jpg")
    } else {
      addImage("/city-tour.jpg")
      addImage("/luxury-hotel.jpg")
    }
  }

  // Paquetes especiales - Luna de Miel (solo si es tipo honeymoon)
  if (type === "honeymoon") {
    if (destinationLower.includes("maldivas") || destinationLower.includes("maldives")) {
      // Variar el orden según ID para crear imágenes únicas
      const maldivesImages = [
        "/maldives-water-villa.jpg",
        "/maldives-beach-dinner.jpg",
        "/maldives-snorkeling.jpg",
        "/maldives-underwater-restaurant.jpg",
      ]
      // Rotar imágenes según ID para que cada servicio sea único
      for (let i = 0; i < maldivesImages.length; i++) {
        addImage(maldivesImages[(idHash + i) % maldivesImages.length])
      }
    } else if (destinationLower.includes("santorini") || destinationLower.includes("grecia")) {
      // Variar el orden según ID
      const santoriniImages = [
        "/santorini-oia-sunset.jpg",
        "/santorini-caldera-view.png",
        "/santorini-infinity-pool.jpg",
        "/santorini-cruise.jpg",
      ]
      for (let i = 0; i < santoriniImages.length; i++) {
        addImage(santoriniImages[(idHash + i) % santoriniImages.length])
      }
    } else if (destinationLower.includes("bali") || destinationLower.includes("indonesia")) {
      addImage("/balinese-temple.png")
      if (idHash % 2 === 0) {
        addImage("/beach-resort.jpg")
        addImage("/luxury-resort.jpg")
      } else {
        addImage("/luxury-resort.jpg")
        addImage("/maldives-water-villa.jpg")
      }
    } else {
      // Otras lunas de miel - variar según ID
      const honeymoonImages = [
        "/luxury-resort.jpg",
        "/beach-resort.jpg",
        "/maldives-water-villa.jpg",
        "/santorini-oia-sunset.jpg",
      ]
      addImage(honeymoonImages[idHash % honeymoonImages.length])
      addImage(honeymoonImages[(idHash + 1) % honeymoonImages.length])
      addImage(honeymoonImages[(idHash + 2) % honeymoonImages.length])
    }
  }

  // Paquetes especiales - Tours de 15 años (solo si es tipo quinceanera)
  if (type === "quinceanera") {
    if (destinationLower.includes("orlando") || destinationLower.includes("florida")) {
      // Variar el orden según ID para crear imágenes únicas
      const orlandoImages = [
        "/disney-castle-magic-kingdom.jpg",
        "/universal-studios-orlando.jpg",
        "/luxury-hotel-room-orlando.jpg",
        "/quincea-era-celebration-dinner.jpg",
      ]
      // Rotar imágenes según ID para que cada servicio sea único
      for (let i = 0; i < orlandoImages.length; i++) {
        addImage(orlandoImages[(idHash + i) % orlandoImages.length])
      }
    } else if (destinationLower.includes("cancún") || destinationLower.includes("cancun") || destinationLower.includes("riviera maya")) {
      // Variar el orden según ID
      const cancunImages = [
        "/cancun-beach-resort.png",
        "/chichen-itza-pyramid.jpg",
        "/cenote-mexico.jpg",
        "/beach-party-celebration.jpg",
      ]
      for (let i = 0; i < cancunImages.length; i++) {
        addImage(cancunImages[(idHash + i) % cancunImages.length])
      }
    } else if (destinationLower.includes("parís") || destinationLower.includes("paris") || destinationLower.includes("londres") || destinationLower.includes("london")) {
      // Variar el orden según ID
      const europeImages = [
        "/eiffel-tower-paris.png",
        "/louvre-museum.png",
        "/big-ben-london.jpg",
        "/seine-river-cruise.png",
      ]
      for (let i = 0; i < europeImages.length; i++) {
        addImage(europeImages[(idHash + i) % europeImages.length])
      }
    } else {
      // Otros tours de 15 años - variar según ID
      const quinceImages = [
        "/quincea-era-celebration-dinner.jpg",
        "/beach-party-celebration.jpg",
        "/luxury-resort.jpg",
        "/disney-castle-magic-kingdom.jpg",
      ]
      addImage(quinceImages[idHash % quinceImages.length])
      addImage(quinceImages[(idHash + 1) % quinceImages.length])
      addImage(quinceImages[(idHash + 2) % quinceImages.length])
    }
  }

  // Restaurantes - imágenes de la ciudad donde se ubican (NO autobuses)
  if (type === "restaurant") {
    // Usar imágenes relacionadas con la ciudad, NO autobuses
    // Variar según ID para que cada restaurante sea único
    const restaurantImages = [
      "/luxury-hotel.jpg",
      "/luxury-resort.jpg",
      "/miami-beach-hotel.jpg",
      "/travel-itinerary.jpg",
      "/buenos-aires-city-tour.jpg",
      "/eiffel-tower-paris.png",
      "/louvre-museum.png",
      "/big-ben-london.jpg",
      "/balinese-temple.png",
    ]
    
    if (locationLower.includes("nueva york") || locationLower.includes("new york") || locationLower.includes("estados unidos")) {
      addImage("/miami-beach-hotel.jpg")
      addImage(restaurantImages[(idHash + 1) % restaurantImages.length])
      addImage(restaurantImages[(idHash + 2) % restaurantImages.length])
    } else if (locationLower.includes("tokio") || locationLower.includes("japón") || locationLower.includes("japan")) {
      addImage("/balinese-temple.png")
      addImage(restaurantImages[(idHash + 3) % restaurantImages.length])
      addImage(restaurantImages[(idHash + 4) % restaurantImages.length])
    } else if (locationLower.includes("módena") || locationLower.includes("italia") || locationLower.includes("italy")) {
      addImage("/eiffel-tower-paris.png")
      addImage("/louvre-museum.png")
      addImage(restaurantImages[(idHash + 5) % restaurantImages.length])
    } else if (locationLower.includes("girona") || locationLower.includes("españa") || locationLower.includes("spain")) {
      addImage("/big-ben-london.jpg")
      addImage("/eiffel-tower-paris.png")
      addImage(restaurantImages[(idHash + 6) % restaurantImages.length])
    } else if (locationLower.includes("copenhague") || locationLower.includes("dinamarca") || locationLower.includes("denmark")) {
      addImage("/louvre-museum.png")
      addImage(restaurantImages[(idHash + 7) % restaurantImages.length])
      addImage(restaurantImages[(idHash + 8) % restaurantImages.length])
    } else if (locationLower.includes("bangkok") || locationLower.includes("tailandia") || locationLower.includes("thailand")) {
      addImage("/balinese-temple.png")
      addImage(restaurantImages[idHash % restaurantImages.length])
      addImage(restaurantImages[(idHash + 1) % restaurantImages.length])
    } else {
      // Imágenes genéricas de ciudades/atractivos, NO autobuses - variar según ID
      addImage(restaurantImages[idHash % restaurantImages.length])
      addImage(restaurantImages[(idHash + 1) % restaurantImages.length])
      addImage(restaurantImages[(idHash + 2) % restaurantImages.length])
    }
  }

  // Si no hay imágenes, usar una imagen por defecto
  if (images.size === 0) {
    images.add("/placeholder.jpg")
  }

  // Convertir Set a Array para eliminar duplicados
  return Array.from(images)
}

// Helper para obtener la imagen principal (primera del array)
export function getMainServiceImage(
  type: string,
  location?: string,
  title?: string,
  destination?: string,
  serviceId?: number | string
): string {
  const images = getServiceImages(type, location, title, destination, serviceId)
  return images[0] || "/placeholder.jpg"
}

