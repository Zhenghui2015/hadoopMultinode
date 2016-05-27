#!/usr/bin/env python
import sys
import string

### generate bigram pairs in stdin
#   Only count bigram words in the same line, don't count punctuation
#   All words are transformed in to lower case
for line in sys.stdin:
    # convert the sentence into lower case
    line = line.lower()    
    # eliminate all punctuation 
    for char in string.punctuation:
        line = line.replace(char, "")
    words = line.strip().split()
    for i in xrange(len(line)-1):
        print '%s\t%s' % (line[i] + " " + line[i+1], 1)
        
