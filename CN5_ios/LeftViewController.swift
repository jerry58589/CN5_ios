//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case history
    case account
    case callRecord
    case test
    case test2
    case nonMenu
}



protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["目前位置", "歷史紀錄", "我的帳戶", "通話紀錄", "Test", "Test2", "NonMenu"]
    var mainViewController: UIViewController!
    var historyViewController: UIViewController!
    var myAccountViewController: UIViewController!
    var callRecordViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    //
    var test2ViewController: UIViewController!
    var testViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let historyViewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        self.historyViewController = UINavigationController(rootViewController: historyViewController)
        
        let myAccountViewController = storyboard.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        self.myAccountViewController = UINavigationController(rootViewController: myAccountViewController)
        
        let callRecordViewController = storyboard.instantiateViewController(withIdentifier: "CallRecordViewController") as! CallRecordViewController
        self.callRecordViewController = UINavigationController(rootViewController: callRecordViewController)
        
        //
        let testViewController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        self.testViewController = UINavigationController(rootViewController: testViewController)
        
        
        let test2ViewController = storyboard.instantiateViewController(withIdentifier: "Test2ViewController") as! Test2ViewController
        self.test2ViewController = UINavigationController(rootViewController: test2ViewController)
        
        
        //
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .history:
            self.slideMenuController()?.changeMainViewController(self.historyViewController, close: true)
        case .account:
            self.slideMenuController()?.changeMainViewController(self.myAccountViewController, close: true)
        case .callRecord:
            self.slideMenuController()?.changeMainViewController(self.callRecordViewController, close: true)
            
        //
        case .test:
            self.slideMenuController()?.changeMainViewController(self.testViewController, close: true)
            
        case .test2:
            self.slideMenuController()?.changeMainViewController(self.test2ViewController, close: true)
        //
            
        case .nonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .history, .account, .callRecord, .nonMenu , .test, .test2:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .history, .account, .callRecord, .nonMenu, .test, .test2:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
