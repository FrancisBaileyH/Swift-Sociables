//
//  NavController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-04-30.
//  
//

import Foundation


import UIKit


protocol NavControllerDelegate {
    func menuEventDidFire(action: AnyObject)
}



class NavController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    var customDelegate : NavControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: MenuTableViewController(), menuPosition:.Left)
        sideMenu?.delegate = self 
        sideMenu?.menuWidth = 180.0
        sideMenu?.bouncingEnabled = false
        
        view.bringSubviewToFront(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func segueEventDidFire(controller: UIViewController) {
        sideMenu?.hideSideMenu()
        pushViewController(controller, animated: true)
    }
    
    
    func nonSegueEventDidFire(action: AnyObject) {
        customDelegate?.menuEventDidFire(action)
    }
}



