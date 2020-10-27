import wollok.game.*
import indicadores.*

object personaje {
	var property corazones = 12
	var property tiempoPlus = 0
	var property position = game.at(3,0)//uso 3 para pruebas solo con pista. Debe ir 5
	var property direccion = null
	var nroImagen = 1
	var property image = "jugador"+nroImagen.toString()+".png"
	
	method mover(sentido){ 
		direccion = sentido
		const desplazamiento = self.position().x() + sentido
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
	}
	
	method moverDeMas(){
		self.mover(direccion)
	}
	
	method energia(){ return corazones }
	
	method redibujaPersonaje(){
		if (nroImagen == 0){ nroImagen = 1} else{nroImagen = 0}
	}
	
	method quitarEnergia(cantidad){ 
		corazones = corazones - cantidad
	}
	
	
	method actualizarTablero(){
		
		//actualizar vidas en el tablero
	}
	
	method parpadear(){
		//parpadeo del auto luego del impacto
	}
}
