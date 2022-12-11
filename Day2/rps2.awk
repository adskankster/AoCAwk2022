BEGIN { total = 0 }

/^A X$/ { total += 3 }

/^A Y$/ { total += 4 }

/^A Z$/ { total += 8 }

/^B X$/ { total += 1 }

/^B Y$/ { total += 5 }

/^B Z$/ { total += 9 }

/^C X$/ { total += 2 }

/^C Y$/ { total += 6 }

/^C Z$/ { total += 7 }

END { printf("%s", total) }