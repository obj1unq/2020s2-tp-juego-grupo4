import indicadores.*
import jugador.* 
import wollok.game.*
import config.*

class ObjetoEnPista {
	
	var property position = null 
	var property image = null
	var property objeto = null
	var property sonido = null
	
		 
	method tipoDeObjeto(tipo){
		return tipo == objeto
	}
	
	method impacto(alguien)
	
	method avanzar() {
		position = position.down(1)
		if(position.y() < 0) {
			calle.limpiar(self)
			game.removeVisual(self)
		}
	}
	
}

class ObjetoAcumulador inherits ObjetoEnPista {
	
	
	override method impacto(alguien){
		alguien.impactaPasajero()
		game.sound("pasajero.mp3").play()
		calle.limpiar(self)
		game.removeVisual(self)
	}
	
}

class ObjetoEnergia inherits ObjetoEnPista {

	var property energiaEfectuada = 0
	
	override method impacto(alguien) {

		alguien.modificaEnergia(energiaEfectuada)
		
		//game.sound(sonido.toString()).play()
///NO ANDA
//		sonido.play()

//ESTO ANDA
//		game.sound("choque.mp3").play()

//ESTO TAMPOCO ANDA
//	if(sonido.equals(s_obstaculo))
//		game.sound("choque.mp3").play()
//	if(sonido.equals(s_corazon))
//		game.sound("corazon.mp3").play()
//	if(sonido.equals(s_barril))
//		game.sound("barril.mp3").play()


//NO ANDA
//	if(sonido===s_obstaculo)
//		game.sound("choque.mp3").play()
//	if(sonido===s_corazon)
//		game.sound("corazon.mp3").play()
//	if(sonido===s_barril)
//		game.sound("barril.mp3").play()
//

//ESTO FUNCIONA
	if(energiaEfectuada<0){
		
		//sonido.play()// NO VA
		game.sound("choque.mp3").play()
	}else{
		//sonido.play()//NO VA
		game.sound("corazon.mp3").play()
	}
	}
	
}


class ObjetoMovimiento inherits ObjetoEnPista {
	
	
	override method impacto(alguien) {
		alguien.moverDeMas()
		game.sound("aceite.mp3").play()
	}
	
}

class ObjetoTiempo inherits ObjetoEnPista {
	
	override method impacto(alguien){
		

		alguien.agregarTiempo()	
		game.sound("tiempo.mp3").play()
		calle.limpiar(self)
		game.removeVisual(self)

	}
}




object energia {}
object acumulador{}
object movimiento{}
object relojPlus{}





object calle {
	
const property barril = new ObjetoEnergia(image="barril.png", energiaEfectuada = -2,objeto=energia,sonido=s_obstaculo)
const property auto = new ObjetoEnergia(image="auto_rojo.png", energiaEfectuada = -4,objeto=energia, sonido=s_obstaculo)
const property bache = new ObjetoEnergia(image="bache.png", energiaEfectuada = -1,objeto=energia, sonido=s_obstaculo)
const property corazon = new ObjetoEnergia(image="corazon.png", energiaEfectuada = 1,objeto=energia, sonido=s_corazon)
const property persona = new ObjetoAcumulador(image="pasajero.png",objeto=acumulador, sonido=game.sound("pasajero.mp3"))	
const property tiempo = new ObjetoTiempo(image="reloj5.png",objeto=relojPlus, sonido=game.sound("tiempo.mp3"))
const property aceite = new ObjetoMovimiento(image="aceite.png",objeto=movimiento, sonido =game.sound("aceite.mp3"))
	
const property obtaculosAGenerar = [barril, auto, bache, aceite ] //ANYONE SIRVE SOLO CON LISTA
const property ayudasAGenerar = [persona, corazon, tiempo]
const property obtaculosGenerados = []
const property ayudasGeneradas = []
	
	method generarNuevoObjeto(lista) {
		
		const posicion = randomizer.emptyPosition()
        const objetoAGenerar = lista.anyOne()
        					   //randomizer.anyObject(objetosAGenerar)
        const objetoGenerado = factory.generate(objetoAGenerar, posicion)
        
        if(lista == obtaculosAGenerar ) {
        	obtaculosGenerados.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        else{
        	ayudasGeneradas.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        
	}
	
	
	method avanzar(){
		
		obtaculosGenerados.forEach( {objeto => objeto.avanzar() })
		ayudasGeneradas.forEach( {objeto => objeto.avanzar() })
	}
	
	
	method limpiar(obj) {
		
		obtaculosGenerados.remove(obj)
		ayudasGeneradas.remove(obj)
	}
	
}


object factory {
	
	method generate(struct, pos) {
		return
		if(struct.tipoDeObjeto(movimiento) ) {
			new ObjetoMovimiento(position=pos, image=struct.image()) 
			
		}
		else if(struct.tipoDeObjeto(acumulador) ){
			new ObjetoAcumulador(position=pos, image=struct.image())
		}
		else if(struct.tipoDeObjeto(relojPlus) ){
			new ObjetoTiempo(position=pos, image=struct.image())
		}
		else {
			new ObjetoEnergia(position=pos, image=struct.image(), energiaEfectuada=struct.energiaEfectuada())
		}
	}
	
}



object randomizer {	
	
	method emptyPosition() {
		const position = game.at((1 .. game.width() - 4).anyOne(), game.height() - 1)
		return
		if(game.getObjectsIn(position).isEmpty()) {
			position
		}
		else { 
			self.emptyPosition()
		}
	}
	
	method anyObject(ls) {
		return ls.anyOne()
	}
	
}