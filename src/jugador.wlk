import wollok.game.*
import indicadores.*

object personaje {
	var property corazones = 12
	var property position = game.at(3,0)//uso 3 para pruebas solo con pista. Debe ir 5
	var property image = "jugador.png"
	
	method mover(sentido){ 
		const desplazamiento = self.position().x() + sentido
		if(desplazamiento.between(1,game.width() - 4))
			position=game.at(desplazamiento, self.position().y())
			game.say(self,self.position().toString())
		self.redibujaPersonaje()
	}
	
	method energia(){ return corazones }
	
	method redibujaPersonaje(){
		game.removeVisual(self)
		game.addVisualIn(self,position)	 
	}
	
	method quitarEnergia(cantidad){ corazones = corazones - cantidad }
	
	method hayChoque(){
		const obstaculo = self.colliders(self.position())
		if(!obstaculo.isEmpty()){
			obstaculo.impacto(self)
		}
		
	}
}
