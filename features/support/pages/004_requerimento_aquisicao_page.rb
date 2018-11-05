class Requerimento < SitePrism::Page
 

    element :pessoa, '#j_id36\:tipoPessoa\:0'
    element :categorai, 'select.w40pc > option:nth-child(2)'
    element :cpf, '.mask-cpf'
    element :opcao_1, '#j_id36\:j_id76\:0'
    element :codigo_autorizacao, '#j_id36\:j_id80 > div:nth-child(1) > input:nth-child(2)'
    element :input_captcha, '#j_id36\:captcha'
    element :botao_avancar, 'input.btn:nth-child(1)'
    element :botao_proxima, '#formGeral\:j_id639'
    element :numero_serie, '#formGeral\:j_id507 > div:nth-child(1) > div:nth-child(1) > input:nth-child(2)'
    element :marca, '#formGeral\:j_id507 > div:nth-child(2) > div:nth-child(1) > select:nth-child(2) > option:nth-child(2330)'
    element :modelo, '#formGeral\:cbModeloArma > div:nth-child(1) > input:nth-child(2)'
    element :numero_nota_fiscal, '#formGeral\:cbProdutoArma > div:nth-child(5) > div:nth-child(1) > input:nth-child(2)'
    element :cnpj_revedendor, '#formGeral\:cbProdutoArma > div:nth-child(6) > div:nth-child(1) > input:nth-child(2)'
    element :data_nota_fiscal, '#formGeral\:j_id586InputDate'
    element :aceite_termos, 'div.linha:nth-child(1) > input:nth-child(1)'
    
    element :temo_Responsabilidade, '#formGeral\:termoResponsabilidade\:declaracaoVeracidade'
    element :uf, '#formGeral\:termoResponsabilidade\:ufUnidadeAtendimento > option:nth-child(8)'
    element :cidade, '#formGeral\:termoResponsabilidade\:municipiosUnidade > option:nth-child(2)'
    element :unidadde, '#formGeral\:termoResponsabilidade\:postoAtendimento > option:nth-child(2)'
    element :input_captcha2, '#formGeral\:captcha'

    # função interação botões
    def prosseguir
        botao_avancar.click
    end

    def proxima
        botao_proxima.click
    end

    def aceite
        aceite_termos.click
    end

    def emitir_req
        click_button 'Emitir Requerimento'
    end

=begin 

    * Método provisório para solução da Captcha
    * Neste momento será necessário a interação com o usuário
    * Pois é necessário a inserção dos valores para dar continuidade ao Teste automatizado
=end
    #metodo alert javaScript
    def infomacao
        page.execute_script('alert("Digite o texto da Captcha\n"
         + "Lembrando que você terá 15 Segundos\n"
         + "Para finalizar o Processo\n"
         + "Por Gentileza não clique em nenhum botão\n"
         + "Esta menssagem será fechada em 15 segundos");')  
         sleep(15)
     end

    #metódo habilitando campo
    def codigo(campo)
        page.accept_alert
        campo.click
        sleep(15)
    end

    #Criação do método Leitura onde de um arquivo texto ao qual resultará de um Número de Autorização
    def leitura
        File.open('protocolo.txt', 'r') do |ler|
            while novaLinha = ler.gets
              @protocolo = novaLinha
            end
        end
        numero = @protocolo.split(":")
        @autorizacao = numero[1]
    end

    # Método Preenche os dados no formulário
    def formulario(cpf_informado)
        leitura
        pessoa.click
        categorai.select_option
        cpf.click
        cpf.set cpf_informado
        opcao_1.click
        codigo_autorizacao.click
        codigo_autorizacao.set  @autorizacao
        infomacao
        codigo input_captcha
        prosseguir
    end

    # Método Preenche os dados da Arma
    def dados_arma(serie_arma, modelo_arma, nota_fiscal, cnpj, data_nf)
        numero_serie.click
        numero_serie.set serie_arma
        marca.select_option
        modelo.click
        modelo.set modelo_arma
        numero_nota_fiscal.click
        numero_nota_fiscal.set nota_fiscal
        cnpj_revedendor.click
        cnpj_revedendor.set cnpj
        data_nota_fiscal.click
        data_nota_fiscal.set data_nf
    end

    #método referente a ultima parte do formulário - Emitir Requerimento
    def emitindo_requerimento
        temo_Responsabilidade.click
        uf.select_option
        cidade.select_option
        unidadde.select_option
        infomacao
        codigo input_captcha2
        emitir_req
    end
    
end