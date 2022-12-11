BEGIN {
	for (l = 1; l <= 6; l++) {
		for (p = 0; p <40; p++) {
			screen[l, p] = "."
		}
	}
	
	cycle = 0
	x = 1
}

/^noop/ { 
	tick()
}

/^addx/ {
	tick(); tick();
	x += strtonum($2)
}

END {
	for (l = 1; l <= 6; l++) {
		for (p = 0; p <40; p++) {
			printf("%s", screen[l, p])
		}
		printf("\r\n")
	}
}

function tick() {
	if (++cycle > 240) cycle = 1
	
	drawToScreen()
	return cycle
}

function getLine() {
	return int(cycle / 40 ) + 1
}

function getLinePixel() {
	return ((cycle % 40) - 1)
}

function drawToScreen() {
	curLine = getLine()
	curPixel = getLinePixel()
	
	if (x-1 <= curPixel && curPixel	<= x+1) {
			screen[curLine, curPixel] = "#"
		}
}