#language: pt

@requerimento

Funcionalidade: Requisicao

Contexto: Sistema Logado
Dado que eu estou logado como "toledo.rct" e 'ctidpf'

@cadastrar_sucesso
Cenario: Realizar o Requerimento no SINARM

Quando eu estou no formulario requisicao
Entao eu vejo a menssagem 'REQUERIMENTO DE AQUISIÇÃO DE ARMA DE FOGO'