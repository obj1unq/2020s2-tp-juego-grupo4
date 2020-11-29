import wollok.game.*
import contadores.*
import config.*

object personaje {

	var property position = game.at(3,1)//
	var property direccion = 0
	var nroImagen = 1
	
	method energia(){ return vida.cantidad() }
	
	method cantidadPasajeros(){return pasajeros.cantidad()}
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		direccion=sentido*(-1)
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
	}
	
	method moverDeMas(){ self.mover(direccion) }
	
	method impactaPasajero(){ pasajeros.aumentar()}
	
	method modificaEnergia(cantidad){ vida.modificar(cantidad) }
	
	method agregarTiempo(){ timer.sumaTiempo() }
	
	method image(){ return "jugador_" + nroImagen.toString() + ".png"}
	
	method puntajeFinal(){ return self.conteoPuntos(vida.cantidad(),vida.puntos()) + self.conteoPuntos(pasajeros.cantidad(),pasajeros.puntos())}
	
	method conteoPuntos(puntosAcumulados,conversion){ return puntosAcumulados * conversion }

}
