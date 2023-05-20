//
//  BannerView.swift
//  GymCare
//
//  Created by Nguyễn Hà on 29/12/2022.
//

import UIKit

class BannerView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    private var banners: [BannerModel] = []
    private var index = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.delegate = self
        collectionView.registerCells(from: .bannerViewCell)
        collectionView.isPagingEnabled = true
    }

    private func setupView() {
        Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func reloadData(datas: [BannerModel]) {
        self.banners = datas
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = datas.count
        self.collectionView.reloadData()
    }

    private func getIndexFromItem() -> Int {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return 0}
        return indexPath.row
    }
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3//banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = BannerViewCell.dequeueReuse(collectionView: collectionView, indexPath: indexPath)
//        cell.fillData(data: banners[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let url = banners[indexPath.row].linkUrl {
//            self.openSafari(linkUrl: url)
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        index = getIndexFromItem()
        pageControl.currentPage = getIndexFromItem()
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width/2
//        for cell in collectionView.visibleCells {
//
//            var offsetX = centerX - cell.center.x
//            if offsetX < 0 {
//                offsetX *= -1
//            }
//
//            UIView.animate(withDuration: 0.2) {
//                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }
//            if offsetX > 50 {
//
//                let offsetPercentage = (offsetX - 50) / self.bounds.width
//                var scaleX = 1-offsetPercentage
//
//                if scaleX < 0.9 {
//                    scaleX = 0.9
//                }
//                UIView.animate(withDuration: 0.2) {
//                    cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
//                }
//            }
//        }
//    }
}

extension BannerView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }

}
