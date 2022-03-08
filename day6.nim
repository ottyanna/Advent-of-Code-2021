import os,strutils

type 
    DayData = object
        fishes : seq[int]
        day : int

var daydata : seq[DayData] = @[]
let num: int = readline(stdin).parseInt
var counter : array[2,array[9,int]]

block readInput:

    if os.paramCount() < 1:
        quit(1)

    var data = readFile(os.paramStr(1)).strip().split(",")

    daydata.add(DayData())

    for item in data:
        daydata[0].fishes.add(item.parseInt)

    #echo daydata

block part1:

    break part1 #part one in this way is extremely slow, part two is impossible to process

    for i in 1..num:
        daydata.add(DayData())
        daydata[i]=daydata[i-1]
        daydata[i].day = i
        for j in 0..<daydata[i].fishes.len:
            if daydata[i].fishes[j] == 0:
                daydata[i].fishes[j] = 6
            else : daydata[i].fishes[j].dec
            if daydata[i-1].fishes[j] == 0:
                daydata[i].fishes.add(8)

    echo daydata[num].fishes.len

block part2:

    for item in daydata[0].fishes:
        for j in 0..<9:
            if item == j: counter[0][j].inc

    #check if data is correct
    var tot: int

    for item,j in counter[0]:
        tot += j * item

    var sum : int

    for item in daydata[0].fishes:
        sum += item

    if tot != sum: quit(1)

    for i in 1..num:
        
        for j in 0..<8:
            if counter[0][j+1] != 0:
                counter[1][j]=counter[0][j+1]
            else:
                counter[1][j]=0
            
        counter[1][8] = 0 #i need to reset counter of 8, otherwise, it leaves the value found in the cycle before
        
        if counter[0][0] != 0:
            counter[1][8]=counter[0][0]
            counter[1][6]+=counter[0][0]

        counter[0]=counter[1]

    tot = 0 #reset the sum

    for item in counter[1]:
        tot += item

    echo tot