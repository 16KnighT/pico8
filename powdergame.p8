pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
poke(0x5f2d,1)

powders={}

function _init()
	cls()
	mouse={
		x=0,
		y=0,
		click=false
		}
end

-->8
function updatemouse()
	mouse.x = stat(32)
	mouse.y = stat(33)
	mouse.click = stat(34)
end

function create(material)
	if pget(mouse.x,mouse.y)==0 then
		newpowder={
			material=material,
			x=mouse.x,
			y=mouse.y
			}
			add(powders,newpowder)
	end
end



function _update60()
	updatemouse()
	--leftclick == powder
	if mouse.click==1 then
		create(10)
	end
	--rightclick == liquid
	if mouse.click==2 then
		create(12)
	end
end
-->8
function displace(px,py)
 for p in all(powders) do
 	if p.x==px and p.y==py and p.material==12 then
 		p.y=py-1
 		pset(px,p.y,12)
 		return
 	end
 end
end

function updatepowder()
	for p in all(powders) do
		pset(p.x,p.y,0)
		if pget(p.x,p.y+1)==0 then
			p.y = p.y+1
		elseif pget(p.x+1,p.y+1)==0 then
			p.y = p.y+1
			p.x = p.x+1
		elseif pget(p.x-1,p.y+1)==0 then
			p.y = p.y+1
			p.x = p.x-1
		--extra code for liquids
		elseif p.material==12 then
			move = flr(rnd(3)-1)
			if pget(p.x + move,p.y)==0 then
				p.x = p.x+move
			end
		--if it's not a liquid it can displace liquid
		elseif pget(p.x,p.y+1)==12 then
			p.y = p.y+1
			displace(p.x,p.y)
		end
		pset(p.x,p.y,p.material)
	end
end

function showpowder()
	for p in all(powders) do
		pset(p.x,p.y,p.material)
	end
end

function _draw()
	line(0,127,127,127,5)
	updatepowder()
	cls()
	showpowder()
	spr(0,mouse.x, mouse.y)

end
__gfx__
01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17771000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17777100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17711000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
