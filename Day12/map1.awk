BEGIN {
	FS = "\n"; RS = ""
	heightMap = "abcdefghijklmnopqrstuvwxyz"
	
	TRUE = 1
	FALSE = 0
}

/.+/ {
	maxRow = NF
	maxCol = length($1)

	for (y = 1; y <= maxRow; y++) {
		for (x = 1; x <= maxCol; x++) {
			value = substr($y, x, 1)
			
			if (value == "S") {
				startPoint = setRef(x, y)
				value = "a"
			}
			if (value == "E") {
				destination = setRef(x, y)
				value = "z"
			}
			
			map[x][y][1] = index(heightMap, value)
			map[x][y][2] = ""
			map[x][y][3] = -1
			map[x][y][4] = FALSE
			map[x][y][5] = setRef(x,y)
			map[x][y][6] = 0
		}
	}
	printf("loaded map (%ix%i).", maxCol, maxRow)
	
	printf("Start %s, End %s\r\n", startPoint, destination)
}

END {
	markMap()
	
	foundDest = FALSE
	
	clPointer = 1
	checkList[clPointer] = startPoint
	
	while (clPointer <= length(checkList)) {
		#printf ("checkPoint %i / %i", clPointer, length(checkList))
		
		split(checkList[clPointer++], ref, ",")
		
		checkNorth(ref[1], ref[2], map[ref[1]][ref[2]][4])
		checkEast(ref[1], ref[2], map[ref[1]][ref[2]][4])
		checkSouth(ref[1], ref[2], map[ref[1]][ref[2]][4])
		checkWest(ref[1], ref[2], map[ref[1]][ref[2]][4])
		
		map[ref[1]][ref[2]][4] = TRUE
	}
}

function tracePath() {
	print "tracing"
	steps = 0

	split(destination, destRef, ",")
	curX = destRef[1]; curY = destRef[2]
	
	while (isStartPoint(curX, curY) != TRUE) {
		steps++
		split(map[curX][curY][5], curRef, ",")
		curX = curRef[1]; curY = curRef[2]
	}
	
	print "Total Steps = " steps
}

function markMap() {

	printf("marking map..")
	
	for (y = 1; y <= maxRow; y++) {
		for (x = 1; x <= maxCol; x++) {
			if (canMove(x, y, x, y+1) == TRUE) map[x][y][2] = sprintf("N%s", map[x][y][2])
			if (canMove(x, y, x+1, y) == TRUE) map[x][y][2] = sprintf("E%s", map[x][y][2])
			if (canMove(x, y, x, y-1) == TRUE) map[x][y][2] = sprintf("S%s", map[x][y][2])
			if (canMove(x, y, x-1, y) == TRUE) map[x][y][2] = sprintf("W%s", map[x][y][2])
		}
	}
	print ".marked"
}

function checkNorth(x, y, g) {
	if (index(map[x][y][2], "N") > 0) {
		if (checkPoint(x, y+1, g) == TRUE) {
			map[x][y+1][5] = setRef(x, y)
			if (foundDest == TRUE) {
				tracePath()
				exit
			}
		}
	}
}

function checkEast(x, y, g) {
	if (index(map[x][y][2], "E") > 0) {
		if (checkPoint(x+1, y, g) == TRUE) {
			map[x+1][y][5] = setRef(x, y)
			if (foundDest == TRUE) {
				tracePath()
				exit
			}
		}
	}
}

function checkSouth(x, y, g) {
	if (index(map[x][y][2], "S") > 0) {
		if (checkPoint(x, y-1, g) == TRUE) {
			map[x][y-1][5] = setRef(x, y)
			if (foundDest == TRUE) {
				tracePath()
				exit
			}
		}
	}
}

function checkWest(x, y, g) {
	if (index(map[x][y][2], "W") > 0) {
		if (checkPoint(x-1, y) == TRUE) {
			map[x-1][y][5] = setRef(x, y)
			if (foundDest == TRUE) {
				tracePath()
				exit
			}
		}
	}
}

function checkPoint(x, y, g) {
	if (map[x][y][4] == TRUE) return FALSE

	if (isDestination(x, y) == TRUE) {
		print "FOUND DESTINATION"
		foundDest = TRUE
	}

	newF = (g + 1) + calcH(x, y)

	#printf("checkDecision(%i, %i) %i - %i\r\n", x, y, map[x][y][3], newF)

	if (map[x][y][3] < 0) {
		map[x][y][3] = newF
		map[x][y][6] = g + 1
		checkList[length(checkList) + 1] = setRef(x, y)
		return TRUE
	} else {
		if (map[x][y][3] > newF) {
			map[x][y][3] = newF
			map[x][y][6] = g + 1
			return TRUE
		}
	}
	return FALSE
}

function isDestination(x, y) {
	split(destination, destRef, ",")
	if (destRef[1] == x && destRef[2] == y) {
		return TRUE
	} else {
		return FALSE
	}
}

function isStartPoint(x, y) {
	split(startPoint, startRef, ",")
	if (startRef[1] == x && startRef[2] == y) {
		return TRUE
	} else {
		return FALSE
	}
}

function canMove(sx, sy, dx, dy) {
	if (!isValid(dx, dy)) return FALSE
	if (map[dx][dy][1] - map[sx][sy][1] > 1) return FALSE
	return TRUE
}

function isValid(x, y) {
	if ((x > 0 && x <= maxCol) && 
	   (y > 0 && y <= maxRow)) return TRUE
	return FALSE
}

function calcH(x, y) {
	split(destination, destRef, ",")
	return getDistance(x, y, destRef[1], destRef[2])
}

function getDistance(sx, sy, dx, dy) {
	dx = abs(sx - dx)
	dy = abs(sy - dy)
	return dx + dy
}

function setRef(x, y) {
	return sprintf("%i,%i", x, y)
}

function abs(value) {
	if (value < 0) return value * -1
	return value
}
