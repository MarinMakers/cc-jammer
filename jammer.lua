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
		_,poldy = p.getCursorPos()
		p.setCursorPos(1,(poldy))
		p.write("Channel "..tostring(i))
		m.transmit(i,i,"-Static-")
	end
end

for i=1,#sides do
	if (peripheral.getType(sides[i]) == "modem" and peripheral.call(sides[i], 'isWireless')) then
		modem = peripheral.wrap(sides[i])
		break
	end
end


if (modem) then
	term.write("Jamming open channels...")
	enter(term)
	while true do
		signalJam(modem,term)
		sleep(0.5)
	end
else
	term.write("No wireless modem found... Exiting.")
end
