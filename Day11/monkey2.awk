BEGIN {

}

/^Monkey/ {
	curMonkey = substr($2, 1, length($2) - 1)
}

/^\s*Starting/ {
	for (i = 3; i < NF; i++) {
			monkeys[curMonkey][i+2] = substr($i, 1, length($i) - 1)
	}
	monkeys[curMonkey][NF+2] = $NF
}

/^\s*Operation/ {
	monkeys[curMonkey][1] = $5 "," $6
}

/^\s*Test/ {
	monkeys[curMonkey][2] = $NF
}

/^\s*If true/ {
	monkeys[curMonkey][3] = $NF
}

/^\s*If false/ {
	monkeys[curMonkey][4] = $NF
}


END {
	for (round = 1; round <= 20; round++) {
		#printf("Round %i\r\n", round)
		for (m = 0; m < length(monkeys); m++) {
			#printf("\tMonkey %i\r\n", m)
			for (i = 5; i <= length(monkeys[m]); i++) {
				#printf("\t\t%i\r\n", monkeys[m][i])
				n = split(monkeys[m][1], f, ",")
				if (f[2] == "old") {
					factor = monkeys[m][i]
				} else {
					factor = strtonum(f[2])
				}
				#printf("\t\t factor (%s,%s) =%i ", f[1], f[2], factor)
				
				if (f[1] == "+") {
					new = monkeys[m][i] + factor
				} else {
					new = monkeys[m][i] * factor
				}
				#new -= 1 #int(new / 3)
				#printf("   new=%i ", new)
				
				if (new % monkeys[m][2] == 0) {
					newMonkey = monkeys[m][3]
				} else {
					newMonkey = monkeys[m][4]
				}
				#printf("   newMonkey=%i\r\n", newMonkey)
				
				monkeys[newMonkey][length(monkeys[newMonkey]) + 1] = new - round

				monkeyTotals[m]++
			}
			
			#printf("\r\n")
			
			for (i = length(monkeys[m]); i >= 5; i--) {
				delete monkeys[m][i]
			}
		}
	}
	
	for (monkeyTotal in monkeyTotals) {
		printf("Monkey %i inspected items %i times\r\n", monkeyTotal, monkeyTotals[monkeyTotal])
	}
	
	asort (monkeyTotals, totals)
	print totals[length(totals)] * totals[length(totals) - 1]
}