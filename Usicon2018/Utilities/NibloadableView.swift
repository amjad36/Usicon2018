//
//  NibloadableView.swift
//  

import UIKit

protocol NibLoadableView: class, BaseViewCell {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

