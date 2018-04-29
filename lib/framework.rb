require_relative 'suite'

class Framework

  def self.correr(suite)
    suite.include Suite
    tests = suite.instance_methods.select {|selector| selector.to_s.start_with?('testear_que_')}
    resultados = {}
    tests.each do |mensaje|
      begin
        suite.new.send(mensaje)
        resultados[mensaje] = nil
      rescue Exception => e
        resultados[mensaje] = e
      end
    end
    resultados
  end
end
