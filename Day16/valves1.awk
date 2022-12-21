BEGIN {

}

/^Valve/ {
	rate = gensub("rate=", "", "1", $5)
	valve[$2][0] = substr(rate, 1, length(rate) - 1)
	
	valveRate[0] = ""
	if (rate in valveRate) {
		valveRate[rate][length(valveRate[rate])+1] = $2
	}
	else {
		valveRate[rate][1] = $2
	}
	
	for (v = 10; v <=NF; v++) {
		valve[$2][v-9] = gensub(",", "", "g", $v)
	}
}

END {
	#for (s in valve) {
	#	print s " " valve[s][0] " - "  valve[s][1] ", " valve[s][2] ", " valve[s][3]
	#}
	
	n = asorti(valveRate, valveRateS, "@ind_num_desc")
	
	# valve - Name -> rate, valve+1...valve+n
	# valveRate - rate -> Name
	# valveRateS - i -> rate: sorted desc.
	
	
	
	flow = 0
	for (m = 1; m <= 30; m++) {
		
	}
}

function getHighest(current) {
	for (v in 
}