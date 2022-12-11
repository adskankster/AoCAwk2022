BEGIN {}

/.+/ {

	for (i = 14; i <= length($0); i++) {
		check = substr($0, i - 13, 14)
		
		if (checkForDuplicate(check) == 0) {
			print i
			break
		}
	}
}

function checkForDuplicate (checkStr) {
	for (j = 1; j < length(checkStr); j++) {
		remStr = substr(checkStr, j + 1)
		chrctr = substr(checkStr, j, 1)

		if (index(remStr, chrctr) > 0) {
			return 1
		}
	}
	return 0
}
