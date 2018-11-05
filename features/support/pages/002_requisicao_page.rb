class Requisicao < SitePrism::Page

    #Mapeando imput
    element :nome, '#formGeral\:formTabIdentificacao\:nomePF'
    element :cpf, '#formGeral\:formTabIdentificacao\:numeroCPF'
    element :rg, '#formGeral\:formTabIdentificacao\:numRG'
    element :rg_orgao, '#formGeral\:formTabIdentificacao\:orgaoExpRG'
    element :rg_data_expedicao, '#formGeral\:formTabIdentificacao\:dtExpRGInputDate'
    element :nome_pai, '#formGeral\:formTabIdentificacao\:nomePaiPf'
    element :nome_mae, '#formGeral\:formTabIdentificacao\:nomeMae'
    element :data_nascimento, '#formGeral\:formTabIdentificacao\:dataNascInputDate'
    element :pais_nascimento, '#formGeral\:formTabIdentificacao\:paisNasc'
    element :uf_nascimento , '#formGeral:formTabIdentificacao:ufNasc'
    element :municipio_nascimento, '#formGeral:formTabIdentificacao:municNasc'
    element :cep , '#formGeral\:formTabIdentificacao\:cepRes'
    element :logradouro, '#formGeral\:formTabIdentificacao\:logradouroRes'
    element :residencia_numero, '#formGeral\:formTabIdentificacao\:numRes'
    element :residencia_bairro, '#formGeral\:formTabIdentificacao\:bairroRes'
    element :ddd, '#formGeral\:formTabIdentificacao\:dddTelCelRes'
    element :telefone_celular, '#formGeral\:formTabIdentificacao\:telCelRes'
    element :observacoes, '.w100pc'
    element :input_captcha, '#formGeral\:captcha'
    element :texto, '.mensagem_erro'
   
    #método de acao
    def avancar
        click_button 'formGeral:proximo' 
    end

    def emitir
        click_button 'formGeral:emitirReq'
    end
    
    def limpar
        click_button 'formGeral:limpar'
    end

    def submeter
        emitir 
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
    def codigo
        page.accept_alert
        input_captcha.click
    end
    

    #Método seleciona o tipo de Cadastro a ser realizado
    def escolha(tipo_pessoa)
        tipo_pessoa = tipo_pessoa.upcase

        if tipo_pessoa.eql? "PESSOA JURÍDICA"
                choose('formGeral:formTabIdentificacao:tipoPessoa:1', allow_label_click: true) 
             else 
                choose('formGeral:formTabIdentificacao:tipoPessoa:0', allow_label_click: true) 
        end
    end
    
    def preencher_cadastro_tipo(tipo)
        tipo = tipo.upcase
       if tipo.eql? 'CIDADÃO'
                find('#formGeral\:formTabIdentificacao\:categoriasPF > option:nth-child(2)').select_option
            elsif tipo.eql? 'SERVIDOR PÚBLICO(PORTE POR PRERROGATIVA DE FUNÇÃO)'
                find('#formGeral\:formTabIdentificacao\:categoriasPF > option:nth-child(3)').select_option
            elsif tipo.eql? 'CAÇADOR DE SUBSTÂNCIA'
                find('#formGeral\:formTabIdentificacao\:categoriasPF > option:nth-child(1)').select_option
        end
    end

    #método país nascimento
    def pais_nascimento_interessado(pais, uf, municipio)
        pais = pais.upcase
        uf = uf.upcase
        municipio = municipio.capitalize

        select pais, from: 'formGeral:formTabIdentificacao:paisNasc'

        if pais.eql? 'BRASIL'
            uf_nascimento_interessado(uf)
            municipio_nascimento_interessado(municipio)
        end
    end

    #metodo uf de nascimento
    def uf_nascimento_interessado(uf_interessado)
        select uf_interessado,  from: 'formGeral:formTabIdentificacao:ufNasc'
    end

    #Método Município do Nascimento
    def municipio_nascimento_interessado(municipio_interessado)
        select municipio_interessado, from: 'formGeral:formTabIdentificacao:municNasc'
    end

    #método identificacao
    def identificacao(nome_interessado, nome_mae_interessado, nome_pai_interessado,data_nascimento_interessado)
        nome.set nome_interessado
        nome_mae.set nome_mae_interessado
        nome_pai.set nome_pai_interessado
        data_nascimento.click
        data_nascimento.set data_nascimento_interessado
    end

    #método documentação
    def documentacao_cpf(cpf_interessado)
        cpf.click
        cpf.set cpf_interessado       
    end

    def documentacao_rg(rg_interessado, orgao_interessado, rg_data_expedicao_interessado, rg_uf_interessado)
        rg_uf_interessado = rg_uf_interessado.upcase
        rg.click
        rg.set rg_interessado
        rg_orgao.click
        rg_orgao.set orgao_interessado
        rg_data_expedicao.click
        rg_data_expedicao.set rg_data_expedicao_interessado
        select rg_uf_interessado,  from: 'formGeral:formTabIdentificacao:ufExpeRG'
    end

    #Método dados complementares
    def dados_complementares(estado_civil, profissao, sexo)
        select estado_civil, from: 'formGeral:formTabIdentificacao:estadoCivil'
        select profissao, from: 'formGeral:formTabIdentificacao:prof'
        select sexo, from: 'formGeral:formTabIdentificacao:sex'
    end

    #método endereço
    def dados_endereco(cep_interessado, logradouro_interessado, endereco_uf_interessado)
        endereco_uf_interessado = endereco_uf_interessado.upcase
        cep.click
        cep.set cep_interessado
        logradouro.set logradouro_interessado
        select endereco_uf_interessado, from: 'formGeral:formTabIdentificacao:ufRes'
    end

    #método escplha tipo de Residência
    def opcao_residencia(opcao_residencia, residencia_numero_interessado, bairro_interessado, residencia_municipio)
        residencia_municipio = residencia_municipio.capitalize

        if opcao_residencia.eql? 'Residencial'
                find('#formGeral\:formTabIdentificacao\:tipoEndResidencial > option:nth-child(2)').select_option
            elsif opcao_residencia.eql? 'Comercial'
                find('#formGeral\:formTabIdentificacao\:tipoEndResidencial > option:nth-child(3)').select_option
            elsif opcao_residencia.eql? 'Outros'
                find('#formGeral\:formTabIdentificacao\:tipoEndResidencial > option:nth-child(4)').select_option
        end

        residencia_numero.click
        residencia_numero.set residencia_numero_interessado
        residencia_bairro.click
        residencia_bairro.set bairro_interessado
        select residencia_municipio, from: 'formGeral:formTabIdentificacao:municipioRes'
    end

    #método que insere o telefone
    def informar_telefone_celular(ddd_interessado, telefone_celular_interessado)
        ddd.click
        ddd.set ddd_interessado
        telefone_celular.click
        telefone_celular.set telefone_celular_interessado
    end

    #Método que escolhe o armamento
    def escolher_armamento(especie, calibre)
        select especie, from: 'formGeral:formDadosArma:especieArma'
        select calibre, from: 'formGeral:formDadosArma:calibreArma'
    end

    #metódo que lança observações a arma
    def observacoes_arma(obs)
        observacoes.click
        observacoes.set obs
    end

    #método finalizacao do cadastro
   def finalizar_cadastro(uf_finalizacao, cidade_finalizacao, local_finalizacao)
        uf_finalizacao = uf_finalizacao.upcase
        cidade_finalizacao = cidade_finalizacao.capitalize
        local_finalizacao = local_finalizacao.upcase

        find('#formGeral\:termoResponsabilidade\:declaracaoVeracidade').click
        select uf_finalizacao, from: 'formGeral:termoResponsabilidade:ufUnidadeAtendimento'
        select cidade_finalizacao, from: 'formGeral:termoResponsabilidade:municipiosUnidade'
        select local_finalizacao, from: 'formGeral:termoResponsabilidade:postoAtendimento'
   end
   


    
end

