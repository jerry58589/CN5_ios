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

        snoopy.layer.shadowColor = UIColor.black.cgColor
        snoopy.layer.shadowOffset = CGSize(width: 5, height: 5)
        snoopy.layer.shadowOpacity = 0.7
        snoopy.layer.shadowRadius = 5
        
//        print("1")
//        let notificationName = Notification.Name("login")
//        NotificationCenter.default.addObserver(self,selector: #selector(RegisteredViewController.getUpdateNoti(noti:)), name: notificationName, object: nil)
//        print("2")
        
        // Do any additional setup after loading the view.
    }
//    @objc func getUpdateNoti(noti:Notification) {
//        print("3")
//        let userInfo = noti.userInfo as! [String: AnyObject]
//        let login_ID = userInfo["login_ID"] as! String
//        let login_password = userInfo["login_password"] as! String
//        let test = userInfo["test"] as! Int
//        print("4")
//        print("login_ID = " , login_ID)
//        print("login_password = " , login_password)
//        print("test = " , test)
//        print("5")
//        
//        
//    }
//    deinit {
//        print("6")
//        NotificationCenter.default.removeObserver(self)
//        print("7")
//    }


//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        currentTextField = textField
//    }
//    func keyboardWillShow(_ note: Notification) {
//        if isKeyboardShown {
//            return
//        }
//
//        if (currentTextField != email && currentTextField != password && currentTextField != okpassword && currentTextField != phonenumber) { ////
//            return
//        }
//        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
//        let duration = TimeInterval(truncating: keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
//        let keyboardFrameValue = keyboardAnimationDetail[UIKeyboardFrameBeginUserInfoKey]! as! NSValue
//        let keyboardFrame = keyboardFrameValue.cgRectValue
//
//        UIView.animate(withDuration: duration, animations: { () -> Void in
//            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -keyboardFrame.size.height)
//        })
//        isKeyboardShown = true
//    }
//
//    func keyboardWillHide(_ note: Notification) {
//        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
//        let duration = TimeInterval(truncating: keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
//        UIView.animate(withDuration: duration, animations: { () -> Void in
//            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
//        })
//        isKeyboardShown = false
//    }
    
    //點view keyboard 收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //點return keyboard 收起
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    
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
