# language: pt
Funcionalidade: Login
  Para validar o acesso a Home
  Como um funcionário
  Eu gostaria de acessar a Intranet

  Cenário: Logar na Intranet
    Dado que eu acesso a home do orquestra
	Então o texto "Logado como Teste Time Infra" deve estar presente no header da página
	Então devo efetuar logout no sistema