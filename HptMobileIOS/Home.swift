//
//  Home.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 22/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Credenciais.getSessao())
        print(Credenciais.getAcesso())
        
        
    }
    private func prepararTab(tab: Int){
        
        let navController = viewControllers![tab] as! UINavigationController
        
        switch tab {
        case 0:
            
            let vc = navController.topViewController as? AbaGeral
            
            break
        case 1:
            
            let vc = navController.topViewController as? AbaClientes
            
            break
        case 2:
            
            let vc = navController.topViewController as? AbaAgenda
            
            break
        case 3:
            
            let vc = navController.topViewController as? AbaContatos
            
            break
        case 4:
            
            let vc = navController.topViewController as? AbaPacotesTabela
            
            break
        default:
            
            break
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        prepararTab(tab: item.tag)
        
    }
    
}
