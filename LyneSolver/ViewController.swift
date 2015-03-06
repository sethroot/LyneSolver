//
//  ViewController.swift
//  LyneSolver
//
//  Created by Seth Root on 3/5/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let solver = LyneSolver()
        solver.main()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

