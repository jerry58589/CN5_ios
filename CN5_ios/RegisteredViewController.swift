//
//  RegisteredViewController.swift
//  SlideMenuControllerSwift
//
//  Created by jerry on 2017/8/28.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class RegisteredViewController: UIViewController {

    @IBOutlet weak var snoopy: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var okpassword: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    
    ///private var currentTextField: UITextField?
    ///private var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigation bar back button is nil
        self.navigationItem.hidesBackButton = true
        
        //set bar title and color
        self.title = "註冊"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hex: "689F38")]
        
        snoopy.layer.shadowColor = UIColor.black.cgColor
        snoopy.layer.shadowOffset = CGSize(width: 5, height: 5)
        snoopy.layer.shadowOpacity = 0.7
        snoopy.layer.shadowRadius = 5
        
        email.placeholder = "EX. xxx@gmail.com"
        password.placeholder = "password"
        okpassword.placeholder = "請再次輸入密碼"
        phonenumber.placeholder = "EX. 0987654321"
        
    }

    
    //點view keyboard 收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "First") as! FirstViewController
        self.show(vc, sender: self)
        //self.showDetailViewController(vc, sender: self)
    }
    
    @IBAction func RegisteredOK(_ sender: Any) {
        //收起鍵盤
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        self.okpassword.resignFirstResponder()
        self.phonenumber.resignFirstResponder()
        
        
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: "註冊成功",
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                print("註冊成功")
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
        
        
    }

}
