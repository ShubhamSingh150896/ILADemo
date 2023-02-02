//
//  TableViewCell.swift
//  ILABankDemo
//
//  Created by Neosoft on 29/01/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    var data:DataModel?{
        didSet{
            self.updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateCell(){
        if let data = data{
            self.imageContainer.image = UIImage(named: data.imageName)
            self.imageName.text = data.title
        }
    }
    
    
}
