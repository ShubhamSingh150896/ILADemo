//
//  TableImageViewCell.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func suffleList(index: Int)
}

class TableImageViewCell: UITableViewCell {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var delegate:ImageCellDelegate?
    //var currentPage: Int = 0
    
    var contentList:[DataModel]?{
        didSet{
            self.updateCell()
        }
    }
    
//    var pageSize: CGSize {
//        let layout = self.imageCollectionView.collectionViewLayout as! CustomCarouselFlowLayout
//        var pageSize = layout.itemSize
//        if layout.scrollDirection == .horizontal {
//            pageSize.width += layout.minimumLineSpacing
//        } else {
//            pageSize.height += layout.minimumLineSpacing
//        }
//        return pageSize
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        //self.setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupUI(){
        imageCollectionView.register(UINib(nibName: Constants.image_Collection_View_cell, bundle: nil), forCellWithReuseIdentifier: Constants.image_Collection_View_cell)
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.collectionViewLayout = CustomCollectionViewFlowLayout()
        imageCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    func updateCell(){
        pageControl.numberOfPages = contentList?.count ?? 0
        imageCollectionView.reloadData()
    }
//    
//    func setupLayout() {
//        let layout = self.imageCollectionView.collectionViewLayout as! CustomCarouselFlowLayout
//        layout.spacingMode = CustomCarouselFlowLayoutSpacingMode.fixed(spacing: 20)
//    }
        
}

//MARK: - UICollectionView Delegate & Datasource
extension TableImageViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.image_Collection_View_cell, for: indexPath) as! ImageCollectionViewCell
        cell.data = contentList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList?.count ?? 0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = imageCollectionView.indexPathForItem(at: center) {
            pageControl.currentPage = ip.item
            self.delegate?.suffleList(index: ip.item)
        }
    }
}

