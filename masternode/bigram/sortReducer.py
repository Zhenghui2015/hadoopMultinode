#!/usr/bin/env python
import sys

# The first line is total number
totalNum = sys.stdin.readline().strip().split('\t')
print 'Total Number of bigrams: %s\n' % (totalNum[1])
totalNum = int(totalNum[1])

# Output the most frequent bigram pair
pair = sys.stdin.readline().strip().split('\t')
print 'The most frequent bigram:'
print 'Bigram pair: %s, count: %s\n' % (pair[1], pair[0])

# Output number of bigrams that take up 10% of total number
print 'Bigram that make up 10 percent of total:'
print '%s: %s' % (pair[1], pair[0])
currentNum = pair[0]
stopIdx = 1
for line in sys.stdin:
    if currentNum > totalNum/10:
        break
    pair = line.strip().split('\t')
    print '%s: %s' % (pair[1], pair[0])
    currentNum += pair[0]
    stopIdx += 1
print '%s bigrams take up ten percent of total number' % (stopIdx)