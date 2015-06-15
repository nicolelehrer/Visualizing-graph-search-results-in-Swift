import UIKit
import XCPlayground

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

var queue = [Int]()

func checkChildren(currNode : Int, destination : Int) -> Int{
    
    queue.append(currNode)
    
    while queue.count > 0{
        
        var arr = dict[queue[0]]!
        
        if arr.count == 0 {
            println("no where to go")
            return 0
        }
        if contains(arr, destination){
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

var start = 1
var stop = 10
var ans = 0

while( ans != start){
    ans = checkChildren(1, stop)
    stop = ans
}


////////////



let containerFrame:CGRect = CGRect(x: 0, y: 0, width: 500, height: 400)
let containerView:UIView = UIView(frame: containerFrame)
containerView.backgroundColor = UIColor.grayColor()
XCPShowView("View Identifier", containerView)



func makeCirclesWith(count : Int){
//    var i = 0
    for(var i = 0; i < count; i++){
        let circleRad:CGFloat = 150.0
        let circleFrame:CGRect = CGRect(x: containerFrame.width/2, y: containerFrame.height/2, width: circleRad, height: circleRad)
        let circleView = UIView(frame: circleFrame)
        circleView.layer.cornerRadius = circleRad/2
        circleView.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(circleView)
    }
}

makeCirclesWith(12)




/*
let nodeTitle:UILabel = UILabel(frame: circleFrame)
nodeTitle.textAlignment = NSTextAlignment.Center

nodeTitle.font =  UIFont(name: "Helvetica", size: 50)
nodeTitle.text = "A"

containerView.addSubview(nodeTitle)


let edgeFrame:CGRect = CGRect(x:containerFrame.width/2, y: containerFrame.height/2, width:10, height:100)

let edgeView:UIView = UIView(frame: edgeFrame)

edgeView.backgroundColor = UIColor.orangeColor()

edgeView.layer.transform = CATransform3DMakeRotation(45, 0, 0, 1)


containerView.addSubview(edgeView)

*/











