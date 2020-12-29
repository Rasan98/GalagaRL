buttons = joypad.get(1)
filename = "pass_data.txt"
mod_time = ""

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

function get_mod_time()
    local file = io.popen("forfiles /M pass_data.txt /C \"cmd /c echo @fdate @ftime\" ")
    local output = file:read('*all')
    file:close()
    return output
end

function setbuttons(str)
    if(string.sub(str, 1, 1) == "1") then
        buttons["left"] = true
    else
        buttons["left"] = false
    end
    
    if(string.sub(str, 2, 2) == "1") then
        buttons["right"] = true
    else
        buttons["right"] = false
    end
    
    if(string.sub(str, 2, 2) == "1") then
        buttons["A"] = true
    else
        buttons["A"] = false
    end
    joypad.set(1, buttons)
end

function getScore()
    local millions = memory.readbyte(SCORE0) * 1000000
    local hundred_thousands = memory.readbyte(SCORE1) * 100000
    local ten_tousands = memory.readbyte(SCORE2) * 10000
    local thousands = memory.readbyte(SCORE3) * 1000
    local hundreds = memory.readbyte(SCORE4)  * 100
    local tens = memory.readbyte(SCORE5) * 10
    local ones = memory.readbyte(SCORE6)
    return ones + tens + hundreds + thousands + ten_tousands + hundred_thousands + millions;
end

function init()
    emu.speedmode("maximum")
    for i = 10, 1, -1
    do
        emu.frameadvance()
    end
    local start = joypad.get(1)
    start["start"] = true
    joypad.set(1, start)
    
    for i = 10, 1, -1
    do
        emu.frameadvance()
    end
    
    joypad.set(1, start)

    for i = 680, 1, -1
    do
        emu.frameadvance()
    end
end

function send_status(lives)
    local score = getScore()
    local message = tostring(lives) .. " " .. tostring(score)
    gui.savescreenshotas("current_state.png")
    
    local file = io.open(filename, "w")
    io.output(file)
    io.write(message)
    io.close(file)
    mod_time = get_mod_time()
end

function receive_move()
    
    while(mod_time == get_mod_time()) do
    end

    local file = io.open(filename, "r")
    io.input(file)
    local move = io.read()
    io.close()
    mod_time = get_mod_time()
    return move
end

function send_restart()
    local file = io.open(filename, "w")
    io.output(file)
    io.write("exit")
    io.close(file)
end

init()
emu.pause()
while(true) 
do
    lives = memory.readbyte(LIVES)
    if(lives == 0) then
        send_restart()
        emu.softreset()
        emu.unpause()
        init()
        emu.pause()
    end
    send_status()
    move = receive_move()
    setbuttons(move)
    emu.unpause()
    emu.frameadvance()
    emu.pause()
end

