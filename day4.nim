import strutils

let data = readFile("day4.txt").strip().splitLines()

#echo data[0].strip().split(",")
#echo data[2]
#echo data[2].strip().split(" ")

#board construction
type
  Cell = tuple
    value: int
    selected: bool
  
  Board = object
    grid: array[0..4, array[0..4, Cell]]  

var numbers : seq[int] = @[]
var boards : seq[Board] = @[]
var j: int #row index

for item in data:
    
    if numbers.len == 0:
        for value in item.strip().split(","):
            numbers.add(value.parseInt())
    
    elif item == "":
        boards.add(Board())
        j=0 #to make a new board and to reset row index to 0

    else: 
        let rowToBeFiltered = item.strip().split(" ")
        var nums: seq[int] = @[]
        for item in rowToBeFiltered: 
            if item != "" : nums.add(item.parseInt) 
        #The numbers are just 5 now, and there is no extra string
        for i in 0..<5: #there are just 5 columns
            boards[boards.len-1].grid[j][i] = (nums[i],false)

        j.inc

#FINISHED SAVING DATA IN A NEAT WAY

type
    WinnerBoard = tuple
        check : bool #true if it's the winning board, so it's initialised false
        index : int

var 
    winnerBoard : WinnerBoard
    victoryNumber : int
    sum : int

proc pickNumInBoard(boards: var seq[Board], num : int) =
    for k in 0..<boards.len:    
        for i in 0..<5:
            for j in 0..<5:
                if boards[k].grid[i][j].value == num: 
                    #echo "ho il numero ", num , " nella tabella n." , k, " alla posizione (", i+1 ,",",j+1,")"  
                    boards[k].grid[i][j].selected = true

proc checkBoard (boards: var seq[Board]) : WinnerBoard =
    var counter : int
    for k,board in boards:    
        for i in 0..<5: #check for rows
            counter = 0
            for j in 0..<5:
                if board.grid[i][j].selected == true: counter.inc
                else : continue
            if counter == 5: return (true,k)
        
        for i in 0..<5: #check for columns
            counter = 0
            for j in 0..<5:
                if board.grid[j][i].selected == true: counter.inc
                else : continue
            if counter == 5: return (true,k)


for item in numbers:
    pickNumInBoard(boards,item)
    winnerBoard = checkBoard(boards)
    if winnerBoard.check: #if it's true
        victoryNumber = item
        break

#echo "board number is " , winnerBoard.index
#echo "victory number is ", victoryNumber

for i in 0..<5:
    for j in 0..<5:
        if not boards[winnerBoard.index].grid[i][j].selected: #if it's false
            sum += boards[winnerBoard.index].grid[i][j].value

#echo "the result of the first part is ", victoryNumber*sum

block secondPart:

    proc checkAllTrue (board: Board): bool =
        for i in 0..<5: #check for rows
            for j in 0..<5:
                if board.grid[i][j].selected == false: return false
        return true


    proc reset (boards : var seq)=
        for i in 0..<boards.len:
            for j in 0..<5:
                for k in 0..<5:
                    boards[i].grid[j][k].selected = false


    var lastWinner : Board

    winnerBoard = (false,0)
    reset(boards)

    #echo boards

    block all:
        for item in numbers:
            pickNumInBoard(boards,item)
            winnerBoard = checkBoard(boards)
            if checkAllTrue(boards[winnerBoard.index]): break all
            while winnerBoard.check: #if it's true
                if boards.len > 1:
                    lastWinner = boards[winnerBoard.index]
                    victoryNumber = item
                    boards.delete(winnerBoard.index)
                else: 
                    lastWinner = boards[winnerBoard.index]
                    victoryNumber = item
                    break all
                winnerBoard = checkBoard(boards)


    echo "the last to win is the board: ", lastWinner , " with number ", victoryNumber

    sum = 0

    for i in 0..<5:
        for j in 0..<5:
            if not lastWinner.grid[i][j].selected: #if it's false
                sum += lastWinner.grid[i][j].value

    echo "the result of the second part is ", victoryNumber*sum