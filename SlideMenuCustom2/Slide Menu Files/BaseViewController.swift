//
//  BaseViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let imageMenuIconName = "loading_cmrad_dark"
    let imageMenuIconTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    
    var menuVC = MenuViewController()
    var btnShowMenu = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuVC = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        btnShowMenu = UIButton(type: UIButtonType.system)
    }

}

extension BaseViewController {
    
    // ACTIONS OPEN-CLOSE SLIDE MENU METHODS //////////////////////////////////
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton) {
        
        
        print("sender: \(sender.tag)")
        
        let header = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        if (sender.tag == 10)
        {
            // HIDE MENU
            swipeRight.isEnabled = true
            swipeLeft.isEnabled = false
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.menuVC.viewContainerSlideMenu.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: header, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
                sender.isEnabled = true
                self.menuVC.btnCloseMenuOverlay.alpha = 0
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            return
        }
        
        // SHOW MENU
        swipeRight.isEnabled = false
        swipeLeft.isEnabled = true
        
        sender.isEnabled = false
        sender.tag = 10
        
        self.menuVC.btnMenu = sender
        self.menuVC.swipeRight = self.swipeRight
        self.menuVC.swipeLeft = self.swipeLeft
        self.menuVC.BaseVC = self
        
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()

        menuVC.viewContainerSlideMenu.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: header, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        menuVC.btnCloseMenuOverlay.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.menuVC.viewContainerSlideMenu.frame=CGRect(x: 0, y: header, width: UIScreen.main.bounds.size.width-80, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            self.menuVC.btnCloseMenuOverlay.alpha = 0.4
            
        }, completion:nil)
    }
    
}

extension BaseViewController {
    
    // SWIPE GESTURES METHODS //////////////////////////////////
    
    func createSwipesGestures(viewTarget: UIViewController) {
        swipeRight = UISwipeGestureRecognizer(target: viewTarget, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        viewTarget.view.addGestureRecognizer(swipeRight)
        
        swipeLeft = UISwipeGestureRecognizer(target: viewTarget, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        viewTarget.view.addGestureRecognizer(swipeLeft)
        
        swipeLeft.isEnabled = false
    }
    
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
            
            case UISwipeGestureRecognizerDirection.right:
                // show
                btnShowMenu.tag = 0
                onSlideMenuButtonPressed(btnShowMenu)
            case UISwipeGestureRecognizerDirection.left:
                // hide
                btnShowMenu.tag = 10
                onSlideMenuButtonPressed(btnShowMenu)
            default:
                break
        }
    }
    
}

extension BaseViewController {
    
    // SLIDE MENU BUTTON METHODS //////////////////////////////////
    
    func addSlideMenuButton(isBackButtonEnabled: Bool) {
        
        btnShowMenu = UIButton(type: UIButtonType.system)
        
        if imageMenuIconName != "" {
            if let image = UIImage(named: imageMenuIconName) {
                btnShowMenu.setImage(image, for: UIControlState())
            } else {
                btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
            }
        } else {
            btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        }
        
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.tintColor = imageMenuIconTintColor
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        
        if isBackButtonEnabled {
            self.navigationItem.setLeftBarButtonItems([createBackBarMenuIcon(), customBarItem], animated: true)
        } else {
            self.navigationItem.leftBarButtonItem = customBarItem;
        }
        
    }
    
    func createBackBarMenuIcon() -> UIBarButtonItem{
        
        let backImage = #imageLiteral(resourceName: "chevron_left_gray")
        let backButton = UIButton(type: UIButtonType.custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backButton.setImage(backImage, for: UIControlState())
        backButton.addTarget(self, action: #selector(BaseViewController.backToPreviousView), for: .touchUpInside)
        
        let leftBackButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        return leftBackButtonItem
    }
    
    @objc func backToPreviousView() {
        self.navigationController?.popToRootViewController(animated: true)
        isMainView = true
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    
}
