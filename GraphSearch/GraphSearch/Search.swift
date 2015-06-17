//
//  Search.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 6/17/15.
//  Copyright (c) 2015 Nicole Lehrer. All rights reserved.
//

import Foundation

class Search {
    
    var parents = Dictionary<Int,Int>()
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
        specialCases = [6, 10]
    }
    
    init(test:String){
        println("test pass from init " + test)
        setAdjacents()
    }
    
    func printOutArray(arr:[Int]){
        for (var k = 0; k<arr.count; k++){
            println(arr[k])
        }
        println("end")
    }

     func findPath(var currentNode:Int, var target:Int){
        
        queue.append(currentNode)
        
        while queue.count > 0{

            printOutArray(visited)
            
            currentNode = queue[0]
            
            queue.removeAtIndex(0)
            
            var children = [Int]()
            if(dict[currentNode] != nil){
                children = dict[currentNode]!
            }
            else{
                children = [0]
            }
            
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
    
    
    func getPath(var start:Int, var target:Int) -> [Int]{
        var node = target
        while (node != start){
            pathResult.append(node)
            node = parents[node]!
        }
        pathResult.append(start)
        return pathResult
    }
}