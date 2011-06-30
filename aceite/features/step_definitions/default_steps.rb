# encoding: utf-8

#Verifica se o acesso ja a pagina esta logado ou nao

def verifica_logado
  sleep(2)
  desloga_logado()
  if @browser.table(:class, "f").exist? == true
    if @browser.table(:class, "f").contains_text("©2011 Google")
      @browser.text_field(:name, 'Email').set('teste_timeinfra')
      if ENV['FIREWATIR']
        @browser.text_field(:name, "Passwd").set('Globo123')
      else
        @browser.password(:name, "Passwd").set('Globo123')
      end
      @browser.button(:name, 'signIn').click
    else
    end
  elsif
    if @browser.div(:class, "glb-bloco layout-login").exists? ==true
      @browser.text_field(:name, "login-passaporte").set("teste_timeinfra@corp.globo.com")
      if ENV['FIREWATIR']
        @browser.text_field(:name, "senha-passaporte").set('Globo123')
      else
        @browser.password(:name, "senha-passaporte").set('Globo123')
      end
      @browser.button(:class, "botao-acessar").click
    end
  else
  end
  sleep(1)
end

