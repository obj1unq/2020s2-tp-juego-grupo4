import wollok.game.*
import indicadores.*

object personaje {

	var property position = game.at(3,1)//uso 3 para pruebas solo con pista. Debe ir 5
	
	const puntajeXCorazon = 10
	const puntajeXTiempo = 5
	
	var property direccion = 0
	var nroImagen = 1
	const property contadorVida = new ContadorGenerico(cantidad = 12)
	const property contadorPasajeros = new ContadorGenerico(cantidad = 0)
	
	method energia(){ return contadorVida.cantidad() }
	
	method cantidadPasajeros(){return contadorPasajeros.cantidad()}
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		direccion=sentido
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
	}
	
	method moverDeMas(){
		self.mover(direccion)
	}
	
	//////////////////
	////////////////// 		SE AGREGO EL METODO impactaEnergia PARA QUE NO HAYA ERROR EN GAME.
	/////////////////
	method impactaEnergia(obstaculo){  contadorVida.reducir(obstaculo) }
	
	//////////////////
	//////////////////      CAMBIARLO POR modificaEnergia(cantidad)  
	/////////////////
	
	method impactaPasajero(obstaculo){ contadorPasajeros.aumentar()}
	
//	method modificaEnergia(cantidad){ corazones = corazones + cantidad }
	
	
	method image(){ return "jugador_" + nroImagen.toString() + ".png"}
	

	method impactoA(obstaculoImpactado){
		const colisionCon = game.allVisuals().filter({colision=>colision.position()==self.position()})
		self.impactaEnergia(colisionCon)
	}
	
	method puntajeFinal(){ return self.conteoPuntos(contadorVida.cantidad(),puntajeXCorazon) + self.conteoPuntos(contadorPasajeros.cantidad(),puntajeXTiempo)}
	method conteoPuntos(puntosAcumulados,conversion){ return puntosAcumulados * conversion }
	method alternaImagen(){ 
		if(nroImagen==0){
			nroImagen=1
		}else{
			nroImagen=0
		} 
	}
	
	
}
