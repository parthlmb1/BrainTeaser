//
//  Card.swift
//  BrainTeaser
//
//  Created by Parth Lamba on 21/03/18.
//  Copyright © 2018 Parth Lamba. All rights reserved.
//

import UIKit

class Card: UIView {
    let shapes = ["shape1", "shape2", "shape3", "shape4", "shape5", "shape6"]
    
    var currentShape: String!
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(displayP3Red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(6))]
        shapeImage.image = UIImage(named: currentShape)
    }
}
