//
//  BaseViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    
    let imageMenuName = "loading_cmrad_dark"
    let imageMenuTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    let senderButton = UIButton()
    
    var menuVC = MenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuVC = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }

}

extension BaseViewController {
    
    // ACTIONS OPEN-CLOSE SLIDE MENU METHODS //////////////////////////////////
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton) {
        
        let header = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        if (sender.tag == 10)
        {
            // HIDE MENU
            swipeRight.isEnabled = true
            swipeLeft.isEnabled = false
            
            self.slideMenuItemSelectedAtIndex(-1);
            
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
        
        menuVC = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
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
                senderButton.tag = 0
                onSlideMenuButtonPressed(senderButton)
            case UISwipeGestureRecognizerDirection.left:
                senderButton.tag = 10
                onSlideMenuButtonPressed(senderButton)            
            default:
                break
        }
    }
    
}

extension BaseViewController {
    
    // OPEN VIEW WITH IDENTIFIER METHODS //////////////////////////////////
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("Home")
            break
        case 1:
            print("Play\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("PlayVC")
            break
        default:
            print("default\n", terminator: "")
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        let topViewController : UIViewController = self.navigationController!.topViewController!
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
}

extension BaseViewController {
    
    // SLIDE MENU BUTTON METHODS //////////////////////////////////
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        
        if imageMenuName != "" {
            if let image = UIImage(named: imageMenuName) {
                btnShowMenu.setImage(image, for: UIControlState())
            } else {
                btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
            }
        } else {
            btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        }
        
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.tintColor = imageMenuTintColor
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
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
