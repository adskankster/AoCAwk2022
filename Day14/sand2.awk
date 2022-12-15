BEGIN {
	FS = " -> "
	# set-up the grid
	minX = 0; maxX = 1000
	minY = 0; maxY = 9
	for (x = minX; x <= maxX; x++) {
		for (y = minY; y <= maxY; y++) {
			cave[x][y] = " "
		}
	}
}

/^.+/ {
	#loop through $1 - $NF and put # in each grid spot that joins them
	for (r = 1; r < NF; r++) {
	
		split($r, start, ",")
		split($(r+1), end, ",")

		if (start[2] > maxY) maxY = start[2]
		if (end[2] > maxY) maxY = end[2]

		if (start[1] != end[1]) {
			y = start[2]
			if (start[1] < end[1]) {
				for (x = start[1]; x <= end[1]; x++) {
					cave[x][y] = "#"
				}
			} else {
				for (x = start[1]; x >= end[1]; x--) {
					cave[x][y] = "#"
				}
			}
		} else {
			x = start[1]
			if (start[2] < end[2]) {
				for (y = start[2]; y <= end[2]; y++) {
					cave[x][y] = "#"
				}
			} else {
				for (y = start[2]; y >= end[2]; y--) {
					cave[x][y] = "#"
				}
			}
		}
	}
}

END {
	maxY += 2
	
	for (g = minX; g <= maxX; g++) {
		cave[g][maxY] = "#"
	}

	#for (y = minY; y <= maxY; y++) {
	#	for (x = minX; x <= maxX; x++) {
	#		printf("%s", cave[x][y])
	#	}
	#	print ""
	#}
	
	sandy = minY; startX = 500; sandx = startX
	grains = 0
	
	while (cave[startX][minY] != "o") {	
		if (sandy > maxY) break

		if (checkSpace(sandx, sandy+1) == 1) {
			if (checkSpace(sandx-1, sandy+1) == 1) {
				if (checkSpace(sandx+1, sandy+1) == 1) {
					cave[sandx][sandy] = "o"
					sandx = startX
					sandy = minY
					grains++
				} else {
					sandx++
					sandy++
				}
			} else {
				sandx--
				sandy++
			}
		} else {
			sandx
			sandy++
		}
	}
	
	print "NoOfGrains = " grains
}

function checkSpace(sx, sy) {
	#print sx "," sy " = " cave[sx][sy]
	if (cave[sx][sy] == "#" ||
		cave[sx][sy] == "o") {
		return 1
	}
	return 0
}