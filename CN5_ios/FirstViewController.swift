//
//  FirstViewController.swift
//  SlideMenuControllerSwift
//
//  Created by jerry on 2017/8/24.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var snoopy: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    ///private var currentTextField: UITextField?
    ///private var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snoopy.layer.shadowColor = UIColor.black.cgColor
        snoopy.layer.shadowOffset = CGSize(width: 5, height: 5)
        snoopy.layer.shadowOpacity = 0.7
        snoopy.layer.shadowRadius = 5
        
        //function auto updata by 5 sec
        //Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.get(_:)), userInfo: nil, repeats: true)
        //Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.post(_:)), userInfo: nil, repeats: true)
        
        

    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        currentTextField = textField
//    }
//
//    @objc func keyboardWillShow(_ note: Notification) {
//        if isKeyboardShown {
//            return
//        }
//
//        if (currentTextField != email && currentTextField != password) { ////
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
//    @objc func keyboardWillHide(_ note: Notification) {
//        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
//        let duration = TimeInterval(truncating: keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
//        UIView.animate(withDuration: duration, animations: { () -> Void in
//            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
//        })
//        isKeyboardShown = false
//    }
//
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registered(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisteredViewController") as! RegisteredViewController
        //self.showDetailViewController(vc, sender: self)
        self.show(vc, sender: self)

    }
    
    @IBAction func login(_ sender: Any) {
        
      
        //post to server if response OK do login else error
        // & if response ok post gps

        if email.text?.isEmpty ?? true {
            let alertController = UIAlertController(
                title: "提示",
                message: "請輸入正確mail",
                preferredStyle: .alert)

            // 建立[確認]按鈕
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("*** mail錯誤 ")
            })
            alertController.addAction(okAction)

            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
        }
        else if password.text?.isEmpty ?? true {
            // 建立一個提示框
            let alertController = UIAlertController(
                title: "提示",
                message: "請輸入正確密碼",
                preferredStyle: .alert)

            // 建立[確認]按鈕
            let okAction = UIAlertAction(
                title: "確認",
                style: .default,
                handler: {
                    (action: UIAlertAction!) -> Void in
                    print("*** 密碼錯誤")
            })
            alertController.addAction(okAction)

            // 顯示提示框
            self.present(
                alertController,
                animated: true,
                completion: nil)
        }
        else {
            ////else post  if post response OK do alert,change page,send email.textw    else login again
            
            
            
            
            
            let PostToServerJsonData = ["login_mail": email.text!, "login_password": password.text!]
            //let PostToServerJsonData = ["username": "kilo_loco", "tweet": "HelloWorld"]
            //guard let url = URL(string: "http://192.168.11.4:8080/service.php") else {return}
            guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
            //guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type") // 有些server加這行會GG
            guard let httpBody = try? JSONSerialization.data(withJSONObject: PostToServerJsonData, options: []) else {return}
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            let server_response = json["server_response"]
                            print("response json :",json)
                            
                            if server_response as! String? == "login_OKOK"{
                                // 建立一個提示框
                                let alertController = UIAlertController(
                                    title: "提示",
                                    message: "登入成功",
                                    preferredStyle: .alert)
                                
                                // 建立[確認]按鈕
                                let okAction = UIAlertAction(
                                    title: "確認",
                                    style: .default,
                                    handler: {
                                        (action: UIAlertAction!) -> Void in
                                        print("登入成功")
                                        
                                        ////換頁 傳值 email.text
                                        self.performSegue(withIdentifier: "send_loginData", sender: nil)
                                })
                                alertController.addAction(okAction)
                                
                                // 顯示提示框
                                self.present(
                                    alertController,
                                    animated: true,
                                    completion: nil)
                                
                            }
                            else if server_response as! String? == "login_Error"{
                                // 建立一個提示框
                                let alertController = UIAlertController(
                                    title: "提示",
                                    message: "帳號或密碼錯誤，請重新輸入",
                                    preferredStyle: .alert)
                                
                                // 建立[確認]按鈕
                                let okAction = UIAlertAction(
                                    title: "確認",
                                    style: .default,
                                    handler: {
                                        (action: UIAlertAction!) -> Void in
                                        print("帳號或密碼錯誤，請重新輸入")
                                })
                                alertController.addAction(okAction)
                                
                                // 顯示提示框
                                self.present(
                                    alertController,
                                    animated: true,
                                    completion: nil)
                                
                            }
                            else {
                                let ErrorMessage = String(data: data, encoding: .utf8)
                                print("////// BUG!! ////////","\n",ErrorMessage!)
                            }
                        }
                        
                        
                    } catch {
                        print(error)
                        
                        
                        /////if server response is not json or error ,print error code/////
                        //guard let data = data else{return} ///在if let data = data 外要加
                        let ErrorMessage = String(data: data, encoding: .utf8)
                        print("//////////////////////////////////////////////////////////////////////////","\n",ErrorMessage!)
                    }
                }
            }.resume()
            
            
            
            
        }
 
        
    }
    
    
    
    //點view keyboard 收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //點return keyboard 收起
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    
    
    
    
    ////send email.text to MainViewCV
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "send_loginData" { //sendData = Storyboard Segue id
            let mainViewController = segue.destination as! MainViewController //MainViewController = 接收的ViewController
            //mainViewController.receiveData = "helloworld!!!!!"
            mainViewController.loginData = email.text!
        }
    }

    
    ////post
    @IBAction func post(_ sender: Any) {
        let PostToServerJsonData = ["MyID": "0005"]
        //let PostToServerJsonData = ["username": "kilo_loco", "tweet": "HelloWorld"]
        //guard let url = URL(string: "http://192.168.11.4:8080/service.php") else {return}
        guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
        //guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type") // 有些server加這行會GG
        guard let httpBody = try? JSONSerialization.data(withJSONObject: PostToServerJsonData, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                    
                    
                    /////if server response is not json or error ,print error code/////
                    //guard let data = data else{return} ///在if let data = data 外要加
                    let ErrorMessage = String(data: data, encoding: .utf8)
                    print("//////////////////////////////////////////////////////////////////////////")
                    print(ErrorMessage!)
                }
            }
        }.resume()
        
    }
    
    ////get
    @IBAction func get(_ sender: Any) {
        let GetToServerData = "?MyID=0001"
        guard let url = URL(string: "http://127.0.0.1:8080/service.php" + GetToServerData) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)

                    let ErrorMessage = String(data: data, encoding: .utf8)
                    print("//////////////////////////////////////////////////////////////////////////")
                    print(ErrorMessage!)
                }
            }
        }.resume()
    }
    



}
