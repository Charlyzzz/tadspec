require_relative '../lib/framework'
require_relative 'persona'

class EspiasTest

  def testear_que_se_use_la_edad
    pato = Persona.new(23)
    pato = espiar(pato)

    pato.viejo?

    pato.deberia haber_recibido(:edad)
    # pasa: edad se llama durante la ejecución de viejo?
  end

  def testear_que_pasa_n_veces
    pato = Persona.new(23)
    pato = espiar(pato)

    pato.viejo?
    pato.viejo?

    pato.deberia haber_recibido(:edad).veces(2)
    # pasa: edad se recibió exactamente 1 vez.
  end

  def testear_que_falla_n_veces
    pato = Persona.new(23)
    pato = espiar(pato)

    pato.deberia haber_recibido(:edad).veces(5)
    # falla: edad sólo se recibió una vez.
  end

  def resto
    #pato.deberia haber_recibido(:viejo?).con_argumentos(19, "hola")
    # falla, recibió el mensaje, pero sin esos argumentos.

    #pato.deberia haber_recibido(:viejo?).con_argumentos()
    # pasa, recibió el mensaje sin argumentos.

    #lean.viejo?
    #lean.deberia haber_recibido(:edad)
  end
end

puts Framework.correr(EspiasTest)
