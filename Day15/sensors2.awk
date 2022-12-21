BEGIN {
	minX = 0; maxX = 4361396; minY = 0; maxY = 3823030
}

/^Sensor/ {
	sensor[NR]["x"] = strtonum(substr($3, 3, length($3) - 3))
	sensor[NR]["y"] = strtonum(substr($4, 3, length($4) - 3))
	nearbe[NR]["x"] = strtonum(substr($9, 3, length($9) - 3))
	nearbe[NR]["y"] = strtonum(substr($10, 3, length($10) - 2))
	
	#if (sensor[NR]["x"] > maxX) { maxX = sensor[NR]["x"] }
	#if (sensor[NR]["y"] > maxY) { maxY = sensor[NR]["y"] }
	#if (nearbe[NR]["x"] > maxX) { maxX = nearbe[NR]["x"] }
	#if (nearbe[NR]["y"] > maxY) { maxY = nearbe[NR]["y"] }
	
	#if (sensor[NR]["x"] < minX) { minX = sensor[NR]["x"] }
	#if (sensor[NR]["y"] < minY) { minY = sensor[NR]["y"] }
	#if (nearbe[NR]["x"] < minX) { minX = nearbe[NR]["x"] }
	#if (nearbe[NR]["y"] < minY) { minY = nearbe[NR]["y"] }
}

END {
	print minX " " maxX " " minY " " maxY
	#for (cx = minX; cx <= maxX; cx++) {
	#	for (cy = minY; cy <= maxY; cy++) {
	#		cave[cx][cy] = ""
	#	}
	#}
	cave[0][0] = ""

	for (s = 1; s <= length(sensor); s++) {
		if ((sensor[s]["y"] > maxY) || (sensor[s]["y"] < minY)) continue

		distance = getDistance(sensor[s]["x"], sensor[s]["y"], nearbe[s]["x"], nearbe[s]["y"])
		markRow(sensor[s]["x"], sensor[s]["y"], distance)
		
		delete cave[sensor[s]["x"]][sensor[s]["y"]]
		delete cave[nearbe[s]["x"]][nearbe[s]["y"]]
	}

	delete sensor
	delete nearbe
	
	for (a in cave) {
		for (b in cave[a]) {
			print a "," b
		}
	}
	
	#for (cy = minY; cy <= maxY; cy++) {
	#	for (cx = minX; cx <= maxX; cx++) {
	#		printf("%s", cave[cx][cy])
	#	}
	#	print ""
	#}
	
	#for (ex = 0; ex <= 4000000; ex++) {
	#	for (ey = 0; ey <= 4000000; ey++) {
	#	
	#		if (cave[ex][ey] == " ")
	#			printf("%i,%i = %i\r\n", ex, ey, ((ex * 4000000) + ey))
	#			
	#	}
	#	delete cave[ex]
	#}
}

function markRow(x, y, d) {
	
	dx = 0
	for (dy = (y - d); dy <= (y + d); dy++) {
		if (dy < minY || dy > maxY) continue

		if (dy == y) dx = d
	
		for (ax = x - dx; ax <= x + dx; ax++) {
			if (dy in cave[ax] &&
				ax in cave) delete cave[ax][dy]
		}
	
		if (dy < y) {
			dx++
		} else {
			dx--
		}
		
# dd = (d - (y - dy))
#		for (dx = (x - dd); dx <= (x + dd); dx++) {
#			if (dx < minX || dx > maxX) continue
#	
#			if (cave[dx][dy] == "S" || 
#				cave[dx][dy] == "B") continue
#				
#			cave[dx][dy] = "#"
#		}
	}
}

function getDistance(sx, sy, ex, ey) {
	dx = abs(sx - ex)
	dy = abs(sy - ey)
	return dx + dy
}

function abs(value) {
	if (value < 0) return value * -1
	return value
}