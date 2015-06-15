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
var circleViews = [UIView]()
var circleRad:CGFloat = 50.0

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

////////////



let containerFrame:CGRect = CGRect(x: 0, y: 0, width: 500, height: 400)
let containerView:UIView = UIView(frame: containerFrame)
containerView.backgroundColor = UIColor.grayColor()
XCPShowView("View Identifier", containerView)


func addLabelToFrame(aFrame:CGRect, title:String){
    let nodeTitle:UILabel = UILabel(frame: aFrame)
    nodeTitle.textAlignment = NSTextAlignment.Center
    nodeTitle.font =  UIFont(name: "Helvetica", size: 20)
    nodeTitle.text = title
    containerView.addSubview(nodeTitle)
}


func makeCirclesInGridWith(rowDim : Int, colDim : Int){
    var count:Int = 0
    for(var i = 0; i < colDim; i++){
        for(var j = 0; j < rowDim; j++){
            count++
            let spacer:CGFloat = 20.0
            let circleFrame:CGRect = CGRect(x: CGFloat(i)*(circleRad+spacer),
                                        y: CGFloat(j)*(circleRad+spacer),
                                        width: circleRad,
                                        height: circleRad)
            
            let circleView = UIView(frame: circleFrame)
            circleView.layer.cornerRadius = circleRad/2
            circleView.backgroundColor = UIColor.whiteColor()
            containerView.addSubview(circleView)
            addLabelToFrame(circleFrame, "\(count)")
//            addEdgesToFrame(circleFrame)
//            drawEdgeFrom(circleFrame.origin, CGPointMake(100, 100))
            circleView.tag = count
            circleViews.append(circleView)
        }
    }
}

func addEdgesToViews(views:[UIView]){
    for aView:UIView in views{
        
        var edges:Array = dict[aView.tag]!
        for (var i=0; i<edges.count; i++){
            
            var aTag:Int = edges[i]
            let nextView:UIView = views[aTag-1]
            
            drawEdgeFrom(aView.layer.position, nextView.layer.position)
        }
    }
}

func drawEdgeFrom(startPos:CGPoint, endPos:CGPoint){
    var path:UIBezierPath = UIBezierPath()
    path.moveToPoint(startPos)
    path.addLineToPoint(endPos)
    
    var layer:CAShapeLayer = CAShapeLayer()
    layer.path = path.CGPath
    layer.strokeColor = UIColor.orangeColor().CGColor
    layer.lineWidth = 2.0
    layer.fillColor = UIColor.clearColor().CGColor
    
    containerView.layer.addSublayer(layer)
    
    
//    addCurveToPoint(CGPointMake(0, 100), CGPointMake(100, 100), CGPointMake(100, 0))

    
}






func highLightViewWithTag(tag:Int){
    circleViews[tag-1].backgroundColor = UIColor.yellowColor()
}

//////




makeCirclesInGridWith(3, 4)
addEdgesToViews(circleViews)

containerView.subviews.count

var start = 1
var stop = 10
var ans = 0

while( ans != start){
    ans = checkChildren(1, stop)
    stop = ans
    highLightViewWithTag(stop)
}

highLightViewWithTag(10)







///////////////////UI Bezier test




//
//
//var curverPath:UIBezierPath = UIBezierPath()
//curverPath.moveToPoint(CGPointMake(0, 0))
////curverPath.addLineToPoint(CGPointMake(100, 100))
//
//curverPath.addCurveToPoint(CGPointMake(200, 200), controlPoint1: CGPointMake(50, 150), controlPoint2: CGPointMake(100, 100))
//
//var curveLayer:CAShapeLayer = CAShapeLayer()
//curveLayer.path = curverPath.CGPath
//curveLayer.strokeColor = UIColor.redColor().CGColor
//curveLayer.lineWidth = 2.0
//curveLayer.fillColor = UIColor.clearColor().CGColor
//
//
//
//
//containerView.layer.addSublayer(curveLayer)


