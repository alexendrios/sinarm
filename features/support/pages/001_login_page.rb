class Login < SitePrism::Page
  
    #Elementos: Inputs Mapeados
    element :login, '#emailcti'
    element :password, '#senhacti'
    element :expc; '#breadcrumbs-you-are-here'
   
    ##metodo de acao: Logar no Sistema
    def logar(usuario, senha)
        login.set usuario
        password.set senha
        click_button 'acessarcti'
    end
end
