//
//  CustomTextField.swift
//  BrainTeaser
//
//  Created by Parth Lamba on 20/03/18.
//  Copyright © 2018 Parth Lamba. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 8
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect{
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect{
        return textRect(forBounds:bounds)
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
