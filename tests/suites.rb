require_relative '../lib/framework'
require_relative 'persona'

class MiSuiteDeTests

  def testear_que_2_es_2
    2.chau
  end
end


class OtraSuiteDeTests < MiSuiteDeTests

  def testear_que_los_viejos_tienen_29_o_mas
    nico.deberia ser_viejo
  end

  def testear_que_nico_es_3
    nico.deberia ser 3
  end

  def no_soy_un_test
    3.deberia ser 3
  end

  def nico
    Persona.new(30)
  end
end

puts Framework.correr(OtraSuiteDeTests)
