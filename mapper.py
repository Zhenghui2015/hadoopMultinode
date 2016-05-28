#!/usr/bin/env python
import sys
import string

### generate bigram pairs in stdin
#   Only count bigram words in the same line, don't count punctuation
#   All words are transformed in to lower case
for line in sys.stdin:
	# convert the sentence into lower case
    line = line.lower()
    # convert the sentence into lower case
    for char in string.punctuation:
        line = line.replace(char, "")
    words = line.strip().split()
    for i in range(len(words)-1):
        print '%s\t%s' % (words[i]+" "+words[i+1], 1)