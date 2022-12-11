BEGIN { 
	FS=","
	total = 0 
}

/^.+$/ { 
	
	split($1, elf1, "-")
	split($2, elf2, "-")
	
	if ((elf1[2] >= elf2[1] && elf1[1] <= elf2[2]) ||
		(elf1[1] <= elf2[2] && elf1[2] >= elf2[1])) total +=1
}

END { printf("%i", total) }

