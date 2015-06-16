
import UIKit

public class Graph {
    
    public var dict = Dictionary<Int,[Int]>()
    var queue = [Int]()
    public var path = [Int]()
    public var specialCases = [6, 10] //hard code special drawing case for now

    public init(){
        
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
        
        
        var start = 1
        var stop = 10
        var ans = 0
        
        path.append(stop)
        while( ans != start){
            ans = checkChildren(1, destinationNode: stop)
            stop = ans
            path.append(stop)
        }
    }
    
    func checkChildren(startNode : Int, destinationNode : Int) -> Int{
        
        queue.append(startNode)
        
        while queue.count > 0{
            
            var arr = dict[queue[0]]!
            
            if arr.count == 0 {
                println("no where to go")
                return 0
            }
            if contains(arr, destinationNode){
                println("destination found via current node \(queue[0])")
                return queue[0]
            }
            queue = queue + arr
            queue.removeAtIndex(0)
        }
        
        return 0
    }
    
    func printOutArray([Int]){
        for (var k = 0; k<queue.count; k++){
            println(queue[k])
            if (k==queue.count-1){
                println("end")
            }
        }
    }
}
