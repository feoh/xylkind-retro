-- title:  xylkind-retro
-- author: Chris Patti
-- desc:   Protect the eggs!
-- script: lua

sprite_counter=0
tick=0
eggs_laid = false
INITIAL_EGGS = 8


keeper = {
  position = {
    x=0,
    y=0
  },
}

eggs = {  
  position = {
    x=0,
    y=0
  },
  laid_at_tick = 0,
  mature_by_tick = 0,
  hatched_at_tick = 0,
  visible=true
}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function move_keeper()
  if btn(0) then keeper.position.y=keeper.position.y-1 end
  if btn(1) then keeper.position.y=keeper.position.y+1 end
  if btn(2) then keeper.position.x=keeper.position.x-1 end
  if btn(3) then keeper.position.x=keeper.position.x+1 end
  spr(sprite_counter % 4,keeper.position.x,keeper.position.y)
  spr((sprite_counter % 4) + 16,keeper.position.x + 8,keeper.position.y)
  spr((sprite_counter % 4) + 32,keeper.position.x + 16,keeper.position.y)
  tick=tick+1

  if tick % 30 == 0 then
    sprite_counter=sprite_counter+1
  end
end


function lay_eggs()
  for egg_count = 1,8 do
    eggs[egg_count] = {
      position = {
        x=math.random(233),
        y=math.random(134)
      },
      laid_at_tick = tick,
      mature_by_tick = math.random(200) + 300 + tick,
      visible = true
    }
  end
  eggs_laid = true
end


function draw_eggs()
  if not eggs_laid then
    lay_eggs()
  end

  for egg_count = 1, #eggs do
    if eggs[egg_count].visible then
      spr(64+egg_count % 4,
        eggs[egg_count].position.x,
        eggs[egg_count].position.y)
    end
  end
end


function hatch_eggs()
  for current_egg =1,#eggs do
    hatched_at_tick = eggs[current_egg].hatched_at_tick
    trace("Tick: " .. tick)
    trace(dump(eggs[current_egg]))
    if hatched_at_tick and (tick > (hatched_at_tick + 50)) then
      spr(80, eggs[current_egg].position.x, eggs[current_egg].position.y)
    elseif hatched_at_tick and (tick > (hatched_at_tick + 150)) then
      spr(81, eggs[current_egg].position.x, eggs[current_egg].position.y)
    elseif hatched_at_tick and (tick > (hatched_at_tick + 250)) then
      eggs[current_egg].visible = false
    elseif tick >= eggs[current_egg].mature_by_tick then
      eggs[current_egg].hatched_at_tick = tick
      spr(80, eggs[current_egg].position.x, eggs[current_egg].position.y)
    end
  end
end


function TIC()

  cls()
  
  draw_eggs()
  move_keeper()
  hatch_eggs()
end

-- <TILES>
-- 000:0000000000000000000050000050500000500500500500500500550500550055
-- 001:0000000000000000005500000000500005555500500005500555555555000055
-- 002:0000000000000000500000000505500050500500050555505050000505055555
-- 003:0000000000000000000000005555500000505000550505500050505555555555
-- 016:0099990000f55f00009059000009000000066000606066066060666666066606
-- 017:0099990000f55f00009559000009000000066000606065056560066666066005
-- 018:0099990000f55f00009559000009000000066000606065066560066660066066
-- 019:0099990000f55f00009559000009000000066000d060650d6660060d660660d6
-- 032:0000000000000000000500000005050000500500050050055055005055005500
-- 033:0000000000000000000055000005000000555550055000055555555055000055
-- 034:0000000000000000000000050005505000500505055550505000050555555050
-- 035:0000000000000000000000000005555500050500055050555505050055555555
-- 064:0000000002222200224442002444442024404442244444420244442002222200
-- 065:0000000002222200224442002444442022404442024444420222442000022200
-- 066:0000000002222000224440002444400024404000244440000244400002222000
-- 067:0000000000002000002242000244442024404442244444420244422002222000
-- 080:0240040004000040000000000055502020151042205550020200004002200000
-- 081:0000000000000000005005000515515050055005055555505005500500000000
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

