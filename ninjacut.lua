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

function menu(width,height,buttons)

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

local font = "CHINESETAKEAWAY.ttf"

local estado = 0

function love.load()
  font = love.graphics.newFont(20)
  love.window.setTitle("Ninja Cut")
  love.window.setMode(1024, 840)
  
  local w,h =love.graphics.getDimensions()
  
  -- No menu
  bkg_menu2 = love.graphics.newImage("bkg_menu2.jpg")
  --src1 = love.audio.newSource("sounds/soundtrack/The Story So Far Bad Luck.mp3","stream")
  --love.audio.play(src1)
  
  
  
    table.insert(buttons, newButton(
        
        "Start Game",
        function()
          estado = estado +1  -- funcionando
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

--[[
function love.update(dt)
  
end
]]



function love.draw()
  local w,h =love.graphics.getDimensions()
  
  love.graphics.setColor(1,1,1)
  love.graphics.draw(bkg_menu2)
  
  
  
  -- imagino que substituirei tudo a baixo por funções
  love.graphics.setColor(1,1,1)
  love.graphics.draw(bkg_menu2)
  
  love.graphics.setNewFont("CHINESETAKEAWAY.ttf", 200)
  love.graphics.setColor(1,1,1)
  love.graphics.print("NINJA CUT",100,100)
  


  
  local button_width = w * (1/3)
  local button_height = h * (1/15)
  local margin = 20
  
  local total_height = (button_height + margin) * #buttons
  local cursor_y = 0
  
  
  
  
  for i, button in ipairs(buttons) do
      button.last = button.now
    
      local bx = (w * 0.5) - (button_width * 0.5)
      local by = (h*0.5) - (total_height * 0.5) + cursor_y
      
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
          (w*0.5) - textW * 0.5,
          by + textH * 0.5
          )
      
      cursor_y = cursor_y + (button_height + margin)  
      
  end
    
    -- Agora é preciso fazer com que o jogo vá da opção "Start Game" para o jogo.
    --      Pensei transformar o que der ali em cima na Draw em função e criar uma máquina de estados. Assim, quando o usuário startasse "mde = 1" e o jogo começaria.
    
  
    
    
    
end  
  