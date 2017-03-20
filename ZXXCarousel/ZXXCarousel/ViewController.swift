//
//  ViewController.swift
//  ZXXCarousel
//
//  Created by admin on 15/03/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {
    
//    let carouselView = CarouselView(Y: 64, H: 200)//需要毛玻璃效果时Y为64
    let carouselView = CarouselView(Y: 0, H: 200)//不需要毛玻璃效果时Y，为0。

    var modelArr = [CarouselModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getArrayFromWeb()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func setupUI() {
//        self.automaticallyAdjustsScrollViewInsets = false//需要毛玻璃效果时设置（是否根据所在界面的navigationbar与tabbar的高度，自动调整scrollview的inset.默认是true）
        self.navigationController?.navigationBar.isTranslucent = false//不需要毛玻璃效果时设置
        self.view.addSubview(carouselView)
    }
    
    func getArrayFromWeb() {
        let manager = AFHTTPSessionManager()
        manager.get("http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"], progress: nil, success: { (task:URLSessionDataTask, json:Any) in
//            print("jsonData: \(json)")
            guard let dataDic = json as? [String : NSObject] else { return }
            guard let dataArr = dataDic["data"] as? [[String : NSObject]] else { return }
            for dic in dataArr {
                self.modelArr.append(CarouselModel(dic: dic))
            }
            self.carouselView.carouselModelArr = self.modelArr
        }) { (task:URLSessionDataTask?, error:Error) in
            print("error : \(error)")
        }
    }
}
