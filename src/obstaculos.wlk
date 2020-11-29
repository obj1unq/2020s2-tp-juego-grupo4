import contadores.*
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
			game.removeVisual(self)///VER DE MANDARLO A LIMPIAR CALLE
		}
	}
	
}

class ObjetoAcumulador inherits ObjetoEnPista {
	
	override method impacto(alguien){
		alguien.impactaPasajero()
		if(!config.testeo()){
			game.sound("pasajero.mp3").play()
			calle.limpiar(self)
			game.removeVisual(self)///VER DE MANDARLO A LIMPIAR CALLE
		}

	}
	
}

class ObjetoEnergia inherits ObjetoEnPista {

	var property energiaEfectuada = 0
	
	override method impacto(alguien) {

		alguien.modificaEnergia(energiaEfectuada)
		if(energiaEfectuada<0){
			if(!config.testeo())
				game.sound("choque.mp3").play()
		}else{
			self.corazonesFull()
		}
		
	}
	method corazonesFull(){
		if(personaje.energia()<12){
			if(!config.testeo())	
				game.sound("corazon.mp3").play()
		}
	}
}


class ObjetoMovimiento inherits ObjetoEnPista {
	
	
	override method impacto(alguien) {
		alguien.moverDeMas()
		if(!config.testeo())	
			game.sound("aceite.mp3").play()
	}
	
}

class ObjetoTiempo inherits ObjetoEnPista {
	
	override method impacto(alguien){
		

		alguien.agregarTiempo()	
		if(!config.testeo()){
			game.sound("tiempo.mp3").play()
			calle.limpiar(self)
			game.removeVisual(self)///VER DE MANDARLO A LIMPIAR CALLE
		}
	}
}




object energia {}
object acumulador{}
object movimiento{}
object relojPlus{}





object calle {
	
const property barril = new ObjetoEnergia(image="barril.png", energiaEfectuada = -2,objeto=energia)
const property auto = new ObjetoEnergia(image="auto_rojo.png", energiaEfectuada = -4,objeto=energia)
const property bache = new ObjetoEnergia(image="bache.png", energiaEfectuada = -1,objeto=energia)
const property corazon = new ObjetoEnergia(image="corazon.png", energiaEfectuada = 1,objeto=energia)
const property persona = new ObjetoAcumulador(image="pasajero.png",objeto=acumulador)	
const property tiempo = new ObjetoTiempo(image="reloj5.png",objeto=relojPlus)
const property aceite = new ObjetoMovimiento(image="aceite.png",objeto=movimiento)
	
const property obtaculosAGenerar = [barril, auto, bache, aceite ] //ANYONE SIRVE SOLO CON LISTA
const property ayudasAGenerar = [persona, corazon, tiempo]
const property obtaculosGenerados = []
const property ayudasGeneradas = []
	
	/////REVISAR USAR UNA LISTA
	
	method generarNuevoObjeto(lista) {
		
		const posicion = randomizer.emptyPosition()
        const objetoAGenerar = lista.anyOne()
        					   //randomizer.anyObject(objetosAGenerar)
        const objetoGenerado = factory.generate(objetoAGenerar, posicion)
        
        if(lista == obtaculosAGenerar ) {
        	obtaculosGenerados.add(objetoGenerado)
        }
        else{
        	ayudasGeneradas.add(objetoGenerado)
        }
			game.addVisual(objetoGenerado)
        
	}
	
	///////////////////
	method avanzar(){
		
		obtaculosGenerados.forEach( {objeto => objeto.avanzar() })
		ayudasGeneradas.forEach( {objeto => objeto.avanzar() })
	}
	
	
	method limpiar(obj) {
		
		obtaculosGenerados.remove(obj)
		ayudasGeneradas.remove(obj)
	}
	
}

////VERIFICAR IF - POLIMORFISMO
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