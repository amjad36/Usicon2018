//
//  ContentCell.swift
//  Usicon2018
//
//  Created by Amjad Khan on 22/11/17.
//  Copyright © 2017 JTEGroup. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithData(_ data: Any?, indexPath: IndexPath?) {
        
        if let item = data as? Item {
            itemLabel.text = item.title
            itemImageView.image = UIImage(named: item.imageName ?? String())
        }
    }
    
}
