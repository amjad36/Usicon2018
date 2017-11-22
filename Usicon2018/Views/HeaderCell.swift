//
//  HeaderCell.swift
//  Usicon2018
//
//  Created by Amjad Khan on 22/11/17.
//  Copyright © 2017 JTEGroup. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell, NibLoadableView, ReusableView {
   
    @IBOutlet weak var imageCarouselView: ImageCarouselView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithData(_ data: Any?, indexPath: IndexPath?) {
        
        let images = [ UIImage(named: "1")!,
                   UIImage(named: "2")!,
                   UIImage(named: "3")!,
                   UIImage(named: "4")! ]
        
        imageCarouselView.images = images
    }
    
}
