//
//  ViewController.swift
//  GraphSearch
//
//  Created by Nicole Lehrer on 6/17/15.
//  Copyright (c) 2015 Nicole Lehrer. All rights reserved.
//

import UIKit
//import Search

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aSearch:Search = Search()
        aSearch.findPath(1,target: 10)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

