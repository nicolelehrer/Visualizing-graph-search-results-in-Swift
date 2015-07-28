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
        var buttons = [UIView]()
        for subview in view.subviews{
            if subview.isKindOfClass(UIButton) && subview.tag > 0 {
                buttons.append(subview)
            }
        }
        return buttons
    }
    
    func edgesBetweenCircles(views:[UIView]){
        for aView in views{
            var edges = [Int]()
            if (search.dict[aView.tag] != nil){
                edges = search.dict[aView.tag]!
            }
            else{
                edges = [0]
            }
            for (var i=0; i < edges.count; i++){
                let aTag:Int = edges[i]
                let nextView:UIView = views[aTag-1]
                let edge = drawEdgeFrom(aView.layer.position, endPos: nextView.layer.position)
                view.layer.addSublayer(edge)

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
        view.layer.addSublayer(layer)
        return layer
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
            sender.backgroundColor = UIColor.greenColor()
            print("new start node is \(sender.tag)")
            nodeState = 1
        }
        else{
            stopNode = sender.tag
            updateBackgroundColorsAgainstTag(stopNode, priorSelectedTag:startNode)
            print("new stop node is \(sender.tag)")
            nodeState = 0
            sender.backgroundColor = UIColor.redColor()
        }

        //self.view.setNeedsDisplay()
    }
   
    @IBAction func recalc(sender:UIButton){
        search.emptyPreviousResults() //this is what precludes from auto calc on node selection
        if let sol = search.returnPathUsingBFS(startNode, endNode:stopNode){
            print(sol)
        }
    }

    
}

