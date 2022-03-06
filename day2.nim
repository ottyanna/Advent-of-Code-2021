import strutils
import strscans

let f = open("day2.txt")

#PART ONE
#[
var 
    line : string
    forwardNum : int
    upNum : int
    downNum : int
    totForward: int
    totDepth : int

while endOfFile(f) == false:
    line = readLine(f)
#echo line
#if line.contains("forward") == true:
#echo "mhhh"
    if scanf(line, "forward $i", forwardNum): totForward += forwardNum
    #echo "forward num is ", forwardNum
    if scanf(line, "up $i", upNum): totDepth -= upNum
    if scanf(line, "down $i", downNum): totDepth += downNum

let prod : int = totDepth*totForward

echo prod
]#

var 
    line : string
    forwardNum : int
    upNum : int
    downNum : int
    totForward: int
    totDepth : int
    aim : int

while endOfFile(f) == false:
    line = readLine(f)
    if scanf(line, "up $i", upNum): aim -= upNum
    if scanf(line, "down $i", downNum): aim += downNum
    if scanf(line, "forward $i", forwardNum): 
        totForward += forwardNum
        totDepth += aim * forwardNum

let prod : int = totDepth*totForward

echo prod


f.close()