import wollok.game.*
import indicadores.*

object personaje {

	var property position = game.at(3,1)//uso 3 para pruebas solo con pista. Debe ir 5
	const puntajeXCorazon = 10
	const puntajeXTiempo = 5
	var property direccion = 0
	var nroImagen = 1
	
	method energia(){ return vida.cantidad() }
	
	method cantidadPasajeros(){return pasajeros.cantidad()}
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		direccion=sentido
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
	}
	
	method moverDeMas(){ self.mover(direccion) }
	
	method impactaPasajero(){ pasajeros.aumentar()}
	
	method modificaEnergia(cantidad){ vida.modificar(cantidad) }
	
	method image(){ return "jugador_" + nroImagen.toString() + ".png"}
	

	method puntajeFinal(){ return self.conteoPuntos(vida.cantidad(),puntajeXCorazon) + self.conteoPuntos(pasajeros.cantidad(),puntajeXTiempo)}
	
	method conteoPuntos(puntosAcumulados,conversion){ return puntosAcumulados * conversion }
	
	method alternaImagen(){ 
		if(nroImagen==0){
			nroImagen=1
		}else{
			nroImagen=0
		} 
	}
	
	
}
