srv=net.createServer(net.TCP)
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
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>Vermelho <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."<p>Verde <a href=\"?pin=ON2\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF2\"><button>OFF</button></a></p>";
        buf = buf.."<p>Azul <a href=\"?pin=ON3\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF3\"><button>OFF</button></a></p>";
        buf = buf.."<br><br>";
        buf = buf.."<h2>Pedro Minatel</h2>";
        local _on,_off = "",""
        if(_GET.pin == "ON1")then
              print("ON1")
        elseif(_GET.pin == "OFF1")then
              print("OFF1")
        elseif(_GET.pin == "ON2")then
              print("ON2")
        elseif(_GET.pin == "OFF2")then
              print("OFF2")
        elseif(_GET.pin == "ON3")then
              print("ON3")
        elseif(_GET.pin == "OFF3")then
              print("OFF3")
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
