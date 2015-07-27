//
//  ViewController.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 7/27/15.
//  Copyright © 2015 Nicole Lehrer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var containerFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var circleViews = [UIView]()
    var circleRad:CGFloat = 60.0
    
    let search = Search()
    var startNode = 1
    var stopNode = 10
    
    var pickNodeState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.setAdjacents()
        let sol = search.returnPathUsingBFS(startNode, endNode:stopNode)
        print(sol)
        
        
        circlesInGridWith(4, colDim: 4)
        
    }

    func circlesInGridWith(rowDim:Int, colDim:Int){
        
        let offSet:CGPoint = CGPointMake(20, 60)
        
        var count = 0
        for var i = 0; i < colDim; i++ {
            for var j = 0; j < rowDim; j++ {
                
                count++
                let spacer:CGFloat = 20.0
                let circleFrame:CGRect = CGRect(x: offSet.x + CGFloat(i)*(circleRad+spacer),
                                                y: offSet.y + CGFloat(j)*(circleRad+spacer),
                                            width: circleRad,
                                           height: circleRad)
                
                let button = buttonMaker(circleFrame)
                button.tag = count
                
                view.addSubview(button)
                view.layer.addSublayer(button.layer) //to arrage z position of layers
                view.addSubview(labelMaker(button.frame, title:"\(count)"))

                circleViews.append(button)
            }
        }
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

        if (pickNodeState == 0){
            startNode = sender.tag
            updateBackgroundColorsAgainstTag(startNode, priorSelectedTag:stopNode)
            sender.backgroundColor = UIColor.greenColor()
            print("new start node is \(sender.tag)")
            pickNodeState = 1
        }
        else{
            stopNode = sender.tag
            updateBackgroundColorsAgainstTag(stopNode, priorSelectedTag:startNode)
            print("new stop node is \(sender.tag)")
            pickNodeState = 0
            sender.backgroundColor = UIColor.redColor()
        }

        //self.view.setNeedsDisplay()
    }
   
    @IBAction func recalc(sender:UIButton){
    
        search.emptyPreviousResults()
        let sol = search.returnPathUsingBFS(startNode, endNode:stopNode)
        print(sol)
    }
    
    
    func labelMaker(aFrame:CGRect, title:String) -> UILabel {
        let frameLabel:UILabel = UILabel(frame: aFrame)
        frameLabel.textAlignment = NSTextAlignment.Center
        frameLabel.font =  UIFont(name: "Helvetica", size: 20)
        frameLabel.text = title
        return frameLabel
    }
}

