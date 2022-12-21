BEGIN {
	FS = "\n"; RS = ""
}

/^.+/ { 
	for (l = 1; l <= NF; l++) {
		list[l]["value"] = $l
		list[l]["new"] = l
	}
}

END {
	for (l = 1; l <= length(list); l++) {
	
		print ""
		print "*** process " l
		
		if (list[l]["value"] == 0) continue
		
		if (list[l]["value"] > 0)
		{
			new = list[l]["new"] + list[l]["value"]
			
			while (new > length(list)) {
				new = length(list) - new
			}

			print list[l]["value"] ": " l "- " new 

			for (n = 1; n <= length(list); n++) {
				
				if (n == l) continue
				
				if (list[n]["new"] >= l && list[n]["new"] <= new) 
				{
					list[n]["new"]--
				}
				print list[n]["value"] ": " n "- " list[n]["new"] 
			}

		} else {
		
			new = list[l]["new"] + list[l]["value"]
			
			while (new < 1) {
				new = length(list) + new - 1
			}
			
			print list[l]["value"] ": " l "- " new 

			for (n = 1; n <= length(list); n++) {
				
				if (n == l) continue
			
				if (list[n]["new"] <= l && list[n]["new"] >= new) 
				{
					list[n]["new"]++
				}
				print list[n]["value"] ": " n "- " list[n]["new"]
			}
		}
		
		list[l]["new"] = new
	}
	
	for (l = 1; l <= length(list); l++) {
		printf("list[%i] -> list[%i]: %i\r\n", l, list[l]["new"], list[l]["value"])
	}
}