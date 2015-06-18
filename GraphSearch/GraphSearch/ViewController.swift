//
//  ViewController.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 6/17/15.
//  Copyright (c) 2015 Nicole Lehrer. All rights reserved.
//

import UIKit
//import Search

var containerFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
var containerView:UIView = UIView(frame: containerFrame)
var circleViews = [UIView]()
var circleRad:CGFloat = 60.0
var aSearch:Search = Search(test: "hello")

var stepper = 0
var startNode = 1
var stopNode = 10

var solutionNodes = [Int]()

var pickNodeState = 0

class ViewController: UIViewController {

    
    var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
 
    func calcGraph(){
        aSearch.findPath(startNode,target: stopNode) //awful names - rename - this gives you queue and visited
        solutionNodes = aSearch.getPath(startNode, target: stopNode) // this gives you solution
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerFrame = self.view.frame
        containerView = UIView(frame: containerFrame)
        containerView.backgroundColor = UIColor.grayColor()

        button.frame = CGRectMake(containerView.frame.size.width/2-100/2, containerView.frame.size.height-200, 100, 50)
        button.setTitle("STEPPER", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        containerView.addSubview(button)
        button.addTarget(self, action: "step", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(button)

        self.view.addSubview(containerView)
        
        calcGraph()
        makeCirclesInGridWith(3, colDim: 4)
        addEdgesToViews(circleViews)
        
//        for(var i = 0; i<aSearch.path.count; i++){
//            highLightViewWithTag(aSearch.path[i])
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func addLabelToFrame(aFrame:CGRect, title:String){
        let nodeTitle:UILabel = UILabel(frame: aFrame)
        nodeTitle.textAlignment = NSTextAlignment.Center
        nodeTitle.font =  UIFont(name: "Helvetica", size: 20)
        nodeTitle.text = title
        containerView.addSubview(nodeTitle)
    }
    
//    class Node: UIView {
//        
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            self.backgroundColor = UIColor.whiteColor()
//            self.layer.cornerRadius = frame.width/2
//            
//        }
//        required init(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//        
//    }
    
    func makeCirclesInGridWith(rowDim : Int, colDim : Int){

        let offSet:CGPoint = CGPointMake(20, 60)
        var count:Int = 0
        for(var i = 0; i < colDim; i++){
            for(var j = 0; j < rowDim; j++){
                count++
                let spacer:CGFloat = 20.0
                let circleFrame:CGRect = CGRect(x: offSet.x + CGFloat(i)*(circleRad+spacer),
                                                y: offSet.y + CGFloat(j)*(circleRad+spacer),
                                                width: circleRad,
                                                height: circleRad)
                
                
                var buttonNode = UIButton.buttonWithType(.Custom) as! UIButton
                buttonNode.frame = circleFrame
                buttonNode.backgroundColor = UIColor.whiteColor()
                buttonNode.layer.cornerRadius = buttonNode.frame.width/2
                buttonNode.layer.borderWidth = 4.0
                buttonNode.layer.borderColor = UIColor.orangeColor().CGColor
                buttonNode.addTarget(self, action: "nodeSelected:", forControlEvents: .TouchUpInside)


                containerView.addSubview(buttonNode)
                
                //need to do this in order to arrage z position of layers
                containerView.layer.addSublayer(buttonNode.layer)
                
                addLabelToFrame(circleFrame, title: "\(count)")
                buttonNode.tag = count
                circleViews.append(buttonNode)
            }
        }
    }
    
    
    
    func nodeSelected(sender:AnyObject){
        if (pickNodeState == 0){
            startNode = sender.tag
            println("new start node is \(sender.tag)")
            pickNodeState = 1
        }
        else{
            stopNode = sender.tag
            println("new stop node is \(sender.tag)")
            pickNodeState = 0
        }

        //calcGraph()
        //self.view.setNeedsDisplay()
    }
    
    func drawCurvedEdgeForCases(cases:[Int]){
        
        let c1:CGPoint = CGPointMake(300, 400)
        let c2:CGPoint = CGPointMake(450, 200)
        
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

            var edges = [Int]()
            if (aSearch.dict[aView.tag] != nil){
                edges = aSearch.dict[aView.tag]!
            }
            else{
                edges = [0]
            }
            
            for (var i=0; i < edges.count; i++){
                
                var aTag:Int = edges[i]
                let nextView:UIView = views[aTag-1]
                
                
                if(contains(aSearch.specialCases, aView.tag) &&
                    contains(aSearch.specialCases, nextView.tag)){
                        drawCurvedEdgeForCases(aSearch.specialCases)
                }
                else{
                    drawEdgeFrom(aView.layer.position, endPos: nextView.layer.position)
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
    
    
    
    
    
    func highLightViewWithTag(tag:Int, color:UIColor){
        circleViews[tag-1].backgroundColor = color
//        solutionNodes
        
    }
    
    
    func step() {
       // println(aSearch.visited)
        if(stepper < aSearch.visited.count){
          //  println(aSearch.visited[stepper])
            highLightViewWithTag(aSearch.visited[stepper], color: UIColor(red: CGFloat(stepper)/10.0,
                                                                green: CGFloat(stepper)/10.0,
                                                                blue: CGFloat(stepper)/10.0,
                                                                alpha: 1.0))
        }
        if(stepper == aSearch.visited.count){
            doAnimate(0)
        }
        
        stepper++
}


    func doAnimate(var tag:Int){
        
        if (tag < solutionNodes.count){
            
            UIView.animateWithDuration(0.5, animations: {
                let testView:UIView = circleViews[solutionNodes[tag]-1]
                testView.backgroundColor = UIColor.orangeColor()
                
            }, completion: {
                    (value: Bool) in
                    tag = tag+1
                    self.doAnimate(tag)
            })
        }
    }
    
    

    
    
    
}



    
    
    







