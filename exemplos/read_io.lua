gpio.mode(1,gpio.OUTPUT)
gpio.mode(7,gpio.INPUT)
gpio.write(1,gpio.LOW)

tmr.alarm(1,50,1, function() read_push() end)

function read_push()
    if (gpio.read(7) == 1) then
        gpio.write(1,gpio.HIGH)
    else
        gpio.write(1,gpio.LOW)
    end
end
