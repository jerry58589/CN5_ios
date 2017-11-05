//
//  Test2ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {
    var firstViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "test2")
    }
    @IBAction func logout(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "First") as! FirstViewController    //“MainViewController” 為要換去的class ID , MainViewController 為要換去的class名稱（去掉.swift）
        //self.show(vc, sender: self)    //也可用show以外方法，可從button拉藍線到其他 view controller看
        //view = nil
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "First") as! FirstViewController
        self.firstViewController = UINavigationController(rootViewController: firstViewController)
        
        self.slideMenuController()?.changeMainViewController(self.firstViewController, close: true)
        
        //self.show(vc, sender: self)
        
        if FirstViewController.My_timer_callrecord != nil {
            FirstViewController.My_timer_now!.invalidate()
            FirstViewController.My_timer_now = nil
        }
        if FirstViewController.My_timer_history != nil {
            FirstViewController.My_timer_history!.invalidate()
            FirstViewController.My_timer_history = nil
        }
        if FirstViewController.My_timer_callrecord != nil {
            FirstViewController.My_timer_callrecord!.invalidate()
            FirstViewController.My_timer_callrecord = nil
        }
        
        
    }
    
}
