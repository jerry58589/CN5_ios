//
//  Test2ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "test2")
    }
    
}
