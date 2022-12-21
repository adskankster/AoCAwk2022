BEGIN {
	FS = "\n"; RS = ""
}

/^.+/ { 
	for (l = 1; l <= NF; l++) {
		list[l]["value"] = $l
		list[l]["next"] = l+1
		list[l]["last"] = l-1
	}
}

END {
	for (l = 1; l <= 7; l++) {
		newNext = list[l]["next"] + list[l]["value"]
		print "newNext " newNext
		if (newNext > length(list)) newNext = length(list) - newNext
		if (newNext < 1) newNext = length(list) + newNext
		print "adj newNext " newNext
		
		newLast = list[l]["last"] + list[l]["value"]
		print "newLast " newLast
		if (newLast > length(list)) newLast = length(list) - newLast
		if (newLast < 1) newLast = length(list) + newLast
		print "adj newLast " newLast
		
		list[l]["next"] = newNext
		list[l]["last"] = newLast
		
		print "last, next "  list[l]["last"], list[l]["next"]
		list[list[l]["last"]]["next"] = l+list[l]["value"]
		list[list[l]["next"]]["last"] = l+list[l]["value"]
		print "last, next "  list[l]["last"], list[l]["next"]
	}
	
	for (l = 1; l <= 7; l++) {
		printf("list[%i] = %i:%i %i\r\n", l, list[list[l]["next"]]["last"], list[list[l]["next"]]["last"], list[l]["value"])
	}
}