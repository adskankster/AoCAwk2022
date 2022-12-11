BEGIN { 
	priority="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	total = 0 
}

/^.+$/ { 
	
	c1 = length($0) / 2

	for (i = 1; i <= c1; i++) {
		item = substr($0, i, 1)
		
		if (index(substr($0, c1+1), item) > 0) {
			total += index(priority, item)
			break
		}
	}
}


END { printf("%s", total) }