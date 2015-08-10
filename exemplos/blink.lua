pin=0
led_state=0

gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.LOW)

function blink()
    if led_state==0 then
        led_state=1
        gpio.write(pin,gpio.LOW)
    else
        led_state=0
        gpio.write(pin,gpio.HIGH)
    end
end

tmr.alarm(1,1000, 1, function() blink() end )
