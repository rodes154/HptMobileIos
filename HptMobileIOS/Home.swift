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
    
    public var sessao: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    private func prepararTab(tab: Int){
        
        let navController = viewControllers![tab] as! UINavigationController
        
        switch tab {
        case 0:
            
            let vc = navController.topViewController as? AbaGeral
            vc?.sessao = sessao
            
            break
        case 1:
            
            let vc = navController.topViewController as? AbaClientes
            vc?.sessao = sessao
            
            break
        case 2:
            
            let vc = navController.topViewController as? AbaAgenda
            vc?.sessao = sessao
            
            break
        case 3:
            
            let vc = navController.topViewController as? AbaContatos
            vc?.sessao = sessao
            
            break
        case 4:
            
            let vc = navController.topViewController as? AbaPacotesTabela
            vc?.sessao = sessao
            
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
