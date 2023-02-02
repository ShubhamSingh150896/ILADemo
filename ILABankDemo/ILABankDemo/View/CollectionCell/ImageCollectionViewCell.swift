//
//  ImageCollectionViewCell.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    
    var data:DataModel?{
        didSet{
            self.updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(){
        if let data = data{
            self.imageContainer.image = UIImage(named: data.imageName)
        }
    }
}
