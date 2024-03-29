BEGIN {
	FS = ","
	minX = 1000; maxX = 0
	minY = 1000; maxY = 0
	minZ = 1000; maxZ = 0
	il = 0; ig = 0
}

/^.+/ {
	lava[$1][$2][$3] = "#"
	il++
	
	if ($1 > maxX) maxX = $1
	if ($2 > maxY) maxY = $2
	if ($3 > maxZ) maxZ = $3
	
	if ($1 < minX) minX = $1
	if ($2 < minY) minY = $2
	if ($3 < minZ) minZ = $3
}

END {
	area = 4314; 
	print "dim " maxX-minX " " maxY-minY " " maxZ-minZ 
	
	for (x = minX+1; x < maxX; x++) {
		for (y = minY+1; y < maxY; y++) {
			isInt = 0
			first = 0
			last = 0
			for (z = minZ; z <= maxZ; z++) {
				if (isInt == 0 && lava[x][y][z] == "#") {
					isInt = 1 
					continue
				}
				if (isInt == 1 && first == 0 && lava[x][y][z] != "#") {
					first = z
					continue
				}
				if (isInt == 1 && first > 0 &&lava[x][y][z] == "#") {
					last = z
					break;
				}
			}
			
			if (last > 0) {
				for (z = first; z < last; z++) {
					if (lava[x][y][z] != "#") {
						gap[++ig]["x"] = x
						gap[ig]["y"] = y
						gap[ig]["z"] = z
					}
				}
			}
		}
	}
	print il " - " ig
	
	total = 0; covered = 0
	for (l in gap) {
		total += 6
		for(o in gap) {
			if (o == l) continue
			#if (abs(gap[o]["x"] - gap[l]["x"] > 1)) continue
			#if (abs(gap[o]["y"] - gap[l]["y"] > 1)) continue
			#if (abs(gap[o]["z"] - gap[l]["z"] > 1)) continue
			
			covered += checkCovered(gap[l], gap[o])
		}
	}
	
	internal = (total - covered)
	printf ("%i - %i = %i \n", total, covered, internal)
	printf ("%i - %i = %i \n", area, internal, (area - internal))
	
}

function checkCovered(b, o) {
	x = checkFace(b["x"], o["x"], b["y"], o["y"], b["z"], o["z"])
	if (x > 0) return x
	
	x = checkFace(b["x"], o["x"], b["z"], o["z"], b["y"], o["y"])
	if (x > 0) return x
	
	x = checkFace(b["y"], o["y"], b["z"], o["z"], b["x"], o["x"])
	if (x > 0) return x
	
	#printf("%i,%i,%i vs %i,%i,%i = %i\n", b["x"], b["y"], b["z"], o["x"], o["y"], o["z"], x)
	
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
