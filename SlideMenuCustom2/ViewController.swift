//
//  ViewController.swift
//  SlideMenuCustom2
//
//  Created by Studiogenesis Home on 16/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBAction func buttonPrintAction(_ sender: UIButton) { print("print!!!") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        createSwipesGestures(viewTarget: self)
    }

}

