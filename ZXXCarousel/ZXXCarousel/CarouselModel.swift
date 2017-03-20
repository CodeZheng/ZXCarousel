//
//  CarouselModel.swift
//  ZXXCarousel
//
//  Created by admin on 20/03/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class CarouselModel: NSObject {

    var title:String = ""
    var pic_url:String = ""
    
    init(dic:[String:NSObject]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print("undefined key : \(key), value : \(value)")
    }
}
