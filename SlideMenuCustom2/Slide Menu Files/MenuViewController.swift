//
//  MenuViewController.swift
//  SlideMenuCustom2
//
//  Created by Studiogenesis Home on 16/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
   
    @IBOutlet weak var viewContainerSlideMenu: UIView!
    @IBAction func btnHomeTappedAction(_ sender: UIButton) {actionBtnHomeTapped(sender)}
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    @IBAction func btnCloseMenuOverlayAction(_ sender: UIButton) {actionbtnCloseMenuOverlay(sender)}
    
    var btnMenu: UIButton!
    var swipeRight: UISwipeGestureRecognizer!
    var swipeLeft: UISwipeGestureRecognizer!
    var BaseVC: BaseViewController!
    
    // LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func actionBtnHomeTapped(_ sender: UIButton) {
        let mainStoreboard: UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC = mainStoreboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(DVC, animated: true)
        
        BaseVC.btnShowMenu.tag = 10
        BaseVC.onSlideMenuButtonPressed(BaseVC.btnShowMenu)
    }
    
    func actionbtnCloseMenuOverlay(_ sender: UIButton) {
        
        let header = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        btnMenu.tag = 0
        btnMenu.isHidden = false
        
        self.swipeRight.isEnabled = true
        self.swipeLeft.isEnabled = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewContainerSlideMenu.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: header, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            self.btnCloseMenuOverlay.alpha = 0
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()            
        })
    }

}


extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameSectionsSlideMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        cell.labelTitle.text = nameSectionsSlideMenu[indexPath.row][0]
        
        if nameSectionsSlideMenu[indexPath.row][2] != "" {
            if let image = UIImage(named: nameSectionsSlideMenu[indexPath.row][2]) {
                cell.imageSection.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoreboard: UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
        let nameIdentifier = nameSectionsSlideMenu[indexPath.row][1]
        let DVC = mainStoreboard.instantiateViewController(withIdentifier: nameIdentifier)
        self.navigationController?.pushViewController(DVC, animated: true)
        
        BaseVC.btnShowMenu.tag = 10
        BaseVC.onSlideMenuButtonPressed(BaseVC.btnShowMenu)
    }
    
}
