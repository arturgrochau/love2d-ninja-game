--[[ O jogo vai se tratar de um ninja controlado pelo player no canto da tela que mata outros ninjas que correm para cima dele vindo do canto direito.
     O usuário passará de fase quando atingir certo número de pontos que, por sua vez, são auferidos ao abater outros ninjas.
     
    Vai começar com uma imagem com um som tocando. Qualquer pressionar de tecla ou botão destravará a tela.
    A opção de níveis aparece.
      Cada nível só será desbloqueado a partir da finalização do anterior.
      
    Quando um nível carregar outro som tocará, a imagem de fundo mudará e os personagens serão introduzidos.

]]

--[[ O que está sendo feito: X(Tela de menu) e inserção de som inicial.
                               Máquina de estados

]]

function menu(width,height,buttons,font)
  -- poe o background
  love.graphics.setColor(1,1,1)
  love.graphics.draw(bkg_menu2)
  
  -- desenha o título da tela
  love.graphics.setNewFont("CHINESETAKEAWAY.ttf", 200)
  love.graphics.setColor(1,1,1)
  love.graphics.print("NINJA CUT",100,100)
  
  -- decide o tamanho dos botões
  local button_width = width * (1/3) + 40
  local button_height = height * (1/15) + 40
  local margin = 20
  
  
  local total_height = (button_height + margin) * #buttons
  local cursor_y = 0
  
  
  
  for i, button in ipairs(buttons) do
      button.last = button.now
    
      local bx = (width * 0.5) - (button_width * 0.5)
      local by = (height*0.5) - (total_height * 0.5) + cursor_y + 60
      
      local color = {0.4, 0.4, 0.5,1.0}
      local mx,my = love.mouse.getPosition()
      
      
      local hot = mx > bx and mx < bx + button_width and
                  my > by and my < by + button_height
                  
      if hot then
        color = {0.8,0.8,0.9, 1.0}
      end
      
      button.now = love.mouse.isDown(1)
      if button.now and not button.last and hot then
        button.fn()
      end
      
      love.graphics.setColor(unpack(color))
      love.graphics.rectangle(
        "fill",
        bx,
        by,
        button_width,
        button_height
      )
        
      love.graphics.setColor(0,0,0,1)
      
      local textW = font:getWidth(button.text)
      local textH = font:getHeight(button.text)
      
      love.graphics.print(
          button.text,
          font,
          (width*0.5) - textW * 0.5,
          by + textH * 0.5
          )
      
      cursor_y = cursor_y + (button_height + margin)  
      
  end

  return 0
end





-- rodada 
function rodada()


end





function newButton(text, fn)
  return{
      text = text,
      fn = fn,
      
      -- fazendo a cliping function
      now = false,
      last = false
    }
end

local buttons = {}

local font 

local pontos = 0

  estado = 0


function love.load()
  font = love.graphics.setNewFont("CHINESETAKEAWAY.ttf",48)  -- font título menu
  font2 = love.graphics.setNewFont("CHINESETAKEAWAY.ttf",27) -- font 
  font3 = love.graphics.setNewFont(27)                       -- font pontos
  love.window.setTitle("Ninja Cut")
  love.window.setMode(1024, 840)
  
  local w,h =love.graphics.getDimensions()
  
  -- No menu
  bkg_menu2 = love.graphics.newImage("bkg_menu2.jpg")
  src1 = love.audio.newSource("sounds/soundtrack/stretch-arm-strong-the-hardest-part.mp3","stream")
  naruto = love.audio.newSource("sounds/soundtrack/Naruto OST 1 -  Naruto Main Theme.mp3","stream")
  cut_song = love.audio.newSource("sounds/soundtrack/effects/CUT.mp3","static")
  love.audio.play(naruto)
  
  
  
  -- No round
  bkg_round2_terrain = love.graphics.newImage("bkg_round2 _terrain.jpg")
  cut_ninja = love.graphics.newImage("CutNinja1.png")
  enemy_ninja = love.graphics.newImage("cartoon_ninja.jpg")
  ninja2_x = 850 -- a caixa precisa se mecher horizontalmente e, portanto, aqui serão feitas as modificações. 
  ninja2_y = 580
  derrota_menu = love.graphics.newImage("derrota.jpg") 
  vitoria_menu = love.graphics.newImage("ninja_vitorioso.png")
  
  
  -- Parte dos botões
    table.insert(buttons, newButton(
        -- O botão start possui o poder de por o estado 1, o que marca o início da rodada e para a música da tela inicial.
        "Start Game",
        function()
          love.audio.play(cut_song)
          estado = estado +1  -- funcionando
          -- love.audio.stop()
          print("Starting Game")
        end))

--[[
    table.insert(buttons, newButton(
        "Load Game",
        function()
            print("Loading game")
        end))
    
    table.insert(buttons, newButton(
      "Setings",
      function()
        print("Going to Settings menu")
      end))
      
      ]]
      
      table.insert(buttons, newButton(
      "Exit",
      function()
        love.event.quit(0)
      end))
end




-- Função Eventos do Mouse
function love.mousepressed(x,y,bt)
  
end




-- variável que move ninja2
-- é a ninja2_x
function love.update(dt)
  if estado == 1 then
    love.timer.sleep(0.05)
    ninja2_x = ninja2_x - 20 * (math.log(pontos + 1) + 1)
  else
    ninja2_x = 1200
  end
end




function love.draw()
  local w,h =love.graphics.getDimensions()
  
  if estado == 0 then
    menu(w,h,buttons,font)
  elseif estado == 1 then
    -- aqui será a partida
    --[[ Pensamento: 
                     Xbackground de teste(depois fazer ele correr)
                     Xpontos no lado esquerdo da tela
                     Xdesenhar 2  quadrados
                     Xfazer o ninja2 correr
                     fazer o ninja1 atacar
                     arte dos ninjas
                     
                     
    ]]
    --background
    love.graphics.draw(bkg_round2_terrain)
    
    -- placar
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(font2)
    love.graphics.print("Pontos: ".. pontos, w*4/5+50,8)
    
    -- ninja 1
    love.graphics.draw(cut_ninja, 50, 580)
    -- love.graphics.rectangle( "line", 50, 580, 200,160  )
    
    -- ninja 2
    -- ele deve surgir dps de 4 segundos. Usarei a love.update para invocar ele 
    --ninja2_x = 850 -- é necessário algo para fazer a caixa se mecher
    --local ninja2_y = 580
    --love.graphics.draw(cut_ninja, 50, 580)
    love.graphics.rectangle( "line",  ninja2_x, ninja2_y, 200,160 ) 

    
    
    -- /!\ o quadrado nasce em algum lugar além do proposto e desejo emplementar o cooldown de 4 segundos depois que resolver isso.
    -- Continuando ...
    
  

    -- Precisa-se detectar quando o ninja2 está próximo o suficiente de 1 para o corte.
    click_cut = love.mouse.isDown(1)
    space_cut = love.keyboard.isDown("space")
    pressed = click_cut or space_cut

    local enemys_close
    if ninja2_x >=50 and ninja2_x <= 300 then
      enemys_close = true 
      love.graphics.setColor(0,1,0)
      love.graphics.print("CUT",200,200)
      
    -- se o usuário apertar a barra de espaço nesse meio tempo ele vai para próxima tela (estado +=1) 
      if pressed then 
        love.audio.play(cut_song)
        pontos = pontos + 1
        if (pontos < 20) then
          ninja2_x = 1200
          estado = 1
        else
          estado = 3
        end
      end
      
    elseif ninja2_x < 50 or (ninja2_x > 300 and ninja2_x < 1100 and pressed) then
      love.audio.play(cut_song)
      estado = 2 -- vai para o estado de derrota      
    end
    
   -- estado 2
  elseif estado == 2 then
    -- perdeu
    love.graphics.draw(derrota_menu,640,300)
    love.graphics.setColor(1,0,0)
    love.graphics.print("LOSE", 70,70)
    
    
    -- pontuação
    love.graphics.print("Pontos: ".. pontos,70,120)
    
    -- creditos
    love.graphics.setColor(1,1,1)G
    love.graphics.print("https://github.com/SlenderKS/NinjaCut",20,20)  
  else
    -- ganhou
    love.graphics.draw(vitoria_menu,90,0)
  
    -- pontuação
    love.graphics.setColor(0,0,0)
    love.graphics.print("Pontos: ".. pontos,100,180)
    love.graphics.setColor(1,1,1)
  
  end 
end  
  
