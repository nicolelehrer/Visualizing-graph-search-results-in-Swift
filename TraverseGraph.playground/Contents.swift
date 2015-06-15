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
var circleRad:CGFloat = 100.0

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





let c1:CGPoint = circleViews[8].layer.position
let c2:CGPoint = circleViews[10].layer.position


//let c1View:UIView = UIView(frame: CGRectMake(c1.x, c1.y, 20, 20))
//c1View.backgroundColor = UIColor.whiteColor()
//containerView.addSubview(c1View)
//
//let c2View:UIView = UIView(frame: CGRectMake(c2.x, c2.y, 20, 20))
//c2View.backgroundColor = UIColor.redColor()
//containerView.addSubview(c2View)

var curverPath:UIBezierPath = UIBezierPath()
curverPath.moveToPoint(circleViews[6-1].layer.position)

curverPath.addCurveToPoint(circleViews[10-1].layer.position, controlPoint1: c1, controlPoint2: c2)

var curveLayer:CAShapeLayer = CAShapeLayer()
curveLayer.path = curverPath.CGPath
curveLayer.strokeColor = UIColor.orangeColor().CGColor
curveLayer.lineWidth = 4.0
curveLayer.fillColor = UIColor.clearColor().CGColor




containerView.layer.addSublayer(curveLayer)






