BEGIN { 
	arrayIndex = 1
}

/^$/ { 
	printf("Elf %s = %s\n", arrayIndex, calories[arrayIndex])
	++arrayIndex 
}

/[0-9]./ { 
	calories[arrayIndex] += $0
	
}

END { 
	elf1 = 0
	highCalories1 = 0

	elf2 = 0
	highCalories2 = 0
	
	elf3 = 0
	highCalories3 = 0
	
	asort(calories, scalories)
	
	l = length(scalories)
		
	printf("%s = %s\n", l, scalories[l])
	printf("%s = %s\n", l-1, scalories[l-1])
	printf("%s = %s\n", l-2, scalories[l-2])
	print scalories[l] + scalories[l-1] + scalories[l-2]
}