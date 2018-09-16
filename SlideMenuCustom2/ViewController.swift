//
//  ViewController.swift
//  SlideMenuCustom2
//
//  Created by Studiogenesis Home on 16/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        createRightSwipeGesture(viewTarget: self)
    }



}

