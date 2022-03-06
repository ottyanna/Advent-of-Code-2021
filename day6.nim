import os,strutils

type 
    DayData = object
        fishes : seq[int]
        day : int

var daydata : seq[DayData] = @[]
let num: int = readline(stdin).parseInt

block readInput:

    if os.paramCount() < 1:
        quit(1)

    var data = readFile(os.paramStr(1)).strip().split(",")

    daydata.add(DayData())

    for item in data:
        daydata[0].fishes.add(item.parseInt)

    #echo daydata

block part1:

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

    #echo daydata
    echo daydata[num].fishes.len

#this calculation is too much when there are 250 days, it needs to be done in another way