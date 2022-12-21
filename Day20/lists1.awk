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
		
		if (list[l]["value"] == 0) continue
		
		if (list[l]["value"] > 0)
		{
			new = list[l]["new"] + list[l]["value"]
			
			updated = 0
			for (n = 1; n <= length(list); n++) {
				if (list[n]["new"] > l&& list[n] <= new) 
				{
					list[n]["new"]--
					if (++updated) == new) break
					
				}
			}
		} else {
		
		}
	
		
		if (new < 1) new = length(list) + new
		if (new > l) new = 1 + length(list) - l
		list[l]["new"] = new
	}
	
	for (l = 1; l <= length(list); l++) {
		printf("list[%i] -> list[%i]: %i\r\n", list[l]["old"], list[l]["new"], list[l]["value"])
	}
}