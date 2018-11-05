class Registro < SitePrism::Page

    element :select, 'div.form20px:nth-child(2) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(2) > select:nth-child(1)'
    elements :tabela, 'tr > td'
    element :aceite1, 'div.fLeft:nth-child(8) > input:nth-child(1)'
    element :aceite2, 'div.fLeft:nth-child(15) > input:nth-child(1)'
   
    #método navegação
    def menu
        click_link 'SINARM2'
    end
    
    def home
        click_link "Home"
    end

    def receber
        click_on 'Receber'
    end

    def pesquisar
        click_on "Pesquisar"
    end

    def manifestar
        click_link 'Manifestar'
    end

    def salvar
        click_button 'Salvar'
    end
    
    def emitir_manifestação
        click_button 'formAcompanhar:buttonSalvar'
    end

    def proximo1
        find(:xpath, '//*[@id="formAcompanhar:btnProximo"]').click
    end
    
    def proximo2
        find(:xpath, '//*[@id="formAcompanhar:j_id917"]').click
    end

    def proximo3
        find(:xpath,'//*[@id="formAcompanhar:j_id174"]').click
    end

    def proximo4
        find(:xpath,'//*[@id="formAcompanhar:j_id185"]').click
    end

    def excluir
        find(:xpath, '//*[@id="formAcompanhar:j_id163:13:j_id172"]').click
    end 

    #método finaliza a operação
    def finalizar
        salvar
        emitir_manifestação
        emitir_manifestação
        aceite_opcoes
        encaminhar
    end

    #métodos interação
    def inserir_anexo
        find(:xpath, '/html/body/div[3]/div[2]/div/div/div/form/div[2]/div/div[3]/div[1]/ul/li[14]/div/div/div[2]/div[2]/div/div/table/tbody/tr/td/div[1]').click
        attach_file('formAcompanhar:j_id163:13:uploadArquivos:file', 'C:\\automocao\\sinarm\\features\\arquivo\\PDF_TESTE.pdf', make_visible: true)
        proximo4
        proximo4
        aceite1.click
        aceite2.click
        finalizar
    end

    def encaminhar
        find(:xpath,'//*[@id="formAcompanhar:j_id251"]').click
    end

    def aceite_opcoes
        find('#formAcompanhar\:tipoManifestacao > option:nth-child(6)').select_option
        find('#formAcompanhar\:j_id188\:0').click
        find('.w50pc > option:nth-child(6)').click
    end

    #médodo que realiza o aceite do registro e cria um arquivo com o número de protocolo
    def verfica(cpf_registro)
        tabela[16].find('#formAcompanhar\3a j_id141_body > div.form20px.clear.lHeight18px > div:nth-child(1) > table > tbody > tr > td:nth-child(2) > select > option:nth-child(4)').select_option
        tabela[17].find('#formAcompanhar\3a divCamposEntradaPesquisa > input').click.set cpf_registro 
        pesquisar
  
        @requerimento = tabela[27].text
        
        home
        tabela[17].find('#formAcompanhar\3a divCamposEntradaPesquisa > input').click.set @requerimento
        pesquisar
        tabela[25].click
        receber
        tabela[37].click_button 'formAcompanhar:confimTrans'
        pesquisar
        manifestar

        #navegando nas páginas
        proximo1
        proximo2
        proximo3
        proximo4

        #verifica se foi inserido um anexo
        if page.has_text? 'O campo Comprovante bancário de pagamento da taxa é obrigatório'
            inserir_anexo
            finalizar
         else
            finalizar
        end
        
        salvar
        #cria um arquivo com o número de protocolo
        File.open('protocolo.txt', 'w') do |escrita|
            escrita.puts find('dt.mensagem_sucesso:nth-child(1) > span:nth-child(1)').text
        end
    end
end
