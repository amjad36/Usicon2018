//
//  BaseViewCell.swift
//  RecipeBook
//
//  Created by Amjad Khan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit

protocol BaseViewCell {
    func configureWithData(_ data: Any?, indexPath: IndexPath?)
}
