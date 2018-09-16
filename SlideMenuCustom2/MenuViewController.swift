//
//  MenuViewController.swift
//  SlideMenuCustom2
//
//  Created by Studiogenesis Home on 16/9/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index: Int32)
}

class MenuViewController: UIViewController {
   
    @IBOutlet weak var viewContainerSlideMenu: UIView!
    @IBAction func btnHomeTappedAction(_ sender: UIButton) {actionBtnHomeTapped(sender)}
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    @IBAction func btnCloseMenuOverlayAction(_ sender: UIButton) {actionbtnCloseMenuOverlay(sender)}
    
    var btnMenu: UIButton!
    var delegate: SlideMenuDelegate?
    
    // LAOD
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func actionBtnHomeTapped(_ sender: UIButton) {
        let mainStoreboard: UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC = mainStoreboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(DVC, animated: true)
    }
    
    func actionbtnCloseMenuOverlay(_ sender: UIButton) {
        
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if (sender == self.btnCloseMenuOverlay) {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()            
        })
    }
    


}


extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoreboard: UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC = mainStoreboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(DVC, animated: true)
    }
}
