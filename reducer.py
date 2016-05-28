#!/usr/bin/env python
import sys

currentKey = None
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

print 'Total number of bigrams:%s\n' % totalNum

## sort bigram word pairs according to frequency
result = sorted(result, key=lambda x: x[1], reverse = True)
print 'The most sequce of bigrams'
print '%s\t%s\n' % (result[0][0], result[0][1])

## print bigram pairs add up to 10% of words
threshold = totalNum/10
cnt = 0
stopIdx = 0
for (key, value) in result:
    cnt += value
    stopIdx += 1
    if cnt > threshold:
        break
print 'Number of bigrams take up to ten percent: %s' % stopIdx
for i in xrange(stopIdx):
    print '%s\t%s\n' % (result[i][0], result[i][1])