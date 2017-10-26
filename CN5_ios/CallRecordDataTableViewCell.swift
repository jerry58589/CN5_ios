//
//  CallRecordDataTableViewCell.swift
//  CN5_ios
//
//  Created by jerry on 2017/10/25.
//  Copyright © 2017年 Yuji Hato. All rights reserved.
//

import UIKit

struct CallRecordDataTableViewCellData {
    
    init(NameText: String,PhoneNumberText: String ,TimeText: String ,IconImg: String ) {
        //self.imageUrl = imageUrl
        self.NameText = NameText
        self.PhoneNumberText = PhoneNumberText
        self.TimeText = TimeText
        self.IconImg = IconImg
    }
    //var imageUrl: String
    var NameText: String
    var PhoneNumberText: String
    var TimeText: String
    var IconImg: String
}

class CallRecordDataTableViewCell: CallRecordBaseTableViewCell {

    
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var PhoneNumberText: UILabel!
    @IBOutlet weak var TimeText: UILabel!
    @IBOutlet weak var IconImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        ////mian字體////
        //self.NameText?.font = UIFont.italicSystemFont(ofSize: 16)
        self.NameText?.font = UIFont.boldSystemFont(ofSize: 20)
        //self.NameText?.textColor = UIColor(hex: "9E9E9E")
        self.NameText?.textColor = UIColor.black
        
        self.PhoneNumberText?.textColor = UIColor(hex: "9E9E9E")
        self.PhoneNumberText?.font = UIFont.italicSystemFont(ofSize: 12)
        
        self.TimeText.font.withSize(12)
        
        

        //self.IconImg.image?.size.width()
        
    }
    
    override class func height() -> CGFloat {
        return 80
    }

    override func setData(_ data: Any?) {
        if let data = data as? CallRecordDataTableViewCellData {
            //self.dataImage.setRandomDownloadImage(80, height: 80)
            self.NameText.text = data.NameText
            self.PhoneNumberText.text = data.PhoneNumberText
            self.TimeText.text = data.TimeText
            
            if data.IconImg == "Call_in" {
                self.IconImg.image = UIImage(named: "Call_in")?.withRenderingMode(.alwaysTemplate)
                self.IconImg.contentMode = .scaleAspectFit
                self.IconImg.tintColor = UIColor(hex: "9E9E9E")
            }
            else if data.IconImg == "Call_out"{
                self.IconImg.image = UIImage(named: "Call_out")?.withRenderingMode(.alwaysTemplate)
                self.IconImg.contentMode = .scaleAspectFit
                self.IconImg.tintColor = UIColor(hex: "9E9E9E")
            }
            else if data.IconImg == "Missed"{
                self.IconImg.image = UIImage(named: "Missed")?.withRenderingMode(.alwaysTemplate)
                self.IconImg.contentMode = .scaleAspectFit
                self.IconImg.tintColor = UIColor.red
            }

        }
    }
    
}
