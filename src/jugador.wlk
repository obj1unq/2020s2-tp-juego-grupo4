import wollok.game.*

object personaje {
	var property corazones = 0
	var property position = game.at(3,0)//uso 3 para pruebas solo con pista. Debe ir 5
	var property image = "jugador.png"
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		if(desplazamiento.between(0,game.width() - 1))
			position=game.at(desplazamiento, self.position().y())
		self.redibujaPersonaje()
	}
	
	
	method redibujaPersonaje(){
		game.removeVisual(self)
		game.addVisualIn(self,position)	 
	}
}
