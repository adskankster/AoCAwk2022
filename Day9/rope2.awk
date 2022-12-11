BEGIN {
	grid["0,0"] = 1

	for (p = 0; p < 10; p++) {
		points[p]["x"] = 0
		points[p]["y"] = 0
	}
}

/^U/ {

	for (u = 1; u <= $2; u++) {
		points[0]["y"]++
		for (u2 = 0; u2 < 9; u2++) {
			if (points[u2]["x"] > points[u2+1]["x"]) npmR(u2, u2 + 1)
			if (points[u2]["y"] > points[u2+1]["y"]) npmU(u2, u2 + 1)
			if (points[u2]["x"] < points[u2+1]["x"]) npmL(u2, u2 + 1)
			if (points[u2]["y"] < points[u2+1]["y"]) npmD(u2, u2 + 1)
		}
		
		markGrid()
	}
}

/^R/ {

	for (r = 1; r <= $2; r++) {
		points[0]["x"]++
		for (u2 = 0; u2 < 9; u2++) {
			if (points[u2]["x"] > points[u2+1]["x"]) npmR(u2, u2 + 1)
			if (points[u2]["y"] > points[u2+1]["y"]) npmU(u2, u2 + 1)
			if (points[u2]["x"] < points[u2+1]["x"]) npmL(u2, u2 + 1)
			if (points[u2]["y"] < points[u2+1]["y"]) npmD(u2, u2 + 1)
		}

		markGrid()
	}
}

/^L/ {

	for (l = 1; l <= $2; l++) {
		points[0]["x"]--
		for (u2 = 0; u2 < 9; u2++) {
			if (points[u2]["x"] > points[u2+1]["x"]) npmR(u2, u2 + 1)
			if (points[u2]["y"] > points[u2+1]["y"]) npmU(u2, u2 + 1)
			if (points[u2]["x"] < points[u2+1]["x"]) npmL(u2, u2 + 1)
			if (points[u2]["y"] < points[u2+1]["y"]) npmD(u2, u2 + 1)
		}

		markGrid()
	}
}

/^D/ {

	for (d = 1; d <= $2; d++) {
		points[0]["y"]--
		for (u2 = 0; u2 < 9; u2++) {
			if (points[u2]["x"] > points[u2+1]["x"]) npmR(u2, u2 + 1)
			if (points[u2]["y"] > points[u2+1]["y"]) npmU(u2, u2 + 1)
			if (points[u2]["x"] < points[u2+1]["x"]) npmL(u2, u2 + 1)
			if (points[u2]["y"] < points[u2+1]["y"]) npmD(u2, u2 + 1)
		}
		
		markGrid()
	}
}


END {
	print length(grid)
}

function npmU(point, nextPoint) {
	if (points[point]["y"] - points[nextPoint]["y"] > 1) {
		points[nextPoint]["y"]++
		
		if (points[nextPoint]["x"] == points[point]["x"]) return
		if (points[nextPoint]["x"] > points[point]["x"]) {
			points[nextPoint]["x"]--
		} else {
			points[nextPoint]["x"]++
		}
	}
}

function npmD(point, nextPoint) {
	if (points[nextPoint]["y"] - points[point]["y"] > 1) {
		points[nextPoint]["y"]--
		
		if (points[nextPoint]["x"] == points[point]["x"]) return
		if (points[nextPoint]["x"] > points[point]["x"]) {
			points[nextPoint]["x"]--
		} else {
			points[nextPoint]["x"]++
		}
	}
}

function npmR(point, nextPoint) {
	if (points[point]["x"] - points[nextPoint]["x"] > 1) {
		points[nextPoint]["x"]++
		
		if (points[nextPoint]["y"] == points[point]["y"]) return
		if (points[nextPoint]["y"] > points[point]["y"]) {
			points[nextPoint]["y"]--
		} else {
			points[nextPoint]["y"]++
		}
	}
}

function npmL(point, nextPoint) {
	if (points[nextPoint]["x"] - points[point]["x"] > 1) {
		points[nextPoint]["x"]--
		
		if (points[nextPoint]["y"] == points[point]["y"]) return
		if (points[nextPoint]["y"] > points[point]["y"]) {
			points[nextPoint]["y"]--
		} else {
			points[nextPoint]["y"]++
		}
	}
}

function markGrid() {
	gridRef = sprintf("%i,%i", points[9]["x"], points[9]["y"])
	grid[gridRef] = 1
}
