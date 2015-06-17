import UIKit

var dict = Dictionary<Int,[Int]>()

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


var parents = Dictionary<Int,Int>()
var queue = [Int]()
var currentNode:Int = 1
var target:Int = 10
var pathResult = [Int]()
var visited = [Int]()

func printOutArray(arr:[Int]){
    for (var k = 0; k<arr.count; k++){
        println(arr[k])
        if (k==arr.count-1){
            println("end")
        }
    }
}

func findPath(){
    queue.append(currentNode)
    
    while queue.count > 0{
        
        printOutArray(queue)
        
        currentNode = queue[0]
        
        queue.removeAtIndex(0)
        let children = dict[currentNode]!
        
        if (!contains(visited,currentNode)){
            visited.append(currentNode)
        }
        
        for(var i:Int = 0; i < children.count; i++){
            
            if (!contains(visited,children[i])){
                
                //child is key, value is parent
                parents[children[i]] = currentNode
                
                if (children[i] == target){
                    println("target found at \(currentNode)")
                    return
                }
                
                visited.append(children[i])
                queue.append(children[i])
                
            }
        }
    }
}
