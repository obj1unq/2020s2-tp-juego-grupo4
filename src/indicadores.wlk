import wollok.game.*
import jugador.*

class Indicador {
	const nivelMin = null
	const nivelMax = null
	var property position = game.at(8,8)
	var property image = null
	var property tiempo = null
	var property nivelActual = null
	
	method incrementaEnergia(personaje){ personaje.modificaEnergia(1)}
	method decrementaEnergia(personaje){ personaje.modificaEnergia(-1)}
	
		
	method excedeNiveles(personaje){ 
		const proximoNivel = personaje.nivelActual() + 1 
		return proximoNivel.between(nivelMin,nivelMax)
	}
	method muestraValores(personaje){
		game.say(self, personaje.energia().toString())
		
	}
	
}

object tablero{
	var property position = game.at(7,7)
	var property image = "roadSign.png"
	
}
