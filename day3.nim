import strutils

let f = open("day3.txt")

#PART ONE
#[
var 
    line : string = readLine(f)
    gammaRate : string
    epsilonRate : string
    appo : int

let len : int = len(line)

var counter0 : seq[int] = @[]
var counter1 : seq[int] = @[]

#si può evitare in qualche modo?
for i in 0..<len:
    counter0.add(0)
    counter1.add(0)

echo line
echo line[0]

while endOfFile(f) == false:
    for i in 0..<len:
        appo = line[i].int - int('0')
        if appo == 0: counter0[i].inc
        else: counter1[i].inc
    line = readLine(f)

f.close()

for i in 0..<len:
    if counter0[i]>counter1[i]: 
        gammaRate.add('0')
        epsilonRate.add('1')
    else:
        gammaRate.add('1')
        epsilonRate.add('0')

echo "gamma ", gammaRate
echo "epsilon ", epsilonRate 

let prod : int = epsilonRate.parseBinInt*gammaRate.parseBinInt

echo prod
]#


#PART TWO

#defining procedures
proc myDelete(linesToBeDeleted : var seq, notFrequentNum : int, i : int) : void =
    var k : int
    while k < linesToBeDeleted.len:    
        var appo : int = linesToBeDeleted[k][i].int - int('0')
        if appo == notFrequentNum: linesToBeDeleted.delete(k)
        else: k.inc

#this is for Gamma, for Epsilon you need to switch counter 0 and counter1 in the calling
proc ifStatement (counter0 , counter1 : int, lines : var seq, i : int, check : string ) : void =
    if counter0 > counter1: myDelete(lines,1,i)
    if counter0 < counter1: myDelete(lines,0,i)
    if counter0 == counter1: 
       if check == "Gamma": myDelete(lines,0,i)
       else : myDelete(lines,1,i)


proc binaryChoose (lines : var seq, check : string ) : void =
    let len = lines[1].len
    var counter0, counter1 : int
    for i in 0..<len:
        counter0 = 0
        counter1 = 0
        for k in 0..<lines.len:    
            var appo : int = lines[k][i].int - int('0')
            if appo == 0: counter0.inc
            else: counter1.inc
        if check == "Gamma": ifStatement(counter0,counter1,lines,i,check)
        else: ifStatement(counter1,counter0,lines,i,check)
        if lines.len == 1: break


#MAIN PROGRAM
var    
    lines : seq[string] = @[]
    linesGamma : seq[string] = @[]
    linesEpsilon : seq[string] = @[]


while endOfFile(f) == false:
    lines.add(readLine(f))

f.close()

for i in 0..<lines.len:
    linesGamma.add(lines[i])
    linesEpsilon.add(lines[i])

binaryChoose(linesGamma,"Gamma")
binaryChoose(linesEpsilon,"Epsilon")

echo "Gamma: ", linesGamma
echo "Epsilon: ", linesEpsilon

let prod : int = linesEpsilon[0].parseBinInt*linesGamma[0].parseBinInt

echo prod