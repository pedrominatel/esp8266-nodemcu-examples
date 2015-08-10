pin1=1
pin2=2
pin7=7
gpio.mode(pin1,gpio.OUTPUT)
gpio.mode(pin2,gpio.OUTPUT)
gpio.write(pin1,gpio.LOW)
gpio.write(pin2,gpio.LOW)
gpio.mode(pin7,gpio.INPUT)

function read_push()
    if (gpio.read(pin7) == gpio.HIGH) then
        gpio.write(pin1,gpio.HIGH)
    else
        gpio.write(pin1,gpio.LOW)
    end
end

srv=net.createServer(net.TCP, 10)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end

        local _on,_off = "",""
        if(_GET.pin == "ON1")then
              gpio.write(pin1,1)
              buf = "command_ok"
        elseif(_GET.pin == "OFF1")then
              gpio.write(pin1,0)
              buf = "command_ok"
        elseif(_GET.pin == "ON2")then
              gpio.write(pin2,1)
              buf = "command_ok"
        elseif(_GET.pin == "OFF2")then
              gpio.write(pin2,0)
              buf = "command_ok"
        else
            buf = "command_error"
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)

tmr.alarm(0,10,1, function() read_push() end)