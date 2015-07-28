//
//  ViewController.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 7/27/15.
//  Copyright © 2015 Nicole Lehrer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var circleRad:CGFloat = 60.0
    let search = Search()
    var startNode = 1
    var stopNode = 10
    var nodeState = 0 //toggles between start when = 0 and end when = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.setAdjacents()
        if let sol = search.returnPathUsingBFS(startNode, endNode:stopNode){
            print(sol)
        }
        
        let sortedKeys = search.dict.keys.sort({$0.0 < $1.0 })
        circlesInGridWithNode(sortedKeys.first!, max: sortedKeys.last!)
        edgesBetweenCircles(getButtons())
    }

   
    func circlesInGridWithNode(min:Int, max:Int){
        
        let fixColCount = 4 //fix grid to be 4 nodes wide
        let spacer:CGFloat = 20.0
        let offSet:CGPoint = CGPointMake(circleRad/2, circleRad)

        var count = 0
        for var i = 0; i < fixColCount; i++ {
            for var j = 0; j < max/fixColCount + max%fixColCount; j++ {
                
                count++
                if count > max {
                    return
                }
                
                let circleFrame:CGRect = CGRect(x: offSet.x + CGFloat(i)*(circleRad+spacer),
                    y: offSet.y + CGFloat(j)*(circleRad+spacer),
                    width: circleRad,
                    height: circleRad)
                
                let button = buttonMaker(circleFrame)
                button.tag = count
                
                view.addSubview(button)
                view.layer.addSublayer(button.layer) //to arrage z position of layers
                view.addSubview(labelMaker(button.frame, title:"\(count)"))
            }
        }
    }
    
    func getButtons()->[UIView]{
        var buttons = [UIButton]()
        for subview in view.subviews{
            if subview.isKindOfClass(UIButton) && subview.tag > 0 {
                buttons.append(subview as! UIButton)
            }
        }
        return buttons
    }
    
    func edgesBetweenCircles(views:[UIView]){
        for aView in views{
            if let children = search.dict[aView.tag] {
                for child in children{
                    let aTag = child
                    let nextView = views[aTag-1]
                    
                    if(calcDistanceBetweenPoints(aView.layer.position, pointB:nextView.layer.position)<115){
                        view.layer.addSublayer(drawEdgeFrom(aView.layer.position, endPos: nextView.layer.position))
                    }
                    else{
                        view.layer.addSublayer(drawCurvedEdgeFrom(aView.layer.position, endPos: nextView.layer.position))
                    }
                    
                    print("\(aView.tag)  \(nextView.tag)")
                    print(calcDistanceBetweenPoints(aView.layer.position, pointB:nextView.layer.position))

                }
            }
        }
    }
    
    func drawEdgeFrom(startPos:CGPoint, endPos:CGPoint) -> CAShapeLayer{
        
        let path = UIBezierPath()
        path.moveToPoint(startPos)
        path.addLineToPoint(endPos)
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.strokeColor = UIColor.orangeColor().CGColor
        layer.lineWidth = 4.0
        layer.fillColor = UIColor.clearColor().CGColor
        layer.zPosition = -1
        return layer
    }
    
    func drawCurvedEdgeFrom(startPos:CGPoint, endPos:CGPoint) -> CAShapeLayer{
        
        let midPoint = calcMidpointBetweenPoints(startPos, pointB:endPos)
        let c1 = CGPointMake(midPoint.x+50, midPoint.y+50)
        
        let curverPath = UIBezierPath()
        curverPath.moveToPoint(startPos)
        curverPath.addCurveToPoint(endPos, controlPoint1: c1, controlPoint2: c1)  //not making use of second control point for now, see below
        
        let curveLayer = CAShapeLayer()
        curveLayer.path = curverPath.CGPath
        curveLayer.strokeColor = UIColor(red: 204/255.0, green: 85/255.0, blue: 0.0, alpha: 1).CGColor
        curveLayer.lineWidth = 4.0
        curveLayer.fillColor = UIColor.clearColor().CGColor
        
        curveLayer.zPosition = -1
        return curveLayer
        
        /* to determine control points better -
        could do collision detection using sprite kit and draw control point where no nodes are
        and/or take into acount the arctan of the two points to get angle for dot position
        final problem is that i am repeating paths in both directions*/
    }


    func calcDistanceBetweenPoints(pointA:CGPoint, pointB:CGPoint)->CGFloat{
        return sqrt(pow(pointA.x-pointB.x, 2)+pow(pointA.y-pointB.y, 2))
    }
    
    
    func findStartComponent(componentA:CGFloat, componentB:CGFloat)->CGFloat{
        if(componentA - componentB) < 0 {
            return componentA
        }
        return componentB
    }
    
    func calcMidpointBetweenPoints(pointA:CGPoint, pointB:CGPoint)->CGPoint{
        
        //since ur taking the abs delta, need to add to smaller component
        let startPoint = CGPointMake(findStartComponent(pointA.x, componentB: pointB.x), findStartComponent(pointA.y, componentB: pointB.y))
        
        return CGPointMake(fabs(CGFloat(pointA.x - pointB.x))/2+startPoint.x, fabs(CGFloat(pointA.y - pointB.y))/2+startPoint.y)
    }


    func buttonMaker(frame:CGRect) -> UIButton{
        let button = UIButton(type:.Custom)
        button.frame = frame
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = button.frame.width/2
        button.layer.borderWidth = 4.0
        button.layer.borderColor = UIColor.orangeColor().CGColor
        button.addTarget(self, action: "nodeSelected:", forControlEvents: .TouchUpInside)
        return button
    }
    
    func labelMaker(aFrame:CGRect, title:String) -> UILabel {
        let frameLabel:UILabel = UILabel(frame: aFrame)
        frameLabel.textAlignment = NSTextAlignment.Center
        frameLabel.font =  UIFont(name: "Helvetica", size: 20)
        frameLabel.text = title
        return frameLabel
    }
    
    func updateBackgroundColorsAgainstTag(selectedTag:Int, priorSelectedTag:Int){
        for subview in view.subviews{
            if subview.isKindOfClass(UIButton) &&
                subview.tag != selectedTag &&
                subview.tag != priorSelectedTag {
                subview.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    func nodeSelected(sender:UIButton){

        if (nodeState == 0){
            startNode = sender.tag
            updateBackgroundColorsAgainstTag(startNode, priorSelectedTag:stopNode)
            sender.backgroundColor = UIColor(red: 168/255.0, green: 228/255.0, blue: 120/255.0, alpha: 1.0)
            print("new start node is \(sender.tag)")
            nodeState = 1
        }
        else{
            stopNode = sender.tag
            updateBackgroundColorsAgainstTag(stopNode, priorSelectedTag:startNode)
            print("new stop node is \(sender.tag)")
            nodeState = 0
            sender.backgroundColor = UIColor(red: 1.0, green: 153/255.0, blue: 155/255.0, alpha: 1)
        }

        //self.view.setNeedsDisplay()
    }
    
    
    func doAnimate(var count:Int, pathNodeTags:[Int]){
        let views = getButtons()
        UIView.animateWithDuration(0.5, animations: {
                let highlightedNode = views[pathNodeTags[count]-1]
                highlightedNode.backgroundColor = UIColor.orangeColor()
            }, completion: {
                (value: Bool) in
                count = count+1
                if count<pathNodeTags.count{
                    self.doAnimate(count, pathNodeTags:pathNodeTags)
                }
        })
    }

    @IBAction func recalc(sender:UIButton){
        search.emptyPreviousResults() //this is what precludes from auto calc on node selection
        if let sol = search.returnPathUsingBFS(startNode, endNode:stopNode){
            let reversed = Array(sol.reverse())
            print(reversed)
            doAnimate(0, pathNodeTags:reversed)
        }
    }

    
}

