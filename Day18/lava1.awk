BEGIN {
	FS = ","
}

/^.+/ {
	lava[NR]["x"] = $1
	lava[NR]["y"] = $2
	lava[NR]["z"] = $3
}

END {
	total = 0; covered = 0
	for (l in lava) {
	for (l in lava) {
		total += 6
		
		for(o in lava) {
			if (o == l) continue
			#if (abs(lava[o]["x"] - lava[l]["x"] > 1)) continue
			#if (abs(lava[o]["y"] - lava[l]["y"] > 1)) continue
			#if (abs(lava[o]["z"] - lava[l]["z"] > 1)) continue
			
			covered += checkCovered(lava[l], lava[o])
		}
	}
	
	printf ("%i - %i = %i", total, covered, (total - covered))
}

function checkCovered(b, o) {
	x = checkFace(b["x"], o["x"], b["y"], o["y"], b["z"], o["z"])
	if (x > 0) return x
	
	x = checkFace(b["x"], o["x"], b["z"], o["z"], b["y"], o["y"])
	if (x > 0) return x
	
	x = checkFace(b["y"], o["y"], b["z"], o["z"], b["x"], o["x"])
	if (x > 0) return x
	
	#printf("%i,%i,%i vs %i,%i,%i = %i\r\n", b["x"], b["y"], b["z"], o["x"], o["y"], o["z"], x)
	
	return 0
}

function checkFace(x1, x2, y1, y2, d1, d2) {
	if (x1 == x2 && y1 == y2) {
		if (abs(d1 - d2) == 1) return 1
	}
	return 0
}

function abs(value) {
	if (value < 0) return value * -1
	return value
}