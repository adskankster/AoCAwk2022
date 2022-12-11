BEGIN { 
	arrayIndex = 1
}

/^$/ { 
	++arrayIndex 
}

/[0-9]./ { 
	calories[arrayIndex] += $0
}

END { 
	asort(calories, scalories)
	l = length(scalories)
	print scalories[l] + scalories[l-1] + scalories[l-2]
}