  Dado("que estou na pagina de login do sistema") do
    visit 'https://projetoshom.dpf.gov.br/siseg/index.php'
    #visit 'http://projetosdesenv.dpf.gov.br/siseg-prehom/principal.php#'
  end

  Quando("eu informo um {string} e {string}") do |usuario, passoword|
    @login = Login.new
    @login.logar(usuario, passoword)
  end
  
  Entao("vejo {string}") do |msg|
    @msg = msg
    expect(page).to have_content @msg
  end
