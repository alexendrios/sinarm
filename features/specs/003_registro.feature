#language: pt

@registro

Funcionalidade: Registro

Contexto: Sistema Logado
Dado que eu estou logado como "toledo.rct" e 'ctidpf'

@registrar_sucesso
Cenario: Realizar o Requerimento no SINARM

Quando eu estou navegando para realizar o registro
Entao ao finalizar eu vejo a menssagem 'Operação efetuada com sucesso.'