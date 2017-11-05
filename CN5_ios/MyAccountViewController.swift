//
//  MyAccountViewController.swift
//  CN5_ios
//
//  Created by jerry on 2017/9/27.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var snoopy: UIImageView!
    @IBOutlet weak var update_PhoneNumber: UITextField!
    @IBOutlet weak var update_Password: UITextField!
    @IBOutlet weak var input_PasswordAgain: UITextField!
    var nextViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snoopy.layer.shadowColor = UIColor.black.cgColor
        snoopy.layer.shadowOffset = CGSize(width: 5, height: 5)
        snoopy.layer.shadowOpacity = 0.7
        snoopy.layer.shadowRadius = 5
        
        update_PhoneNumber.placeholder = "請輸入新的裝置電話號碼"
        update_Password.placeholder = "請輸入新密碼"
        input_PasswordAgain.placeholder = "請再次輸入新密碼"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "我的帳戶")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func reload(_ sender: Any) {
        update_PhoneNumber.text = ""
        update_Password.text = ""
        input_PasswordAgain.text = ""
    }
    
    @IBAction func update_OK(_ sender: Any) {
        
        if (update_PhoneNumber.text?.length == 10) && (update_PhoneNumber.text?.hasPrefix("09"))! {
            //success
            if update_Password.text == input_PasswordAgain.text {
                Alert_inputPWD()//input old pwd and logout
            }
                
            else {
                //錯誤 兩次輸入密碼不同請重新輸入 clear 掉
                Alert(mseeage: "兩次輸入密碼不同請重新輸入", print_message: "兩次輸入密碼不同請重新輸入")
                update_Password.text = ""
                input_PasswordAgain.text = ""
            }
        }
        
        else if (update_PhoneNumber.text?.isEmpty)!{
            if update_Password.text == input_PasswordAgain.text && update_Password.text?.isEmpty == false{
                Alert_inputPWD()//input old pwd and logout
            }
            else {
                Alert(mseeage: "請輸入電話 or 密碼", print_message: "請輸入電話 or 密碼")
                //沒phone 沒pwd
            }
        }
        else {
            Alert(mseeage: "請輸入正確電話", print_message: "請輸入正確電話")
            //phone 錯誤
        }
        
    }
    
    func Alert(mseeage: String, print_message: String)  {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: mseeage,
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                print(print_message)
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    
    
    func Alert_logout(mseeage: String)  {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: mseeage,
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                
                self.update_Password.text = ""
                self.update_PhoneNumber.text = ""
                self.input_PasswordAgain.text = ""
                //登出
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                
                let firstViewController = storyboard.instantiateViewController(withIdentifier: "First") as! FirstViewController
                self.nextViewController = UINavigationController(rootViewController: firstViewController)
                
                self.slideMenuController()?.changeMainViewController(self.nextViewController, close: true)
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    
    func Alert_inputPWD() {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: "若要更改資料請輸入舊密碼",
            preferredStyle: .alert)
        
        // 建立 TextField
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "password"
            
            // 輸入屬性為密碼
            textField.isSecureTextEntry = true
        }
        
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "確認",
            style: UIAlertActionStyle.default) {
                (action: UIAlertAction!) -> Void in
                
                let password = (alertController.textFields?.last)!
                        as UITextField
                
                if password.text == "qqq"{
                    self.Alert_logout(mseeage: "變更成功，請重新登入")
                }
                else {
                    self.Alert(mseeage: "變更失敗，密碼錯誤", print_message: "變更失敗，密碼錯誤")
                }
        }
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
    


}
