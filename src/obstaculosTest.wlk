import indicadores.*
import jugador.* 
import wollok.game.*

object obstaculoAuto {
	const energiaQueQuita = 4
	
	var property image="auto_rojo.png"
	var property position = game.at(1,0)
	
	method impacto(personajePpal){ personajePpal.quitarEnergia(energiaQueQuita) }
}
