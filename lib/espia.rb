class Espia
  attr_accessor :espiable, :llamados

  def initialize(objeto_a_espiar)
    self.espiable = objeto_a_espiar
    self.llamados = {}
    redirigir_metodos
  end

  def respond_to_missing?(selector)
    espiable_entiende?(selector) || super
  end

  def method_missing(selector, *argumentos, &bloque)
    if espiable_entiende?(selector)
      espiable.send(selector, *argumentos, &bloque)
    else
      super
    end
  end

  def registro_de_llamados(selector)
    cantidad_de_llamados(selector)
  end

  private

  def redirigir_metodos
    metodos_publicos_del_espiable.each do |metodo|
      recablear_metodo(metodo)
    end

    metodos_privados_del_espiable.each do |metodo|
      recablear_metodo_privado(metodo)
    end
    resetear_llamados
  end

  def resetear_llamados
    self.llamados = {}
  end

  def recablear_metodo_privado(metodo)
    recablear_metodo(metodo)
    espiable.singleton_class.send(:private, metodo.name)
  end

  def recablear_metodo(metodo)
    espia = self
    selector = metodo.name
    espiable.define_singleton_method(selector) do |*argumentos, &bloque|
      espia.send(:registrar_llamado, selector)
      metodo.call(*argumentos, &bloque)
    end
  end

  def metodos_publicos_del_espiable
    espiable.methods.map {|selector| espiable.method(selector)}
  end

  def metodos_privados_del_espiable
    espiable.private_methods.map {|selector| espiable.method(selector)}
  end

  def registrar_llamado(selector)
    llamados[selector] = cantidad_de_llamados(selector) + 1
  end

  def cantidad_de_llamados(selector)
    llamados[selector] || 0
  end

  def espiable_entiende?(selector)
    espiable.respond_to? selector
  end
end
