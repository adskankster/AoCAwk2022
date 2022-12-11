BEGIN { 
	FS=","
	total1 = 0 
    total2 = 0
}

/^.+$/ { 
	
	split($1, elf1, "-")
	split($2, elf2, "-")
	
    # Part 1
	if ((elf1[1] >= elf2[1] && elf1[2] <= elf2[2]) ||
		(elf2[1] >= elf1[1] && elf2[2] <= elf1[2])) total1 +=1

    #Part2
    if ((elf1[2] >= elf2[1] && elf1[1] <= elf2[2]) ||
		(elf1[1] <= elf2[2] && elf1[2] >= elf2[1])) total2 +=1
}

END { printf("%i / %i", total1, total2) }