BEGIN {
	colmin = 1; colmax = 7
	
	for (c = colmin; c <= colmax; c++) {
		column[c][0] = 1
	}
}

/^.+/ {
	jets = $0
}

END {
	row = 0; jetNo = 1; rowBlock = 1
	
	for (rockNo = 1; rockNo <= 1000000000000; rockNo++) {
		createRock(rockNo, row + 4, rock) 
		
		do {
			jet = substr(jets, jetNo++, 1)
			if (jetNo > length(jets)) jetNo = 1
			
			if (jet == ">") {
				moveRockRight(rock)
			} else {
				moveRockLeft(rock)
			}
			
			tmpRow = moveRockDown(rock, row)
			
		} while (tmpRow == 0)
		
		if (row >= ((rowBlock * 1000) + 100)) {
			for (rb = (rowBlock -1) * 1000; rb < rowBlock * 1000; rb++) {
				for (rbx = colmin; rbx <= colmax; rbx++) {
					delete column[rbx][rb]
				}
			}
			rowBlock++
			if (rowBlock % 1000 == 0) print rockNo
		}

		row = tmpRow
		#if (rockNo % 1000000 == 0) {
		#	t = rockNo * 1.5
		#	print  rockNo ": " row " - " t " - " row - t
		#}
	}
	
	#for (y = row + 4; y >= 0; y--) {
	#	for (x = colmin; x <= colmax; x++) {
	#		if (column[x][y] != "#") column[x][y] = "."
	#		printf("%s", column[x][y])
	#	}
	#	print ""
	#}
	
	print row
}

function createRock(rockNo, rowNo, rock) {
	
	delete rock
		
	switch(rockNo % 5) {
		case 1: 
			rock[1]["x"] = 3
			rock[1]["y"] = rowNo
			rock[2]["x"] = 4
			rock[2]["y"] = rowNo
			rock[3]["x"] = 5
			rock[3]["y"] = rowNo
			rock[4]["x"] = 6
			rock[4]["y"] = rowNo
			break
			
		case 2:
			rock[1]["x"] = 4
			rock[1]["y"] = rowNo
			rock[2]["x"] = 3
			rock[2]["y"] = rowNo+1
			rock[3]["x"] = 4
			rock[3]["y"] = rowNo+1
			rock[4]["x"] = 5
			rock[4]["y"] = rowNo+1
			rock[5]["x"] = 4
			rock[5]["y"] = rowNo+2
			break
		case 3:
			rock[1]["x"] = 3
			rock[1]["y"] = rowNo
			rock[2]["x"] = 4
			rock[2]["y"] = rowNo
			rock[3]["x"] = 5
			rock[3]["y"] = rowNo
			rock[4]["x"] = 5
			rock[4]["y"] = rowNo+1
			rock[5]["x"] = 5
			rock[5]["y"] = rowNo+2
			break
		case 4:
			rock[1]["x"] = 3
			rock[1]["y"] = rowNo
			rock[2]["x"] = 3
			rock[2]["y"] = rowNo+1
			rock[3]["x"] = 3
			rock[3]["y"] = rowNo+2
			rock[4]["x"] = 3
			rock[4]["y"] = rowNo+3
			break
		case 0:
			rock[1]["x"] = 3
			rock[1]["y"] = rowNo
			rock[2]["x"] = 4
			rock[2]["y"] = rowNo
			rock[3]["x"] = 3
			rock[3]["y"] = rowNo+1
			rock[4]["x"] = 4
			rock[4]["y"] = rowNo+1
			break
	}
}

function moveRockLeft(rock) { 
	for (r = 1; r <= length(rock); r++) {
		if (rock[r]["x"] == colmin || 
			column[rock[r]["x"] - 1][rock[r]["y"]] == 1) return
	}
	for (r = 1; r <= length(rock); r++) {
		rock[r]["x"]--
	}
}

function moveRockRight(rock) {
	for (r = 1; r <= length(rock); r++) {
		if (rock[r]["x"] == colmax || 
			column[rock[r]["x"] + 1][rock[r]["y"]] == 1) return
	}
	for (r = 1; r <= length(rock); r++) {
		rock[r]["x"]++
	}
}

function moveRockDown(rock, row) {
	for (r = 1; r <= length(rock); r++) {

		if (column[rock[r]["x"]][rock[r]["y"] - 1] == 1) {
			newRowNo = row
			for (r2 in rock) {
				column[rock[r2]["x"]][rock[r2]["y"]] = 1
				if (rock[r2]["y"] > newRowNo) newRowNo = rock[r2]["y"]
			}
			
			return newRowNo
		}
	}
	
	for (r = 1; r <= length(rock); r++) {
		rock[r]["y"]--
	}
	
	return 0
}
