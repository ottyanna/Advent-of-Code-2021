import strutils

#PART ONE 
#[
let f = open("day1.txt")

var
    counter : int
    depthBefore : int = readLine(f).parseInt
    depthAfter : int


while not endOfFile(f):
    depthAfter = readLine(f).parseInt
    if depthBefore < depthAfter: counter.inc
    depthBefore = depthAfter

f.close()

echo counter
]#

#PART TWO
let f = open("day1.txt")

var
    counter : int
    depthsumAfter : int
    depth1 : int  = readLine(f).parseInt
    depth2 : int = readLine(f).parseInt
    depth3 : int = readLine(f).parseInt
    depthsumBefore : int = depth1+depth2+depth3

while endOfFile(f) == false:
    depth1 = depth2
    depth2 = depth3
    depth3 = readLine(f).parseInt
    depthsumAfter = depth1+depth2+depth3
    if depthsumBefore < depthsumAfter: counter.inc
    depthsumBefore = depthsumAfter

f.close()

echo counter