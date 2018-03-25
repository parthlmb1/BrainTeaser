//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Parth Lamba on 21/03/18.
//  Copyright © 2018 Parth Lamba. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPoint(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }
    
    let ANIM_DELAY = 0.8
    
    var originalConstants = [CGFloat]()
    var constraints = [NSLayoutConstraint]()
    
    init(constraints: [NSLayoutConstraint]) {
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Double?) {
        
        let d = delay == nil ? ANIM_DELAY * Double(NSEC_PER_SEC) : delay
        let time = DispatchTime.now() + (delay ?? d!)
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim?.toValue = self.originalConstants[index]
                moveAnim?.springBounciness = 12
                moveAnim?.springSpeed = 12
                
                if (index > 0) {
                    moveAnim?.dynamicsFriction += 10 + CGFloat(index)
                    moveAnim?.dynamicsMass = 2
                }
                
                let con  = self.constraints[index]
                con.pop_add(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
            } while (index < self.constraints.count)
        })
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation?, Bool) -> Swift.Void)!) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim?.toValue = NSValue(cgPoint: position)
        moveAnim?.springBounciness = 8.0
        moveAnim?.springSpeed = 8.0
        moveAnim?.completionBlock = completion
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
}






