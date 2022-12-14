BEGIN {
	FS = "\n"; RS = ""
	correctOrderSum = 0
	curPair = 1
	curItem = 1
}

/^.+/ {
	pairs[NR][1] = $1
	pairs[NR][2] = $2
}

END {
	for (curPair = 1; curPair <= length(pairs); curPair++) {

		itemToList(pairs[curPair][1], left)
		itemToList(pairs[curPair][2], right)
		
		PROCINFO["sorted_in"] = "@ind_str_asc"
		
		lsi = 1
		for(l in left) {
			#print "left[" l "] = " left[l]
			leftSubscr[lsi++] = l
		}	

		rsi = 1
		for (r in right) {
			#print "right[" r "] = " right[r]
			rightSubscr[rsi++] = r
		}
		
		wrong = 0
		for (lsi = 1; lsi <= length(leftSubscr); lsi++) {
		
			print curPair ": " leftSubscr[lsi] "=" left[leftSubscr[lsi]]  " - " rightSubscr[lsi] "=" right[rightSubscr[lsi]]
		
			#print curPair ": " lsi " vs " length(rightSubscr)
			if (lsi > length(rightSubscr)) {
				wrong = 1
				break
			}

			if (left[leftSubscr[lsi]] > right[rightSubscr[lsi]]) {
				wrong = 1
				break
			}
			
			if (length(left[leftSubscr[lsi]]) == 0 && 
				length(right[rightSubscr[lsi]]) > 0) {
				break
			}
		}
		if (wrong == 1) {
			continue
		}
		
		print "Correct pair - " curPair
		correctOrderSum += curPair

		delete leftSubscr
		delete rightSubscr
		delete left
		delete right
	}
	
	print "Sum of items in correct order = " correctOrderSum
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
				
				d1 = "1"
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					d1 = substr(subscr, ci+1)
				}
				
				if (length(list[subscr]) == 0) { 
					if (d1 == 1) {
						list[subscr] = ""
					} else {
						delete list[subscr]
					}
				}
				
				if (ci > 0) {
					subscr = substr(subscr, 1, ci - 1)
				}
			break
			
			case ",": 
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					d2 = substr(subscr, ci+1)
					subscr = substr(subscr, 1, ci - 1)
					d2 = strtonum(d2) + 1
					subscr = subscr = (subscr "," d2) 
				} else {
					subscr = strtonum(subscr) + 1
				}
			break
				
			default:
				list[subscr] = c
			break
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