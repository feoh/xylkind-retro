-- title:  xylkind-retro
-- author: Chris Patti
-- desc:   Protect the eggs!
-- script: lua

t=0
x=96
y=24
c=0
eggs_laid = false
NUM_EGGS = 8

eggs = {	
  position = {
    x=0,
    y=0
  },
  hatched = false,
}



function lay_eggs()
  for egg_count = 1,8 do
    eggs[egg_count] = {
      position = {
        x=math.random(233),
        y=math.random(134)
      },
    }
  end
  eggs_laid = true
end


function draw_eggs()
  if not eggs_laid then
    lay_eggs()
  end

  for egg_count = 1, NUM_EGGS do  
	  spr(16+egg_count % 4, eggs[egg_count].position.x, eggs[egg_count].position.y)
  end
end

function TIC()

	cls()
  
  draw_eggs()
	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btn(2) then x=x-1 end
	if btn(3) then x=x+1 end
	spr(t % 4,x,y)
	c=c+1
	
	if c % 30 == 0 then
	  t=t+1
	end
end

-- <TILES>
-- 000:0099990000f55f00009559000009000000066000606066006060666066066606
-- 001:0099990000f55f00009559000009000000066000006065050560066066066005
-- 002:0099990000f55f00009559000009000000066000006065000560060000066000
-- 003:0099990000f55f00009559000009000000066000d060650dd560060d000660d0
-- 016:0000000002222200224442002444442024404442244444420244442002222200
-- 017:0000000002222200224442002444442022404442024444420222442000022200
-- 018:0000000002222000224440002444400024404000244440000244400002222000
-- 019:0000000000002000002242000244442024404442244444420244422002222000
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

