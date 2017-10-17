//
//  HistoryViewController.swift
//  CN5_ios
//
//  Created by jerry on 2017/9/27.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "歷史紀錄")
    }

}
