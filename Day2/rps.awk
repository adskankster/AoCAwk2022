BEGIN { 
	total = 0
}

/^A X$/ { total += 4 }

/^A Y$/ { total += 8 }

/^A Z$/ { total += 3 }

/^B X$/ { total += 1 }

/^B Y$/ { total += 5 }

/^B Z$/ { total += 9 }

/^C X$/ { total += 7 }

/^C Y$/ { total += 2 }

/^C Z$/ { total += 6 }

END { 
	
	printf("%s", total)
	
	#print scalories[l] + scalories[l-1] + scalories[l-2]
}