//: Playground - noun: a place where people can play

import UIKit

let maybes1 = "123"
let maybes2 = "12"
let maybes3 = "124"
let maybes4 = "14"
let maybes5 = "89"

let match = maybes3.characters.filter() { maybes1.range(of: String($0)) != nil }
print("match = \(match), count = \(match.count)")
let matchStr = match.reduce("",{String($0) + String($1)})
print("matchStr = \(matchStr), count = \(matchStr.characters.count)")

let array1 = ["1","","3","","5"]
let array2 = ["","2","","4",""]
let array12 = array1.enumerated().map() { $0.1 == "" ? array2[$0.0] : $0.1 }
print("array12 = \(array12)")

let singleCount = array1.filter({ $0.characters.count != 1 }).count
print("\(singleCount)")

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .medium
dateFormatter.timeStyle = .short
let date = Date()
dateFormatter.locale = Locale(identifier: "en_US")
dateFormatter.string(from: date)

print(array1.enumerated())

let ArtoCandidatesPostCP =
    ["", "", "1369", "36", "1679", "", "", "36", "1367",
     "", "", "136", "34568", "156", "345", "13568", "3568", "",
     "169", "369", "", "3568", "15679", "359", "135678", "2", "135678",
     "69", "689", "689", "", "4", "", "3568", "3568", "",
     "", "7", "", "26", "26", "8", "", "1", "4",
     "1269", "", "12689", "2356", "2569", "359", "35678", "3568", "35678",
     "4", "36", "236", "9", "", "1", "2356", "", "356",
     "256", "", "", "245", "25", "45", "23568", "9", "3568",
     "259", "89", "289", "7", "", "", "1258", "", "158"]
let ArtoPuzzlecpAssigns = [(index: 25, element: "2"), (index: 31, element: "4"), (index: 37, element: "7"), (index: 41, element: "8"),
    (index: 43, element: "1"), (index: 44, element: "4"), (index: 54, element: "4"),(index: 57, element: "9"),
    (index: 59, element: "1"), (index: 70, element: "9"), (index: 75, element: "7")]
let assignedOffsets = ArtoCandidatesPostCP.enumerated().filter({ $0.1.characters.count == 1 }).map({$0.offset})
let assignedElements = ArtoCandidatesPostCP.enumerated().filter({ $0.1.characters.count == 1 }).map({$0.element})
print("assignedOffsets = \(assignedOffsets)")
print("assignedElements = \(assignedElements)")
var cpAssigns = [(offset: Int, element: String)]()
for idx in assignedOffsets {
    cpAssigns.append((offset: idx, element: ArtoCandidatesPostCP[idx]))
}
print("cpAssigns = \(cpAssigns)")
print("ArtoPuzzlecpAssigns = \(ArtoPuzzlecpAssigns)")

let tPairs = [(index: 45, element: "68"), (index: 53, element: "68"), (index: 58, element: "67"), (index: 76, element: "67"), (index: 44, element: "68")]
let tElements = tPairs.map(){ $0.element }
print("tElements = \(tElements)")
let tIndexes = tPairs.map(){ $0.index }
print("tIndexes = \(tIndexes)")
let tUniqueElements = Set(tElements)
let tCells = tPairs.filter(){ $0.element == "68" }.map(){ $0.index }
print("tCells = \(tCells)")
let emptyArray = [String]()
let emptySet = Set(emptyArray)
print("emptySet = \(emptySet)")

let rows = tCells.map() { $0/9 }
print("rows = \(rows)")
let theRowsSet = Set(rows)
var theRowsArray = [Int]()
for aRow in theRowsSet { theRowsArray.append(aRow) }

let firstRows = rows.filter() { $0 == theRowsArray[0] }
print("firstRows = \(firstRows), count = \(firstRows.count)")
let missingRow = firstRows.count == 1 ? theRowsArray[0] : theRowsArray[1]

let cols = tCells.map() { $0 % 9 }
print("cols = \(cols)")

var testString = "12"
let index1 = testString.range(of: "1")
testString.removeSubrange(index1!)
let index2 = testString.range(of: "2")
testString.removeSubrange(index2!)

extension Array {
    func decompose(_ k: Int) -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<k]))
    }
}

func between<T>(_ x: T, _ ys: [T]) -> [[T]] {
    guard let (head, tail) = ys.decompose(ys.count) else { return [[x]] }
    return [[x] + ys] + between(x, tail).map { [head] + $0 }
}

func permutations<T>(_ xs: [T]) -> [[T]] {
    guard let (head, tail) = xs.decompose(xs.count) else { return [[]] }
    return permutations(tail).flatMap { between(head, $0) }
}

func combination<T>(_ xs: [T], _ k: Int) -> [[T]] {
    guard let (head, tail) = xs.decompose(k) else { return [[]] }
    return permutations(tail).flatMap { between(head, $0) }
}

let p = permutations([1,2,3])
//let c = ([1,2,3]).combinations(2)

func combos<T>(_ array: Array<T>, _ k: Int) -> Array<Array<T>> {
    var array = array
    if k == 0 {
        return [[]]
    }
    
    if array.isEmpty {
        return []
    }
    
    let head = [array[0]]
    let subcombos = combos(array, k - 1)
    var ret = subcombos.map {head + $0}
    array.remove(at: 0)
    ret += combos(array, k)
    
    return ret
}

let c = combos([1,2,3,4],3)
print(c)



func sliceArray<T>(_ arr: Array<T>, _ lower: Int, _ upper: Int) -> Array<T> {
    
    if lower > upper { return [] }
    
    var subArr: Array<T> = []
    
    for i in lower...upper {
        subArr.append(arr[i])
    }
    return subArr
}


func combinations<T>(_ arr: Array<T>, _ k: Int) -> Array<Array<T>> {
    
    var ret: Array<Array<T>> = []
    var sub: Array<Array<T>> = []
    var next: Array<T> = []
    
    for i in 0..<arr.count {
        
        if (k == 1) {
            ret.append([arr[i]])
        } else {
            sub = combinations(sliceArray(arr, i+1, arr.count-1), k-1)
            
            for subI in 0..<sub.count {
                next = sub[subI]
                next.insert(arr[i], at: 0)
                ret.append(next)
            }
        }
    }
    return ret
}


let myCombinations = combinations(["Peter","Paul","John","Luke"],3)
print(myCombinations)

let combosArtoPuzzlecpAssigns = combinations(ArtoPuzzlecpAssigns, 3)
//print(combosArtoPuzzlecpAssigns)
print("combos.count = \(combosArtoPuzzlecpAssigns.count), input.count = \(ArtoPuzzlecpAssigns.count)")

//let eleven = ["a","b","c","d","e","f","g","h","i","j","k"]
//let combosEleven = combinations(eleven, 3)
//print("combosEleven.count = \(combosEleven.count)")

let eArray = [String](repeating: "", count: 81)
print("emptyArray.count = \(eArray.count)")
let combinedString = ["Peter","Paul","John","Luke"].reduce("",+)
print("combinedString = \(combinedString), charCount = \(combinedString.characters.count)")

let postUnits = [14, 1, 15, 19, 12, 18, 9, 11, 0, 2, 4, 5, 8, 10, 17, 20, 21, 22, 24, 3, 16, 23, 26, 6, 7, 13, 25]
let preUnits = [14, 15, 19, 18, 11, 0, 2, 4, 5, 8, 10, 17, 20, 21, 22, 24, 3, 16, 23, 26, 6, 7, 13, 25]
let newSolvedUnits = postUnits.filter() { !preUnits.contains($0) }
print("newSolvedUnits = \(newSolvedUnits)")

let one = [(index: 41, element: "4")]
let two = [(index: 41, element: "4"), (index: 80, element: "2")]
let oneIndex = one.map({$0.index}).sorted()
let twoIndex = two.map({$0.index}).sorted()
print("oneIndex = \(oneIndex), twoIndex = \(twoIndex)")

let text = "46"
for char in text.characters {
    let charRange = text.range(of: String(char))!
    let charIndex = text.distance(from: text.startIndex, to: charRange.lowerBound)
    print("charIndex = \(charIndex)")
}
for (idx, char) in text.characters.enumerated() {
    print("idx = \(idx)")
}

var junk = ["1","2","4","6"]
let firstJunk = junk.removeFirst()
print("firstJunk = \(firstJunk), junk = \(junk)")

let intArray1 = [[1,2,3],[1,2,3]]
if let intArrayFirst = intArray1.first {
    let intArray1Reduced = intArray1.filter({ $0 != intArrayFirst })
}

var allTuples = [String](repeating: "", count: 9)
let filtered = allTuples.filter({ $0.characters.count > 0 })
print("filtered allTupples = \(filtered), filtered.count = \(filtered.count)")

struct Cell {
    var square: Int
    var value: String
    init(i: Int, e: String) {
        square = i
        value = e
    }
    func compare(_ cell: Cell) -> Bool {
        let areAscending = value <= cell.value
        return areAscending
    }
}
extension Cell: Equatable {
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        let areEqual = lhs.square == rhs.square && lhs.value == rhs.value
        return areEqual
    }
}

let hCells1 = [Cell(i: 45, e: "68"), Cell(i: 53, e: "68"), Cell(i: 44, e: "68"),  Cell(i: 36, e: "68")]
let hCells1Sorted = hCells1.sorted(by: { (cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square })
let hCells2 = [Cell(i: 36, e: "68"), Cell(i: 53, e: "68"), Cell(i: 44, e: "68"),  Cell(i: 45, e: "68")]
let hCells2Sorted = hCells2.sorted(by: { (cell1: Cell, cell2: Cell) -> Bool in return cell1.square < cell2.square })
if hCells1Sorted == hCells2Sorted {
    print("hCells order doesn't matter")
} else {
    print("hCells order does matter")
}

let vals = "abc"
let val = vals.characters.enumerated().filter({ $0.offset == 1}).map({ $0.element }).first
print("val = \(val)")

let iArray = [0,1,2,3,4,5,6,7]
for (x,idx) in iArray.enumerated() {
    if x == 2 { continue }
    if x == 5 { break }
    print("for loop x = \(x)")
    if idx == iArray.first { print("for loop first one!") }
}

let optionalInt: Int? = nil
let filterediArray = iArray.filter(){ $0 == optionalInt }
print("filterediArray = \(filterediArray)")

let sArray = ["1", "", "123", "4", "1", "7", "2", "4", "9", "4", ""]
let sArrayEnumerated = sArray.enumerated().map({Cell(i: $0.offset, e: $0.element)}).filter({ $0.value.characters.count == 1 })
let sArrayEnumSorted = sArrayEnumerated.sorted { (cell1, cell2) -> Bool in
    return cell1.compare(cell2) }
//print(sArrayEnumSorted)

let sArrayFiltered4 = sArrayEnumSorted.filter(){ $0.value == "4" }
let sArrayFilteredNot4 = sArrayEnumSorted.filter(){ $0.value != "4" }
let frontLoaded4 = sArrayFiltered4 + sArrayFilteredNot4
print(frontLoaded4)







