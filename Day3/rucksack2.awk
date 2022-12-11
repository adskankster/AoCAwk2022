BEGIN { 
	priority="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

	total = 0 
	rucksack = 1
}

/^.+$/ { 
	
	rucksacks[rucksack++] = $0
	
	if (rucksack > 3) {
		
		rucksack = 1
	
		for (i = 1; i <= length(rucksacks[1]); i++) {
		
			item = substr(rucksacks[1], i, 1)
		
			if ((index(rucksacks[2], item) > 0) && 
				(index(rucksacks[3], item) > 0)) {
			
				total += index(priority, item)
				break
			}
		}
	}
}


END { printf("%s", total) }