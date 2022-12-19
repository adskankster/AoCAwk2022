BEGIN {
	minX = 0; maxX = 10; minY = -2; maxY = 10
}

/^Sensor/ {
	sensor[NR]["x"] = strtonum(substr($3, 3, length($3) - 3))
	sensor[NR]["y"] = strtonum(substr($4, 3, length($4) - 3))
	nearbe[NR]["x"] = strtonum(substr($9, 3, length($9) - 3))
	nearbe[NR]["y"] = strtonum(substr($10, 3, length($10) - 2))

	if (sensor[NR]["x"] > maxX) { maxX = sensor[NR]["x"] }
	if (sensor[NR]["y"] > maxY) { maxY = sensor[NR]["y"] }
	if (nearbe[NR]["x"] > maxX) { maxX = nearbe[NR]["x"] }
	if (nearbe[NR]["y"] > maxY) { maxY = nearbe[NR]["y"] }
	
	if (sensor[NR]["x"] < minX) { minX = sensor[NR]["x"] }
	if (sensor[NR]["y"] < minY) { minY = sensor[NR]["y"] }
	if (nearbe[NR]["x"] < minX) { minX = nearbe[NR]["x"] }
	if (nearbe[NR]["y"] < minY) { minY = nearbe[NR]["y"] }
}

END {
	print minX " " maxX " " minY " " maxY

	for (s = 1; s <= length(sensor); s++) {
		if ((sensor[s]["y"] > maxY) || (sensor[s]["y"] < minY)) continue
		
		if (sensor[s]["y"] == rowNo) row[sensor[s]["x"]] = "S"
		if (nearbe[s]["y"] == rowNo) row[nearbe[s]["x"]] = "B"
		
		distance = getDistance(sensor[s]["x"], sensor[s]["y"], nearbe[s]["x"], nearbe[s]["y"])
		markRow(sensor[s]["x"], sensor[s]["y"], distance)
	}

	empty = 0
	for (c in row) {
		if (row[c] == "#") empty++
	}
	
	print empty
}

function markRow(x, y, d) {
	
	dx = 0
	for (dy = y - d; dy <= y + d; dy++) {

		if (dy == y) dx = d
		
		if (dy == rowNo) {
			for (ax = x - dx; ax <= x + dx; ax++) {
				if (row[ax] != "S" && 
					row[ax] != "B") row[ax] = "#"
			}
		}
		
		if (dy < y) {
			dx++
		} else {
			dx--
		}
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