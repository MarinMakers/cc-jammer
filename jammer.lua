-- jammer

term.clear()
term.setCursorPos(1,1)

sides = {'front','back','left','right','top','bottom'}

function enter(p) 
	oldx, oldy = p.getCursorPos()
	p.setCursorPos(1,(oldy+1))
end

function signalJam(m,p)
	for i=1,65535 do
		p.clearLine()
		p.write("Channel "..tostring(i))
		m.open(i)
		m.transmit(i,i,"-Static-")
		m.close(i)
	end
end

for i=1,#sides do
	if (peripheral.getType(sides[i]) == "modem" and peripheral.call(sides[i], 'isWireless')) then
		modem = peripheral.wrap(sides[i])
		break
	end
end


if (modem) then
	term.write("Scanning 1- for open frequencies...")
	enter(term)
	while true do
		signalJam(modem,term)
		sleep(10)
	end
else
	term.write("No wireless modem found... Exiting.")
end
