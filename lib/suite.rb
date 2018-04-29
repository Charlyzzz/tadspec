require_relative 'framework'
require_relative 'test_fallido'
require_relative 'espia'
require_relative 'asercion_espia'

module Suite

  def self.included(_quien_me_incluye)
    Object.include Testeable
  end

  # objeto.deberia ser resultado_esperado
  # 7.deberia(self.ser(7))
  def ser(configuracion)
    if configuracion.respond_to? :call
      configuracion
    else
      ->(valor_actual) {configuracion == valor_actual}
    end
  end

  def mayor_a(valor_esperado)
    ->(valor_actual) {valor_actual > valor_esperado}
  end

  def menor_a(valor_esperado)
    ->(valor_actual) {valor_actual < valor_esperado}
  end

  def uno_de_estos(posibles_valores_esperados)
    ->(valor_actual) {posibles_valores_esperados.include? valor_actual}
  end

  def haber_recibido(selector_recibido)
    MetodoLlamado.new(selector_recibido)
  end

  def espiar(objeto_a_espiar)
    Espia.new(objeto_a_espiar)
  end

  def respond_to_missing?(selector, algo)
    metodo_ser_dinamico?(selector) || super
  end

  def method_missing(selector, *argumentos, &bloque)
    if metodo_ser_dinamico?(selector)
      mensaje_del_objeto = selector.to_s[4..-1] + '?'
      ->(valor_actual) {valor_actual.send(mensaje_del_objeto)}
    else
      super
    end
  end

  private

  def metodo_ser_dinamico?(selector)
    selector.to_s.start_with? 'ser_'
  end

  module Testeable

    def deberia(asercion)
      raise TestFallido.new('El test falló!') unless asercion.call(self)
    end
  end
end
