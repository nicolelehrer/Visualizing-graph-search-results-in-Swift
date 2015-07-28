//: Playground - noun: a place where people can play

import UIKit

var parents = [Int:Int]()
var queue = [Int]()
var pathResult = [Int]()
var visited = [Int]()
var specialCases = [Int]()

var dict = Dictionary<Int,[Int]>()

func setAdjacents(){
    dict[1] = [2, 4]
    dict[2] = [1,3,5]
    dict[3] = [2]
    dict[4] = [1,7]
    dict[5] = [2,6,8]
    dict[6] = [5,9,10]
    dict[7] = [4]
    dict[8] = [5]
    dict[9] = [6,12]
    dict[10] = [6,11]
    dict[11] = [10]
    dict[12] = [9]
    dict[13] = []
}

if dict[13] == nil {
 print("it's nil")
}

func breadthFirstSearch(var currentNode:Int, target:Int){
    
    queue.append(currentNode) //attach start node
    
    while queue.count > 0{
        
        currentNode = queue[0]
        queue.removeAtIndex(0)
        
        var children = [0]
        if dict[currentNode] != nil {
            children = dict[currentNode]! //assign children if any
        }
        if !visited.contains(currentNode){
            visited.append(currentNode)   //only add nodes not yet visited
        }
        for child in children{
            if !visited.contains(child){
                parents[child] = currentNode  //child is key, value is parent
                visited.append(child)
                queue.append(child)
            }

        }
    }
}


func getPath(start:Int, target:Int) -> [Int]{
    var node = target
    while (node != start){
        pathResult.append(node)
        if parents[node] != nil {
            node = parents[node]!
        }
        else{
            print("no parents, stop path")
            return pathResult
        }
    }
    pathResult.append(start)
    return pathResult
}


func returnPathUsingBFS(startNode:Int, endNode:Int){
    breadthFirstSearch(startNode, target: endNode)
    getPath(startNode, target: endNode)
}

setAdjacents()
returnPathUsingBFS(3, endNode:5)






var something = [1, 2, 3]
something.removeAll()
something.removeAll()



14 % 4
let sortedKeys = dict.keys.sort({$0.0 < $1.0 })

sortedKeys.first
sortedKeys.last

sortedKeys


13 / 4
13 / 4 + 13 % 4


4*4



pow(4.0, 0.5)



//let offSet:CGPoint = CGPointMake(CGFloat((something - somethingelse)/2), 50)



