//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController {
    
    var mapView: GMSMapView?
 
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //google map camera
        GMSServices.provideAPIKey("AIzaSyAIM29ukb0TCL5WILbWtQAfBcamupyjqnY")
        let camera = GMSCameraPosition.camera(withLatitude: 25.047986, longitude: 121.517026, zoom: 8)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.settings.compassButton = true
        view = mapView

    }
    
    @objc func MarkerMapByJsonData() {
        
        //post
        let PostToServerJsonData = ["My_mail": FirstViewController.super_login_mail ,"what_did_you_need": "get_Current_position_GPS"]
        //guard let url = URL(string: "http://127.0.0.1:8080/service.php") else {return}
        guard let url = URL(string: FirstViewController.server_URL) else {return}
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
                        
                        DispatchQueue.main.async {  //GCD 多執行緒  若沒用 DispatchQueue 直接重新整理會gg

                            self.mapView?.clear()   //清除所有標記
                        
                            let nextLocation = CLLocationCoordinate2DMake(Double_lat_now, Double_lng_now)
                            
                            //動畫 2為速度 越大越慢
                            CATransaction.begin()
                            CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
                            //change camera
                            self.mapView?.animate(to: GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 16))
                            CATransaction.commit()
                            
                            let marker = GMSMarker()
                            marker.position = nextLocation
                            marker.map = self.mapView
                        }
                    }
                } catch let error{
                    print(error.localizedDescription)

                    let ErrorMessage = String(data: data, encoding: .utf8)
                    print("//////////////////////////////////////////////////////////////////////////")
                    print(ErrorMessage!)
                }
            }
        }.resume()
        
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(BarTitle: "目前位置")
        
        MarkerMapByJsonData()
        
        //clear timer
        if FirstViewController.My_timer_now != nil {
            FirstViewController.My_timer_now!.invalidate()
            FirstViewController.My_timer_now = nil
        }
        //update function at 10s
        FirstViewController.My_timer_now = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.MarkerMapByJsonData), userInfo: nil, repeats: true)
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


