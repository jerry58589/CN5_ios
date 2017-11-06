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
    
    //login main
    static var super_login_mail: String!
    
    //timer
    static var My_timer_now : Timer?
    static var My_timer_history : Timer?
    static var My_timer_callrecord : Timer?
    
    var nextViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar back button is nil
        self.navigationItem.hidesBackButton = true
        
        //set bar title and color
        self.title = "登入"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hex: "689F38")]
        
        //陰影
        snoopy.layer.shadowColor = UIColor.black.cgColor
        snoopy.layer.shadowOffset = CGSize(width: 5, height: 5)
        snoopy.layer.shadowOpacity = 0.7
        snoopy.layer.shadowRadius = 5

        //預設文字（站位符）
        email.placeholder = "EX. xxx@gmail.com"
        password.placeholder = "password"

    }

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
        // if email = nil
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
            let PostToServerJsonData = ["login_mail": email.text!, "login_password": password.text!]
            //let PostToServerJsonData = ["username": "kilo_loco", "tweet": "HelloWorld"]
            guard let url = URL(string: "http://192.168.11.3:8080/service.php") else {return}
            //guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
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
                                        FirstViewController.super_login_mail = self.email.text
                                        
                                        let storyboard = UIStoryboard(name:"Main", bundle:nil)
                                        
                                        let MainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                        self.nextViewController = UINavigationController(rootViewController: MainViewController)
                                        
                                        self.slideMenuController()?.changeMainViewController(self.nextViewController, close: true)
                                        
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
    
    
    ////post
    @IBAction func post(_ sender: Any) {
        
        let PostToServerJsonData = ["MyID": "0005"]
        guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
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
