require_relative '../lib/framework'
require_relative 'persona'

class MiSuite

  def testear_que_es_igual
    7.deberia ser 7
  end

  def testear_que_es_mayor
    50.deberia ser mayor_a 20
  end

  def testear_que_es_menor
    12.deberia ser menor_a 20
  end

  def testear_que_es_uno_de_estos
    "hola".deberia ser uno_de_estos [7, 22, "hola"]
  end

  def testear_que_aserta_metodo_booleano
    nico = Persona.new(30)
    nico.deberia ser_viejo
  end
end

puts Framework.correr(MiSuite)
