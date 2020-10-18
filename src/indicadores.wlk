import wollok.game.*
import jugador.*

class Indicador {
	const nivelMin = null
	const nivelMax = null
	var property position = game.at(8,8)
	var property image = null
	var property tiempo = null
	var property nivelActual = null
	
	method incrementaEnergia(personajePpal){ personajePpal.modificaEnergia(1)}
	method decrementaEnergia(personajePpal){ personajePpal.modificaEnergia(-1)}
	
		
	method excedeNiveles(personajePpal){ 
		const proximoNivel = personajePpal.nivelActual() + 1 
		return proximoNivel.between(nivelMin,nivelMax)
	}
	method muestraValores(personajePpal){
		game.say(self, personajePpal.energia().toString())
		
	}
	
}

object tablero{
	var property position = game.at(7,7)
	var property image = "roadSign.png"
	
}
