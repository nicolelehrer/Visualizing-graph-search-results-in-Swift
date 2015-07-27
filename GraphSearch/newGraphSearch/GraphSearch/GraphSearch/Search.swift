//
//  Search.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 7/27/15.
//  Copyright © 2015 Nicole Lehrer. All rights reserved.
//

import Foundation

class Search{
    
    var parents = [Int:Int]()
    var queue = [Int]()
    var pathResult = [Int]()
    var visited = [Int]()
    var specialCases = [Int]()
    
    var dict = [Int:[Int]]()
    
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
    
    func breadthFirstSearch(var currentNode:Int, target:Int){
        
        
        queue.append(currentNode) //attach start node
        
        while queue.count > 0{
            
            currentNode = queue[0]
            queue.removeAtIndex(0)
            
            if let children = dict[currentNode] { //are their child nodes
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
    
    func emptyPreviousResults(){
        if pathResult.count>0{
            pathResult.removeAll()
        }
        if visited.count>0{
            visited.removeAll()
        }
    }
    
    func returnPathUsingBFS(startNode:Int, endNode:Int) -> [Int]{
        breadthFirstSearch(startNode, target: endNode)
        return getPath(startNode, target: endNode)
    }
}