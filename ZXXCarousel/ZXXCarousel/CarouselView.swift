//
//  CarouselView.swift
//  ZXXCarousel
//
//  Created by admin on 20/03/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

let kViewWidth = UIScreen.main.bounds.size.width
var kViewHeight = CGFloat(200)

let CellIdentifier = "CarouselItem"
class CarouselView: UIView {

    fileprivate lazy var carouselCollectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: kViewWidth, height: kViewHeight)
        layout.minimumLineSpacing = 0
        let carouselCollectionView:UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.backgroundColor = UIColor.cyan
        carouselCollectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        return carouselCollectionView
    }()
    
    fileprivate lazy var pageControl : UIPageControl = {
        let pageControl:UIPageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 1
        return pageControl
    }()
    
    var timer:Timer?
    
    var carouselModelArr : [CarouselModel]? {
        didSet {
            self.carouselCollectionView.reloadData()
            pageControl.numberOfPages = carouselModelArr?.count ?? 0
            
            let index = (carouselModelArr?.count ?? 0)*10
            self.carouselCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    
    init(Y: CGFloat,H:CGFloat) {
        kViewHeight = H
        super.init(frame: CGRect(x: 0, y: Y, width: kViewWidth, height: kViewHeight))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- setup UI
extension CarouselView {
    func setupUI() {
        self.addSubview(carouselCollectionView)
        self.addSubview(pageControl)
        //给pageControl添加约束
        let rightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10)
        let bottomConstraint:NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5)
        let heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        pageControl.superview?.addConstraint(rightConstraint)
        pageControl.superview?.addConstraint(bottomConstraint)
        pageControl.superview?.addConstraint(heightConstraint)
    }
}

//MARK:- collectionViewDataSource
extension CarouselView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000*(carouselModelArr?.count ?? 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionItem = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! CarouselCollectionViewCell
        let index = indexPath.item % carouselModelArr!.count
        collectionItem.carouselModel = carouselModelArr![index]
        return collectionItem
    }
    
}

//MARK:- collectionViewDelegate
extension CarouselView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + kViewWidth / 2
        pageControl.currentPage = Int(offset / kViewWidth) % (carouselModelArr?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

//MARK:- 添加计时器
extension CarouselView {
    func addTimer() {
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollToNextPage() {
        let offsetX = carouselCollectionView.contentOffset.x + kViewWidth//当前偏移量加上一页的宽度
        carouselCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
