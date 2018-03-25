//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Parth Lamba on 20/03/18.
//  Copyright © 2018 Parth Lamba. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
     
        self.animEngine.animateOnScreen(delay: 1)
    }
}

