function space(a,b,c,d) client.SetGameExtraPadding(a,b,c,d) end
function drawMenu(a,b,x,y) gui.drawImage(a .. b,x,y) end

loc = "png//"
i_loc = "items//"
rupee = memory.read_u16_le(0x0200AF0E)

n_table1 = {0,1,2,3,4,5,6,7,8,9}
n_table2 = {0,10,20,30,40,50,60,70,80,90}
n_table3 = {0,100,200,300,400,500,600,700,800,900}

r = {x = 0, y = 0, z = 0}

switch = false

while true do
    memory.writebyte(0x0200AF01, 0xFF)
roll = memory.readbyte(0x03004029)
pad = joypad.get()
if not pad["L"] then switch = false end
if switch == false then
if pad["L"] then memory.writebyte(0x02002AEA, memory.readbyte(0x02002AEA)+2)
    switch = true
end
end
    
button = {b = memory.readbyte(0x02002AF4), a = memory.readbyte(0x02002AF5)}
rupee = memory.read_u16_le(0x02002B00)

space(0,16,0,0)

--Hud
gui.drawImage(loc.."hud.png",0,0)

--Items
gui.drawImage(i_loc.. button.a .. ".png",11,0)
gui.drawImage(i_loc.. button.b .. ".png",51,0)

if button.a == 0x07 then gui.pixelText(23,9,memory.readbyte(0x02002AEC), "white", 0x70000000) end
if button.b == 0x07 then gui.pixelText(63,9,memory.readbyte(0x02002AEC), "white", 0x70000000) end
if button.a == 0x08 then gui.pixelText(20,9,memory.readbyte(0x02002AEC), "white", 0x70000000) end
if button.b == 0x08 then gui.pixelText(23,9,memory.readbyte(0x02002AEC), "white", 0x70000000) end

if button.a == 0x09 then gui.pixelText(23,9,memory.readbyte(0x02002AED), "white", 0x70000000) end
if button.b == 0x09 then gui.pixelText(63,9,memory.readbyte(0x02002AED), "white", 0x70000000) end
if button.a == 0x09 then gui.pixelText(20,9,memory.readbyte(0x02002AED), "white", 0x70000000) end
if button.b == 0x09 then gui.pixelText(23,9,memory.readbyte(0x02002AED), "white", 0x70000000) end

drawMenu(loc,tostring(r.x/100) .. ".png", 78, 8)
drawMenu(loc,tostring(r.y/10) .. ".png", 86, 8)
drawMenu(loc,tostring(r.z) .. ".png", 94, 8)

--Max Hearts
gui.drawImage("png//max//".. memory.readbyte(0x02002AEB)/8 .. ".png",1,0)
--Current Hearts
gui.drawImage("png//cur//".. memory.readbyte(0x02002AEA) .. ".png",1,0)

--Roll
if roll == 1 then gui.drawImage(loc.."roll.png",0,0) end

    for i=1,#n_table1 do
        if rupee%10 == n_table1[i] then r.z = n_table1[i] end
    end

    for i=1,#n_table2 do
        if (rupee-r.z)%100 == n_table2[i] then r.y = n_table2[i] end
    end

    for i=1,#n_table3 do
        if (rupee-(r.y+r.z))%1000 == n_table3[i] then r.x = n_table3[i] end
    end

    emu.frameadvance()
end