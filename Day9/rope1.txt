BEGIN {
	grid["0,0"] = 1
	
	head["x"] = 0
	head["y"] = 0
	
	tail["x"] = 0
	tail["y"] = 0
}

/^U/ {

	for (u = 1; u <= $2; u++) {
		if (++head["y"] - tail["y"] > 1) {
			tail["y"]++
			tail["x"]  = head["x"]
		}
		
		markGrid()
	}
}

/^R/ {

	for (r = 1; r <= $2; r++) {
		if (++head["x"] - tail["x"] > 1) {
			tail["x"]++
			tail["y"] = head["y"]
		}
			
		markGrid()
	}
}

/^L/ {

	for (l = 1; l <= $2; l++) {
		if (tail["x"] - --head["x"] > 1) {
			tail["x"]--
			tail["y"]  = head["y"]
		}
		
		markGrid()
	}
}

/^D/ {

	for (d = 1; d <= $2; d++) {
		if (tail["y"] - --head["y"] > 1) {
			tail["y"]--
			tail["x"] = head["x"]
		}
		#print head["x"] head["y"] " - " tail["x"] tail["y"]
		
		markGrid()
	}
}


END {
	print length(grid)
}

function markGrid() {
	gridRef = sprintf("%i,%i", tail["x"], tail["y"])
	grid[gridRef] = 1
}
