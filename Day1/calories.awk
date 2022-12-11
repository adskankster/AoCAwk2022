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
	elf = 0
	highCalories = 0 
	for ( i = 1; i < arrayIndex; i++) {
		
		printf("Elf %s = %s\n", i, calories[i])
		
		if (highCalories < calories[i]) {
			highCalories = calories[i]
			elf = i
		}
	}
	
	printf("%s = %s", elf, highCalories)
}