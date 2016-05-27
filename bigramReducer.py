#!/usr/bin/env python
import sys

currentKey = ""
currentCnt = 0
totalNum = 0
result = []

## Count all bigram pair
for line in sys.stdin:
    key, val = line.strip().split('\t', 1)
    # input are sorted according to key
    if key == currentKey:
        currentCnt += int(val)
    else:
        if currentKey != "":
            totalNum += currentCnt
            result.append((currentKey, currentCnt))
        currentKey = key
        currentCnt = int(val)
# add the last word to result
totalNum += currentCnt
result.append((currentKey, currentCnt))

## print total number of bigrams
print totalNum

## sort bigram word pairs according to frequency
sortedRes = sorted(result, key=lambda x:x[1], reverse=True)
## print the most frequency bigramCount
print '%s\t%s' % (sortedRes[0][0], sortedRes[0][1])

## print bigram pairs add up to 10% of words
curCnt = 0
stopIdx = 0
for (key, val) in sortedRes:
    curCnt += val
    stopIdx += 1
    if curCnt > totalNum/10:
        break
print stopIdx
for i in xrange(stopIdx):
    print '%s\t%s' % (sortedRes[i][0], sortedRes[i][1])


