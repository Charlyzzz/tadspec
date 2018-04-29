class Persona
  attr_accessor :edad

  def initialize(edad)
    @edad = edad
  end

  def viejo?
    edad > 29
  end
end
