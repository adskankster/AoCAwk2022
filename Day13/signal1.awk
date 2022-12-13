BEGIN {
	correctOrderSum = 0
	curPair = 1
	curItem = 1
}

/^.+/ {
	print curPair "," curItem " - " $0
	pairs[curPair][curItem++] = $0
}

/^\s*$/ {

	itemToList(pairs[curPair][1], left)
	itemToList(pairs[curPair][2], right)
	
	for(l in left) {
		print "left[" l "] = " left[l]
	}	
	
	for (r in right) {
		print "right[" r "] = " right[r]
	}

	delete left
	delete right

	curItem = 1
	curPair++
}

END {
	print correctOrderSum
}


function itemToList(item, list) {
	
	subscr = 1
	delete list
	
	for (i = 2; i <= length(item); i++) {

		c = substr(item, i, 1)
		
		switch (c) {
			case "[":
				subscr = ("1" "," subscr) 
			break
			
			case "]":
				ci = index(subscr, ",")
				if (ci > 0) {
					subscr = substr(subscr, 1, ci - 1)
				}
			break
			
			case ",": break
				
			default:
				ci = index(subscr, ",")
				if (ci > 0) {
					d = substr(subscr, 1, ci - 1)
					subscr = substr(subscr, ci + 1)
					d = strtonum(d) + 1
					subscr = subscr = (d "," subscr) 
				} else {
					subscr = strtonum(subscr) + 1
				}
				list[subscr] = c
			break;
		}
	}
}
