  Quando("quando preencho o formulario") do
    visit 'https://servicoshom.dpf.gov.br/sinarm-internet/faces/publico/incluirReqRegistroArmaFogo/consultarRequerimentoRegistro.seam'
    @preencher = Requerimento.new
    
    #CPF Cidadão
    @cpf = '32058629108'
    
    #Dados da Arma
    num_serie = 'BRO02'
    modelo = 'PT 58'
    num_nf = '69542'
    cnpj_rev = '92781335000102'
    dt_nf = '13062012'
    
    @preencher.formulario @cpf
    @preencher.proxima
    @preencher.dados_arma num_serie, modelo, num_nf, cnpj_rev, dt_nf
    @preencher.proxima
    @preencher.aceite
    @preencher.proxima
    @preencher.emitindo_requerimento
    sleep(30)
    
 end
