//
//  CallRecordViewController.swift
//  CN5_ios
//
//  Created by jerry on 2017/9/27.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

class CallRecordViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    //var mainContens: [String] = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8"]
    
    var NameText_Contens: [String] = []
    var PhoneNumberText_Contens: [String] = []
    var TimeText_Contens: [String] = []
    var IconImg_Contens: [String] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CallRecordDataTableViewCell.height()
    }
    
    // 設定是否可點選，點選後到SubContentsViewController
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
    //        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController
    //        self.navigationController?.pushViewController(subContentsVC, animated: true)
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NameText_Contens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CallRecordDataTableViewCell.identifier) as! CallRecordDataTableViewCell

        let data = CallRecordDataTableViewCellData(NameText: NameText_Contens[indexPath.row],PhoneNumberText: PhoneNumberText_Contens[indexPath.row] ,TimeText: TimeText_Contens[indexPath.row] ,IconImg: IconImg_Contens[indexPath.row])
        cell.setData(data)
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(CallRecordDataTableViewCell.self)
        // Do any additional setup after loading the view.
        
        ////post
        let PostToServerJsonData = ["My_mail": FirstViewController.super_login_mail ,"what_did_you_need": "get_CallRecord_History"]
        
        //let PostToServerJsonData = ["My_mail": FirstViewController.super_login_mail ,"what_did_you_need": "get_History_GPS"]
        //guard let url = URL(string: "http://192.168.11.4:8080/service.php") else {return}
        guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                        print(json)
                        print(json["type"]!)
                        print(json["yourLogin_mail_is"]!)
                        if let CallRecord_json = json["CallRecord_json"] as? [[String:String]] {
                            for CallRecord in CallRecord_json {
                                let Name = CallRecord["Name"]
                                let Call_type =  CallRecord["Call_type"]
                                let PhoneNumber =  CallRecord["PhoneNumber"]
                                let Time =  CallRecord["Time"]
                                
                                
                                print(Name!, Call_type!, PhoneNumber!, Time!)
                                self.NameText_Contens.append(Name!)
                                self.PhoneNumberText_Contens.append(PhoneNumber!)
                                self.TimeText_Contens.append(Time!)
                                self.IconImg_Contens.append(Call_type!)
   
                            }
                            DispatchQueue.main.async {  //GCD 多執行緒
                                self.tableView.reloadData()     //重新整理 tableView
                            }
                        }
                    }
                    
                    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "通話紀錄")
    }

}
