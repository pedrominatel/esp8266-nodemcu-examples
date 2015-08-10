pwm.setup(1,1000,512)
pwm.start(1)

a = 0

function blink()
    if lighton==0 then
        lighton=1
        gpio.write(2,gpio.LOW)
    else
        lighton=0
        gpio.write(2,gpio.HIGH)
    end
end

function fade()
    if(a > 512) then
        a = 0
    else
        a = a + 1
    end
    pwm.setduty(1,a)
    a = a + 1
end

tmr.alarm(0,5, 1, function() fade() end )
