BEGIN {
	FS = "\n"; RS = ""
	correctOrderSum = 0
	curPair = 1
	curItem = 1
}

/^.+/ {
	pairs[NR][1] = $1
	pairs[NR][2] = $1
}

END {
	for (curPair = 1; curPair <= length(pairs); curPair++) {
		print curPair
		itemToList(pairs[curPair][1], left)
		itemToList(pairs[curPair][2], right)
		
		PROCINFO["sorted_in"] = "@ind_str_asc"
		
		lsi = 1
		for(l in left) {
			sortedPairLeft[curPair][lsi++] = l
			print "left[" l "] = " left[l]
		}	

		rsi = 1
		for (r in right) {
			sortedPairRight[curPair][rsi++] = r
			print "right[" r "] = " right[r]
		}

		delete left
		delete right
		
		print correctOrderSum
	}
}


function itemToList(item, list) {
	
	subscr = 1
	delete list
	
	for (i = 2; i <= length(item); i++) {

		c = substr(item, i, 1)

		switch (c) {
			case "[":
				subscr = (subscr "," "1") 
			break
			
			case "]":
				#if (length(list[subscr] == 0)) list[subscr] = ""
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					subscr = substr(subscr, 1, ci - 1)
				}
			break
			
			case ",": 
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					d = substr(subscr, ci+1)
					subscr = substr(subscr, 1, ci - 1)
					d = strtonum(d) + 1
					subscr = subscr = (subscr "," d) 
				} else {
					subscr = strtonum(subscr) + 1
				}
			break
				
			default:
				list[subscr] = c
			break;
		}
	}
}

function lastIndexOf(str, find) {
	for (_i = length(str); _i > 0; _i--) {
		tmp = substr(str, _i, length(find))
		if (tmp == find) return _i
	}
	return 0
}