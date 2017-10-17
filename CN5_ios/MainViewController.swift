//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController {
    
    
    var receiveData: String!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("login_email.text = ",receiveData)
//        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
//        //建中心點
//        let camera = GMSCameraPosition.camera(withLatitude: 24.953647, longitude:121.225745, zoom: 16)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        view = mapView
//
//        //標記
//        let maker = GMSMarker()
//        maker.position = CLLocationCoordinate2D(latitude: 24.953647, longitude: 121.225745)
//        maker.map = mapView
//
//
//        //post
//        let PostToServerJsonData = ["MyID": "0005"]
//        //let PostToServerJsonData = ["username": "kilo_loco", "tweet": "HelloWorld"]
//        //guard let url = URL(string: "http://192.168.11.4:8080/service.php") else {return}
//        guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
//        //guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        //request.addValue("application/json", forHTTPHeaderField: "Content-Type") // 有些server加這行會GG
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: PostToServerJsonData, options: []) else {return}
//        request.httpBody = httpBody
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
//            if let data = data {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                        print(json)
//                        print(json["lat"]!)
//                        print(json["lng"]!)
//                        print(json["yourInputMyID"]!)
//
//
//
//
//
//
//                        //建中心點
////                        let camera = GMSCameraPosition.camera(withLatitude: 24.953647, longitude:121.225745, zoom: 16)
////                        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
////                        self.view = mapView
//
//                        //標記
////                        let maker = GMSMarker()
////                        maker.position = CLLocationCoordinate2D(latitude: json["lat"] as! CLLocationDegrees , longitude: json["lng"] as! CLLocationDegrees)
////                        maker.map = mapView
//                    }
//
//
//                } catch let error{
//                    print(error.localizedDescription)
//
//
//                    /////if server response is not json or error ,print error code/////
//                    //guard let data = data else{return} ///在if let data = data 外要加
//                    let ErrorMessage = String(data: data, encoding: .utf8)
//                    print("//////////////////////////////////////////////////////////////////////////")
//                    print(ErrorMessage!)
//                }
//            }
//        }.resume()
//
//        /////// google map has bug ///////
//        /////// runtime: UI API called from background thread: -[UIApplication applicationState] must be used from main thread only
//
//        //GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
//        //建中心點
//        //let camera = GMSCameraPosition.camera(withLatitude: 24.953647, longitude:121.225745, zoom: 16)
//        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        //view = mapView
//
//        //標記
//        //let maker = GMSMarker()
//        //maker.position = CLLocationCoordinate2D(latitude: 24.953647, longitude: 121.225745)
//        //maker.map = mapView
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "目前位置")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}


