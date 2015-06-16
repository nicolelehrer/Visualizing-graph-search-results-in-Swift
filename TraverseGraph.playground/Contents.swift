import UIKit
import XCPlayground


let someGraph = Graph()
var circleViews = [UIView]()
var circleRad:CGFloat = 100.0


let containerFrame:CGRect = CGRect(x: 0, y: 0, width: 550, height: 400)
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

class Node: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        self.layer.cornerRadius = frame.width/2
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            
            let aNode:Node = Node(frame: circleFrame)
            aNode.backgroundColor = UIColor.whiteColor()
            
            aNode.layer.borderWidth = 4.0
            aNode.layer.borderColor = UIColor.orangeColor().CGColor
            
            containerView.addSubview(aNode)
            //need to do this in order to arrage z position of layers
            
            containerView.layer.addSublayer(aNode.layer)
            
            addLabelToFrame(circleFrame, "\(count)")
            aNode.tag = count
            circleViews.append(aNode)
        }
    }
}


func drawCurvedEdgeForCases(cases:[Int]){
    
    circleViews[11].layer.position
    //    let c1:CGPoint = circleViews[11].layer.position
    //    let c2:CGPoint = circleViews[11].layer.position
    
    let c1:CGPoint = CGPointMake(450, 470)
    let c2:CGPoint = CGPointMake(650, 400)
    
    var curverPath:UIBezierPath = UIBezierPath()
    curverPath.moveToPoint(circleViews[cases[0]-1].layer.position)
    
    curverPath.addCurveToPoint(circleViews[cases[1]-1].layer.position, controlPoint1: c1, controlPoint2: c2)
    
    var curveLayer:CAShapeLayer = CAShapeLayer()
    curveLayer.path = curverPath.CGPath
    curveLayer.strokeColor = UIColor.orangeColor().CGColor
    curveLayer.lineWidth = 4.0
    curveLayer.fillColor = UIColor.clearColor().CGColor
    
    curveLayer.zPosition = -1
    containerView.layer.addSublayer(curveLayer)
    
}



func addEdgesToViews(views:[UIView]){
    for aView:UIView in views{
        var edges:Array = someGraph.dict[aView.tag]!
        for (var i=0; i<edges.count; i++){
            
            var aTag:Int = edges[i]
            let nextView:UIView = views[aTag-1]
            
            if(contains(someGraph.specialCases, aView.tag) &&
                contains(someGraph.specialCases, nextView.tag)){
                drawCurvedEdgeForCases(someGraph.specialCases)
            }
            else{
                drawEdgeFrom(aView.layer.position, nextView.layer.position)
            }
            
            
            
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
    layer.lineWidth = 4.0
    layer.fillColor = UIColor.clearColor().CGColor
    layer.zPosition = -1
    containerView.layer.addSublayer(layer)
    
}





func highLightViewWithTag(tag:Int){
    circleViews[tag-1].backgroundColor = UIColor.yellowColor()
    
}






//////
makeCirclesInGridWith(3, 4)
addEdgesToViews(circleViews)

containerView.subviews.count


for(var i = 0; i<someGraph.path.count; i++){
    someGraph.path
    highLightViewWithTag(someGraph.path[i])
}





////

someGraph.path

func doAnimate(var tag:Int){
    if (tag < someGraph.path.count){
        UIView.animateWithDuration(0.5, animations: {
            let testView:UIView = circleViews[someGraph.path[tag]-1]
            testView.backgroundColor = UIColor.redColor()

            }, completion: {
                (value: Bool) in
                println("hello")
                tag = tag+1
                doAnimate(tag)
        })
    }
}


doAnimate(0)







