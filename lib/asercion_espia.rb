class MetodoLlamado
  attr_accessor :selector_esperado, :cantidad_esperada

  def initialize(selector_esperado)
    self.selector_esperado = selector_esperado
    self.cantidad_esperada = 1
  end

  def call(espia)
    espia.registro_de_llamados(selector_esperado) == cantidad_esperada
  end

  def veces(cantidad_esperada)
    self.cantidad_esperada = cantidad_esperada
    self
  end
end
