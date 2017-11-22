//
//  ReusableView.swift
//  

import UIKit

protocol ReusableView: class, BaseViewCell {
    static var reusableIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
