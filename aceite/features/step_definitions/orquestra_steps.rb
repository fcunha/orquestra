# encoding: utf-8


####### Variaveis da aplicacao
url_orquestra = "https://orquestra-ct.dev.globoi.com/"


mapa = [["owners","/owner/showsearch/"], ["projetos","/project/showsearch/"], 
["hosts", "/host/showsearch/"], ["criar pool", "/pool/async/insert/"], 
["processos", "/processmonitoration/showsearch/"], ["servidores de transbordo", "/overflowserver/showsearch/"], 
["templates de vms", "/template/showsearch/"], ["relatorio de consumo", "/owner/showreportfilter/"], 
["logs de operacoes", "/log/showsearch/"], ["configuracao de usuarios", "/user/showsearch/"], 
["controle de acesso", "/userdomain/showsearch/"], ["configuracoes do sistema", "/config/showupdate/"]]




##############################


def desloga_logado
  if @browser.span(:class => "user").exists? == true
    @browser.link(:text => "Sair do Sistema").click
  end
end
  

def admin_orquestra_present
  sleep(2)
  desloga_logado()
  if @browser.div(:class, "glb-bloco layout-login").exists? ==true
    @browser.text_field(:name, "login-passaporte").set("fcunha.to@corp.globo.com")
    if ENV['FIREWATIR']
      @browser.text_field(:name, "senha-passaporte").set('spiderman2')
    else
      @browser.password(:name, "senha-passaporte").set('spiderman2')
    end
    @browser.button(:class, "botao-acessar").click
  end
  sleep(1)
end


Dado 'que eu acesso a home do orquestra' do
  @browser.goto url_orquestra
  sleep(2)
  verifica_logado()
end

Dado 'que eu acesso o admin do orquestra' do
  @browser.goto url_orquestra
  sleep(2)
  admin_orquestra_present()
end

Então /devo efetuar logout no sistema/ do
  @browser.link(:text, 'Sair do Sistema').click
end

Então /o texto "(.*)" deve estar presente no header da página/ do |text|
  sleep(2)
  @browser.div(:id, 'musthead').contains_text(text).should  be_true
end

Então /clico na opção de menu para configurar usuarios/ do
  sleep(2)
  @browser.h3(:class, "user").click
  sleep(2)
end


Então /clico em mostrar filtro/ do
  @browser.link(:class, "preferred-action filter").click_link_jquery
end

Então /preencho o campo de email com o texto "(.*)"/ do |campo_email|
  @browser.text_field(:class, "text email").set(campo_email)
end

Então /clico no botão de aplicar/ do
  @browser.button(:class, "button apply").click
end

Então /clico na ação editar/ do
  @browser.link(:class, "edit").click
  sleep(2)
end


Então /marco somente a opção "(.*)"/ do |perfil|
  item = Array.new
  @browser.table(:class, "edit").lis.each do |li|
    item << li.text
  end
  item.each do |x|
    if @browser.checkbox(:id => "id_group_" + item.index(x).to_s).clear == true
      @browser.checkbox(:id => "id_group_" + item.index(x).to_s).clear
    end
  end
    @browser.checkbox(:id => "id_group_" + item.index(perfil).to_s).click
end

Então 'salvo o formulario' do
  @browser.button(:title, "Salvar").click
end

Então /marco a opção "(.*)"/ do |mark|
  opcao = Array.new
  @browser.table(:class, "edit").lis.each do |tabela|
    opcao << tabela.text
  end
  @browser.checkbox(:id => "id_group_" + opcao.index(mark).to_s).click
end

Então /saio do sistema/ do
  @browser.link(:text => "Sair do Sistema").click
end

Então /devo ter acesso a area de "(.*)"/ do |area|
  area = area.downcase.removeaccents
  area = mapa.assoc("#{area}")[1]
  @browser.link(:href, "#{area}").exist?.should == true

end

Então /não devo ter acesso as funções de "(.*)"/ do |area|
  area = area.downcase.removeaccents
  area = mapa.assoc("#{area}")[1]
  @browser.link(:href, "#{area}").exist?.should == false
end





#############


Quando /efetuar uma busca pelo nome "(.*)"/ do |text|
  @browser.text_field(:name, 'q').set(text)
  @browser.button(:text, 'Sair do Sistema').click
end

Então /a pesquisa deve me retornar "(.*)"/ do |text|
  sleep(2)
  @browser.text.include?(text).should == true
end

Quando /existir conteudo com o nome "(.*)" entao o conteudo deve ser retornado na busca/ do |busca|
  if @browser.div(:class, "search_result").exists? == true
    @browser.div(:class, "search_result").contains_text(busca).should be_true
  else
  end
end

Então /o destaque principal com todos os seus elementos deve ser exibido/ do
  @browser.div(:class, 'destaque-home').li(:class, "destaque").exists?.should == true
  @browser.li(:class, "destaque").div(:class, 'destaque-imagem').exists?.should == true
  @browser.li(:class, "destaque").div(:class, 'destaque-conteudo').exists?.should == true
end

Então /a área de informativo rh com todos os seus elementos deve ser exibida/ do
  sleep 1
  @browser.div(:class, 'home-informativos content').exists?.should == true
  @browser.div(:class, "home-informativos content").ul(:class, 'flat noticias').exists?.should == true
  @browser.div(:class, "home-informativos content").contains_text("todos os informativos RH").should  be_true
end



Então /preencho o apelido com "(.*)"/ do |apelido|
  @browser.text_field(:name, "apelido").set(apelido)
end

Então /seleciono a área "(.*)"/ do |area|
  @browser.select_list(:id, "id_area").select(area)
end

Então /seleciono o local "(.*)"/ do |local|
  @browser.select_list(:id, "id_local").select(local)
end

Então /clico no botão de enviar/ do
  @browser.button(:name, "salvar").click

end

Então /a mensagem "(.*)" deve ser exibida/ do |mensagem|
  @browser.div(:text, mensagem).exists?.should == true
end

Então /o box de informações importantes e todos os seus elementos devem estar presentes/ do
  @browser.div(:class, 'home-comunicados content').exists?.should == true
  @browser.div(:class, 'home-comunicados content').contains_text("» todos os comunicados").should  be_true
end

Então /o box de oportunidades e todos os seus elementos devem estar presentes/ do
  sleep(2)
  if @browser.div(:class, 'home-oportunidades content').exists? == true
    @browser.div(:class, "home-oportunidades content").contains_text("Nenhuma vaga em aberto.").should be_true
  else
    @browser.div(:class, 'home-oportunidades content').contains_text("» todas oportunidades").should  be_true
  end
  @browser.div(:class, 'home-oportunidades content').contains_text("» Conhece alguém com o perfil da Globo.com? Indique aqui!").should  be_true
end

Então /o box de eventos e todos os seus elementos devem estar presentes/ do
  sleep(2)
  @browser.div(:class, 'home-eventos content').exists?.should == true
  @browser.div(:class, 'home-eventos content').contains_text("» mais eventos").should  be_true
end

Então /o box de aniversariantes e todos os seus elementos devem estar presentes/ do
  sleep(1)
  @browser.div(:class, 'home-aniversarios content').exists?.should == true
  @browser.div(:class, 'home-aniversarios content').contains_text("» mais aniversários").should  be_true
end

Então /o box de promoções e todos os seus elementos devem estar presentes/ do
  sleep(1)
  @browser.div(:class, 'home-promocoes content').exists?.should == true
  @browser.div(:class, 'home-promocoes content').contains_text("» mais promoções").should  be_true
end

Então /o box nasceu e todos os seus elementos devem estar presentes/ do
  sleep(1)
  @browser.div(:class, 'home-nascimentos content').exists?.should == true
  @browser.div(:class, 'home-nascimentos content').contains_text("veja os últimos nascimentos").should  be_true
end

Então /o item de rodapé "(.*)" deve estar presente/ do |item|
  sleep(1)
  @browser.ul(:class, 'menu-itens').contains_text(item).should  be_true
end

Dado /que eu acesso o menu de "(.*)"/ do |item|
  @browser.goto 'http://intranet.qa01.globoi.com'
  verifica_logado()
  sleep(2)
  @browser.link(:text, item).click
end

Então /os itens da listagem de institucional devem ser exibidos corretamente/ do
  @browser.link(:class, ".item").text.length.should >= 1
#verifica os textos descritivos da listagem  
  @browser.div(:class, "grid_18 omega alpha item").link(:class, "all").text.should == "veja mais"
  qtde_p = @browser.div(:class, "page paginas_lista").ps.length
  qtde_p_valido = 0
  @browser.div(:class, "page paginas_lista").ps.each do |p|
    if p.text.length >0 && p.text.include?("veja mais")
      qtde_p_valido = qtde_p_valido ++1
      p = p.text.chomp("veja mais")
      p.length.should >=1
    end
  end
  if ENV['FIREWATIR']
    qtde_p_valido.should == qtde_p
  else
    qtde_p_valido.should == qtde_p/2
  end
end

Então /os itens da listagem de notícias devem ser exibidos corretamente/ do
  a = Array.new
  @browser.div(:class, "noticias").lis.each do |li|
    a << li.text
  end
  a.each do |item| 
    if item =~ /^\d{2} de \w{2,} de \d{4}/
        proximo_item = a[ a.index(item) +1 ]
        proximo_item.length.should > 0
     end
   end
end

Então /os itens da listagem dentro da div "(.*)" devem ser exibidos corretamente/ do |item|
  a = Array.new
  @browser.div(:class, item).lis.each do |li|
    li.text.length.should > 0
  end
end

Então /o link "(.*)" deve ser exibido/ do |link|
  @browser.link(:class, "all").text.include?(link).should be_true
end
Então /os itens da listagem da area de conhecimento deve ter conteúdo/ do
  item = Array.new
  @browser.div(:class, "page paginas_lista").divs.each do |di|
    item << di.text
    item.length.should > 0
  end
end

Dado /que eu acesso o Admin do Intranet em qa01/ do
  @browser.goto 'http://intranet.qa01.globoi.com/admin'
  admin_intranet_present()
end

Quando /clicar no link "(.*)"/ do |link|
  @browser.link(:text, link).click
end

Quando /clicar no link de menu "(.*)"/ do |link|
  @browser.div(:id, "content-main").link(:text, link).click
end

Quando /^selecionar a categoria "(.*)"$/ do |categoria|
  @browser.select_list(:name, "categoria").select(categoria)
end

Quando /preencher o campo "(.*)" com a informação "(.*)"/ do |campo, info|
  @browser.text_field(:name, "#{campo}").set("#{info}")
end

Quando /preencher o conteúdo com "(.*)"/ do |texto|
  @browser.p(:xpath, "//html/body/p").click
  result.should match(/alguma coisa/)
end

Quando /clicar no botão "(.*)"/ do |botao|
  @browser.button(:name, "#{botao}").click
end

Então /a notícia "(.*)" deve ser exibida/ do |noticia|
  @browser.link(:text, "#{noticia}").exists?.should == true
  @browser.link(:text, "#{noticia}").click
end

Então /a notícia deve ter conteúdo/ do
  @browser.div(:class, "page noticia conteudo").text.length.should > 1
end

Então /ao preencher o formulário de indicação/ do
  @browser.text_field(:name, "nome_curriculo").set("teste")
  result = `/Applications/Sikuli-IDE.app/Contents/MacOS/JavaApplicationStub #{sikuli_script_dir}/seleciona_arquivo_upload.skl`
end

Então /enviar o mesmo deve ser exibida uma mensagem de sucesso/ do
  @browser.button(:value, "enviar").click
  @browser.div(:class, "alpha grid_18 omega").contains_text("Currículo enviado com sucesso.").should  be_true
end
