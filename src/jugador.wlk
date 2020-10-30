import wollok.game.*
import indicadores.*

object personaje {
	var property corazones = 12
	var property tiempoExtra = 0
	var property position = game.at(3,0)//uso 3 para pruebas solo con pista. Debe ir 5
	var nroImagen = 1
	const puntajeXCorazon = 10
	const puntajeXTiempo = 5
	var property direccion = 0

	
	method energia(){ return corazones }
	
	method redibujaPersonaje(){ if (nroImagen == 0){ nroImagen = 1}else{nroImagen = 0} }

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
	method impactaEnergia(obstaculo){}
	
	//////////////////
	//////////////////      CAMBIARLO POR modificaEnergia(cantidad)  
	/////////////////
	
	method modificaEnergia(cantidad){ corazones = corazones + cantidad }
	
	method image(){ return "jugador" + nroImagen.toString() + ".png"
		
	}
	
	method impactoA(obstaculoImpactado){
//		3.times({self.redibujaPersonaje()})
		const colisionCon = game.allVisuals().filter({colision=>colision.position()==self.position()})
		game.say(colisionCon,self.corazones().toString())//debug
	}
	method puntajeFinal(){ return self.conteoPuntos(corazones,puntajeXCorazon) + self.conteoPuntos(tiempoExtra,puntajeXTiempo)}
	method conteoPuntos(puntosAcumulados,conversion){ return puntosAcumulados * conversion }
	
}
