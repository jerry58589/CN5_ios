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

    var mapView: GMSMapView?

    //建立struct 類似class
    struct GPS_information {
        let time: String
        let lat: CLLocationDegrees
        let lng: CLLocationDegrees
    }
    
    
    //實作 GPS_information，宣告空陣列為新創的自訂型態
    var GPS_ALL = [GPS_information]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("history_login_email.text = ",FirstViewController.super_login_mail)

        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
        //建中心點
        let camera = GMSCameraPosition.camera(withLatitude: 25.047986, longitude: 121.517026, zoom: 8)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
    }
    
    @objc func MarkerHistoryMapByJsonData() {
        GPS_ALL.removeAll() //remove old GPS_ALL
        
        ////post
        let PostToServerJsonData = ["My_mail": FirstViewController.super_login_mail ,"what_did_you_need": "get_History_GPS"]
        //guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
        guard let url = URL(string: "http://192.168.11.3:8080/service.php") else {return}
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
                                ////json data to string
                                let Strgin_lat_history:String = History_GPS["lat_history"]!
                                let Strgin_lng_history:String = History_GPS["lng_history"]!
                                let Strgin_time:String = History_GPS["time"]!
                                //string to double
                                let Double_lat_history:Double = Double(Strgin_lat_history)!
                                let Double_lng_history:Double = Double(Strgin_lng_history)!
                                
                                //在GPS_ALL 後面塞進新的GPS
                                self.GPS_ALL.append(GPS_information(time: Strgin_time, lat: Double_lat_history, lng: Double_lng_history))
                            }
                            DispatchQueue.main.async {  //GCD 多執行緒  若沒用 DispatchQueue 直接重新整理會gg
                                ////google map history
                                self.mapView?.clear()   //clear old marker
                                
                                //多點標記
                                for my_GPS in self.GPS_ALL {
                                    
                                    let marker = GMSMarker()
                                    marker.position = CLLocationCoordinate2D(latitude: my_GPS.lat, longitude: my_GPS.lng)
                                    marker.title = "Time"
                                    marker.snippet = my_GPS.time
                                    
                                    // last gps color is red and set camera
                                    if my_GPS.time == self.GPS_ALL.last?.time {
                                        //動畫 2為速度 越大越慢
                                        CATransaction.begin()
                                        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
                                        //change camera
                                        self.mapView?.animate(to: GMSCameraPosition.camera(withLatitude: my_GPS.lat, longitude: my_GPS.lng, zoom: 20))
                                        CATransaction.commit()
                                        
                                        marker.map = self.mapView
                                    }
                                    else {
                                        marker.icon = GMSMarker.markerImage(with: .lightGray)   //marker color = gray
                                        marker.opacity = 0.6    //不透明度
                                        marker.map = self.mapView
                                    }
                                }
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
        self.setNavigationBarItem(BarTitle: "歷史紀錄")
        
        //先執行一次不然要等10秒才會有標記
        MarkerHistoryMapByJsonData()
        
        //clear timer
        if FirstViewController.My_timer_history != nil {
            FirstViewController.My_timer_history!.invalidate()
            FirstViewController.My_timer_history = nil
        }
        
        //update function at 10s
        FirstViewController.My_timer_history = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.MarkerHistoryMapByJsonData), userInfo: nil, repeats: true)
    }

}
