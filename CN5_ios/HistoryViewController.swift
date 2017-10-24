//
//  HistoryViewController.swift
//  CN5_ios
//
//  Created by jerry on 2017/9/27.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit
import GoogleMaps

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         print("history_login_email.text = ",FirstViewController.super_login_mail)
        //print("222",MainViewController.login)
        
        
        
        
        ////post
        let PostToServerJsonData = ["My_mail": FirstViewController.super_login_mail ,"what_did_you_need": "get_History_GPS"]
        
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
                        if let History_json = json["History_json"] as? [[String:String]] {
                            for History_GPS in History_json {
                                let lat_history = History_GPS["lat_history"]
                                let lng_history =  History_GPS["lng_history"]
                                let time =  History_GPS["time"]
                                print(lat_history! , lng_history!, time!)
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
    

        
        ////google map history
        //google map key
        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
        
        //建中心點
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude:-122.0, zoom: 8)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        //多點標記
        
        //建立struct 類似class
        struct GPS_information {
            let name: String
            let lng: CLLocationDegrees
            let lat: CLLocationDegrees
        }
        var markerDict: [String: GMSMarker] = [:]
        
        //實作 GPS_information
        var GPS_ALL = [
            GPS_information(name: "Alaska1", lng: -122.0, lat: 37.36),
            GPS_information(name: "Alabama2", lng: -122.2, lat: 37.36)
        ]
        
        //在GPS_ALL 後面塞進新的GPS
        for i in stride(from:37.45, to:37.75, by:0.1) {     // from:開始, to:結束, by:間隔
            let GPS_TitleName = "Alaska" + String(i)
            GPS_ALL.append(GPS_information(name: GPS_TitleName, lng: -122.4, lat: i))     // 陣列 後面加上新的gps
        }
        
        //多點標記
        for my_GPS in GPS_ALL {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: my_GPS.lat, longitude: my_GPS.lng)
            marker.title = my_GPS.name
            marker.snippet = "Hey, this is \(my_GPS.name)"
            marker.map = mapView
            markerDict[my_GPS.name] = marker
            
        }
        
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "歷史紀錄")
    }

}
