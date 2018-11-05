
Quando("eu estou navegando para realizar o registro") do
  @registrar = Registro.new

  janela = window_opened_by do
       @registrar.menu
  end

  within_window janela do
        cpf = '32058629108'
        @registrar.verfica cpf
        @resultado = page.has_text?('Operação efetuada com sucesso.')
        janela.close 
  end
end
  
Entao("ao finalizar eu vejo a menssagem {string}") do |msm|
    
    @resultado.eql? msm
    find('#sair').click
end
  
