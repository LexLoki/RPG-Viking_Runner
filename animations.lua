animations = {}
animations.list = {}
local qFrame=11
local time = 0.9
color = {
  red = {255,0,80,255},
  green = {0,255,0,255},
  blue = {0,0,255,255},
  clear = {255,255,255}
  }

function animations.load()
  animations.image = love.graphics.newImage("/Assets/acidgun_die.png")
  local aw = animations.image:getWidth()
  local ah = animations.image:getHeight()
  local w = aw/5
  local h = ah/3
  animations.quads = {}
  for i=0,qFrame-1 do
    table.insert(animations.quads,love.graphics.newQuad((i%5)*w,math.floor(i/5)*h,w,h,aw,ah))
  end
  animations.width=w
  animations.height=h
end

function animations.update(dt)
  for i,v in ipairs(animations.list) do
    if animComp.update(dt,v.aComp)==-1 then
      table.remove(animations.list,i)
    end
  end
end

function animations.quit()
  table.removeAll(animations.list)
end

function animations.createSplash(x,y,col)
  local c
  if col == nil then c=color.clear else c=col end
  table.insert(animations.list,{x=x,y=y,aComp = animComp.newAnim(qFrame,time,false),color=c})
end

function animations.draw()
  for i,v in ipairs(animations.list) do
    love.graphics.setColor(v.color)
    love.graphics.draw(animations.image,animations.quads[v.aComp.curr_frame],v.x,v.y,0,1.2,1.2,animations.width/2,animations.height/2)
  end
  love.graphics.setColor(color.clear)
end

function animations.loadQuads(quant,nCol,each_w,each_h,sprite_width,sprite_height)
  local quads={}
  for i=0,quant-1 do
    table.insert(quads,love.graphics.newQuad(i%nCol*each_w,math.floor(i/nCol)*each_h,each_w,each_h,sprite_width,sprite_height))
  end
  return quads
end


  --[[
  player.sprites[run].quads = {
    love.graphics.newQuad(0,0,w,h,aw,ah),
    love.graphics.newQuad(w,23,w,h-23,aw,ah),
    love.graphics.newQuad(2*w,34,w,h-34,aw,ah),
    love.graphics.newQuad(3*w,43,w,h-43,aw,ah),
    love.graphics.newQuad(4*w,50,w,h-50,aw,ah),
    love.graphics.newQuad(0,h,w,h,aw,ah),
    love.graphics.newQuad(w,h,w,h,aw,ah),
    love.graphics.newQuad(2*w,h,w,h,aw,ah),
    love.graphics.newQuad(3*w,h,w,h,aw,ah),
    love.graphics.newQuad(4*w,h,w,h,aw,ah)
  }
  ]]