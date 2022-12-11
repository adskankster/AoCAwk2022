BEGIN {
	cycle[1] = 1
	total = 0
}

/^noop/ { 
	l = length(cycle)
	print l "=" cycle[l]
	cycle[l + 1] = cycle[l] 
}

/^addx/ {
	l = length(cycle)
	print l " = " cycle[l]
	cycle[l + 1] = cycle[l]
	cycle[l + 2] = cycle[l] + strtonum($2)
	#cycle[l + 3] = cycle[l]
}

END {
	print cycle[20]
	total += 20 * cycle[20]
	print cycle[60]
	total += 60 * cycle[60]
	print cycle[100]
	total += 100 * cycle[100]
	print cycle[140]
	total += 140 * cycle[140]
	print cycle[180]
	total += 180 * cycle[180]
	print cycle[220]
	total += 220 * cycle[220]
	
	print total
}