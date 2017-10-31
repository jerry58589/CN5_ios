//
//  TestViewController.swift
//  SlideMenuControllerSwift
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit
import GoogleMaps


class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")

        self.MarkerMapByJsonData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "test")
    }
    @objc func MarkerMapByJsonData(){
        
        ////
        /////// google map has bug ///////
        /////// runtime: UI API called from background thread: -[UIApplication applicationState] must be used from main thread only
        //        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
        //        //建中心點、整張map
        //        let camera = GMSCameraPosition.camera(withLatitude: 24.970457, longitude:121.266352, zoom: 16)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        let maker = GMSMarker()
        //        self.view = mapView
        
        ////
        
        //post
        let PostToServerJsonData = ["My_mail": "qqq" ,"what_did_you_need": "get_Current_position_GPS"]
        //let PostToServerJsonData = ["username": "kilo_loco", "tweet": "HelloWorld"]
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
                        print(json["lat_now"]!)
                        print(json["lng_now"]!)
                        
                        let Strgin_lat_now:String = json["lat_now"]! as! String
                        let Strgin_lng_now:String = json["lng_now"]! as! String
                        
                        let Double_lat_now:Double = Double(Strgin_lat_now)!
                        let Double_lng_now:Double = Double(Strgin_lng_now)!
                        
                        
                        print("OKOKOK=========11111")
                        let camera = GMSCameraPosition.camera(withLatitude: Double_lat_now, longitude: Double_lng_now, zoom: 16)
                        
                        DispatchQueue.main.async {  //GCD 多執行緒  若沒用 DispatchQueue 直接重新整理會gg
                            
                            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                            let maker = GMSMarker()
                            maker.position = CLLocationCoordinate2D(latitude: Double_lat_now, longitude: Double_lng_now)
                            maker.map = mapView     //建立標記
                            self.view = mapView
                            print("OKOKOK=========222222")
                            
                            //self.reloadInputViews()
                            
                        }
                        
                    }
                } catch let error{
                    print(error.localizedDescription)
                    
                    /////if server response is not json or error ,print error code/////
                    //guard let data = data else{return} ///在if let data = data 外要加
                    let ErrorMessage = String(data: data, encoding: .utf8)
                    print("//////////////////////////////////////////////////////////////////////////")
                    print(ErrorMessage!)
                }
                print("OKOKOK=========222222.5")
            }
            print("OKOKOK=========222222.55")
            }.resume()
        print("OKOKOK=========222222.555")
    }
}
