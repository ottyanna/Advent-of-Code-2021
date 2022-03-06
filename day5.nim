import os, strutils

type
    Couple = tuple 
        x,y : int

    Positions = object
        first, second : Couple
    
    Grid = object
        coord : Couple
        count : int

var dataPos : seq[Positions] = @[]
var grid : seq[Grid] = @[]
var counter : int

block readInput:

    if os.paramCount() < 1:
        quit(1)

    let f = open(os.paramStr(1))

    while endOfFile(f) == false:
        dataPos.add(Positions())
        var appo = readLine(f).strip().split("->") 
        dataPos[dataPos.len-1].first = (appo[0].strip().split(",")[0].parseInt,appo[0].strip().split(",")[1].parseInt)
        dataPos[dataPos.len-1].second = (appo[1].strip().split(",")[0].parseInt,appo[1].strip().split(",")[1].parseInt)

block part1:

    proc gridInizialisation (dataPos : seq[Positions], grid : var seq[Grid]) =
        var appoMaxx : int
        var appoMaxy : int

        for item in dataPos:
            appoMaxx = max(item.first.x,appoMaxx)
            appoMaxy = max(item.first.y,appoMaxy)

        let max : int = max(appoMaxx,appoMaxy)

        for j in 0..max:
            for i in 0..max:
                grid.add(Grid())
                grid[grid.len-1].coord = (i,j)


    proc select (xF, xS, yF, yS : int, grid: var seq[Grid]) =
        
        for i in 0..<grid.len:
            if xF == xS:
                if grid[i].coord.x == xF:  
                    if grid[i].coord.y >= min(yF,yS) and grid[i].coord.y <= max(yF,yS):
                        grid[i].count.inc
            elif yF == yS:
                if grid[i].coord.y == yF:  
                    if grid[i].coord.x >= min(xF,xS) and grid[i].coord.x <= max(xF,xS):
                        grid[i].count.inc

    gridInizialisation(dataPos,grid)

    for pos in dataPos:
        select(pos.first.x,pos.second.x,pos.first.y,pos.second.y, grid)


    for item in grid:
            if item.count >= 2:
                counter.inc

    echo counter

block part2:

    var steps, dx, dy : int

    for pos in dataPos:

        dx = pos.second.x-pos.first.x 
        dy = pos.second.y-pos.first.y

        if dx.abs == dy.abs:
            steps = dx.abs
            dx=dx div steps
            dy=dy div steps
            for i in 0..steps:
                for j in 0..<grid.len:
                    if grid[j].coord == (pos.first.x + i*dx , pos.first.y + i*dy ):
                        inc(grid[j].count)
                    
#[  to check grid 
    
    let num: int = readline(stdin).parseInt


    for item in grid:
        if item.coord.y == num: echo item
]#

    counter = 0

    for item in grid:
        if item.count >= 2:
            counter.inc
    
    echo counter