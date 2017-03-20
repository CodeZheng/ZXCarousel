//
//  CarouselCollectionViewCell.swift
//  ZXXCarousel
//
//  Created by admin on 20/03/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import SDWebImage

class CarouselCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    var titleLabel = UILabel()
    
    var carouselModel : CarouselModel? {
        didSet {
            titleLabel.text = carouselModel?.title
            imageView.sd_setImage(with: URL(string: (carouselModel?.pic_url ?? "")!), placeholderImage: UIImage(named: "placehold"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselCollectionViewCell {
    func setupUI() {
        imageView.frame = self.bounds
        titleLabel.frame = CGRect(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30)
        titleLabel.backgroundColor = UIColor(white: 0.4, alpha: 0.3)
        titleLabel.textColor = .white
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
}
