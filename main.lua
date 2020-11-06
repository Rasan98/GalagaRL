require "luafilesystem"


buttons = joypad.get(1)

-------Memory Addresses---------

LIVES =  0x0487
SCORE0 = 0x00e0
SCORE1 = 0x00e1
SCORE2 = 0x00e2
SCORE3 = 0x00e3
SCORE4 = 0x00e4
SCORE5 = 0x00e5
SCORE6 = 0x00e6

-------------------------------]]
function learning_mode()
    emu.speedmode("maximum")
    while(true)
    do
        emu.frameadvance()
        print(emu.framecount())
    end    
end

function setbuttons(str)
    if(string.sub("010", 1, 1) == "1") then
        buttons["left"] = true
    else
        buttons["left"] = false
    end
    
    if(string.sub("010", 2, 2) == "1") then
        buttons["right"] = true
    else
        buttons["right"] = false
    end
    
    if(string.sub("010", 2, 2) == "1") then
        buttons["A"] = true
    else
        buttons["A"] = false
    end
    joypad.set(1, buttons)
end

function getScore()
    millions = memory.readbyte(SCORE0) * 1000000
    hundred_thousands = memory.readbyte(SCORE1) * 100000
    ten_tousands = memory.readbyte(SCORE2) * 10000
    thousands = memory.readbyte(SCORE3) * 1000
    hundreds = memory.readbyte(SCORE4)  * 100
    tens = memory.readbyte(SCORE5) * 10
    ones = memory.readbyte(SCORE6)
    return ones + tens + hundreds + thousands + ten_tousands + hundred_thousands + millions;
end

if(arg == "test") then
    print()
    print(string.sub("010", 2, 2))
    print(string.sub("010", 3, 3))
    return
end

if(arg == "pause") then
    emu.pause()
    return
end

if(arg == "unpause") then 
    emu.unpause()
    return
end

if(arg == "lm") then
    learning_mode()
    return
end

if(arg == "sc") then
    gui.savescreenshotas("hola.png")
    return
end

if(arg == "10st") then
    emu.unpause()
    emu.speedmode("maximum")
    for i = 10, 1, -1
    do
        emu.frameadvance()
    end
    emu.speedmode("normal")
    emu.pause()
    return
end

if(arg == "ini") then

    emu.speedmode("maximum")
    for i = 10, 1, -1
    do
        emu.frameadvance()
    end
    start = joypad.get(1)
    start["start"] = true
    joypad.set(1, start)
    
    for i = 10, 1, -1
    do
        emu.frameadvance()
    end
    
    joypad.set(1, start)

    for i = 650, 1, -1
    do
        emu.frameadvance()
    end

    emu.speedmode("normal")
    return
end

if(arg == "data") then
    print(memory.readbyte(LIVES))
    print(getScore())
    return
end

print("Command not exist")