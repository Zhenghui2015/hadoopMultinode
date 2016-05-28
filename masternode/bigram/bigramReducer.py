#!/usr/bin/env python
import sys

urrentKey = None
currentCnt = 0
totalNum = 0
result = []

## Count all bigram pair
for line in sys.stdin:
    key, value = line.split('\t')
    # input are sorted according to key
    if key == currentKey:
        currentCnt += int(value)
    else:
        if currentKey:
            totalNum += currentCnt
            result.append((currentKey, currentCnt))
        currentKey = key
        currentCnt = int(value)
# add the last word to result
totalNum += currentCnt
result.append((currentKey, currentCnt))

##  Prepare for sorting
#   set count as key, bigram as value 
print '%s\t%s' % (totalNum+1, totalNum)
for i in xrange(len(result)):
    print '%s\t%s' % (result[i][1], result[i][0])
