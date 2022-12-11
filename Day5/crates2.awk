BEGIN {
	FS = " {1,4}"
}

/^ *\[/ {

	for (i = 1; i <= NF; i++) {
		tmpStacks[i][length(tmpStacks[i])+1] = $i
	}
}

/^$/ {
	FS = " "
	
	for (s = 1; s <= length(tmpStacks); s++) {
		for (c = length(tmpStacks[s]); c > 0; c--) {
			if (tmpStacks[s][c] != "") {
				stacks[s][length(stacks[s]) + 1] = tmpStacks[s][c]
			}
		}
	}
}

/^move/ {
	l0 = length(stacks[$4])
	for (i = 1; i <= $2; i++) {
		l1 = l0 - int($2) + i
		l2 = length(stacks[$6])

		stacks[$6][l2 + 1] = stacks[$4][l1]
		delete stacks[$4][l1]
	}
}

END {
	for (s = 1; s <= length(stacks); s++) {
		for (c = 1; c <= length(stacks[s]); c++) {
			printf("%s", stacks[s][c])
		}
		print ""
	}
}