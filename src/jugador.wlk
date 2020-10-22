import wollok.game.*
import indicadores.*

object personaje {
	var property corazones = 12
	var property tiempoPlus = 0
	var property position = game.at(3,0)//uso 3 para pruebas solo con pista. Debe ir 5
	 
	var nroImagen = 0
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
			game.say(self,self.position().toString())
		3.times({self.redibujaPersonaje()})
	}
	
	method energia(){ return corazones }
	
	method redibujaPersonaje(){
		if (nroImagen == 0){ nroImagen = 1} else{nroImagen = 0}
	}
	
	method quitarEnergia(cantidad){ 
		corazones = corazones - cantidad
	}
	method image(){ return "jugador" + nroImagen.toString() + ".png"
		
	}
	
	
	method impactoA(obstaculoImpactado){
		3.times({self.redibujaPersonaje()})
		//self.quitarEnergia(obstaculoImpactado.energiaQueQuita())
		//game.say(self,corazones.toString())//debug
		//3.times({self.redibujaPersonaje()})
		//obstaculoImpactado.borrarObstaculo()
		//self.actualizarTablero()
		const colisionCon = game.allVisuals().filter({colision=>colision.position()==self.position()})
		game.say(colisionCon,self.corazones().toString())//debug
	}
	
	
	method actualizarTablero(){
		
		//actualizar vidas en el tablero
	}
	
	method parpadear(){
		//parpadeo del auto luego del impacto
	}
}
