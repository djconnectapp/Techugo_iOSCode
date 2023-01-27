//
//  SideMenuNavigation.swift
//  MYclane
//
//  Created by keshav on 02/07/19.
//  Copyright © 2019 keshav. All rights reserved.
//

import UIKit

class SideMenuNavigation:  ENSideMenuNavigationController, ENSideMenuDelegate  {
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Init Functions
    func setLayout() {
        let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
        let VC = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
        if UserModel.sharedInstance().appLanguage == "0"{
            sideMenu = ENSideMenu(sourceView: self.view, menuViewController: VC, menuPosition:.left)
            
        }else{
            sideMenu = ENSideMenu(sourceView: self.view, menuViewController: VC, menuPosition:.right)
            
        }
        sideMenu?.delegate = self //optional
        //sideMenu?.menuWidth = view.frame.width - 50// optional, default is 160
        sideMenu?.menuWidth = view.frame.width
        sideMenu?.bouncingEnabled = false
        sideMenu?.allowPanGesture = false
        view.bringSubviewToFront(navigationBar)
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "sideMenuWillOpen"), object: nil)
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
        let VC = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
        VC.view.removeFromSuperview()
        print("sideMenuWillClose")
        
    }
    
    func sideMenuDidClose() {
        let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
        let VC = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
        VC.view.removeFromSuperview()
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
        let VC = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
        VC.view.removeFromSuperview()
        print("sideMenuDidOpen")
    }
}
