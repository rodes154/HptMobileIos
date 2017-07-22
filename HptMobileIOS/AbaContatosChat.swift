//
//  AbaContatosChat.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 05/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaContatosChat: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50.0
        chatTableView.allowsSelection = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaChat", for: indexPath) as! CelulaChat
        if(indexPath.row % 2 != 0){
            cell.labelLocal.isHidden = true
            cell.viewLocal.isHidden = true
            cell.labelRemoto.text = "Mensagem \(indexPath.row)"
        }else{
            cell.labelRemoto.isHidden = true
            cell.viewRemoto.isHidden = true
            cell.labelLocal.text = "At runtime, a view object handles the rendering of any content in its area and also handles any interactions with that content. The UIView class itself provides basic behaviorAt runtime, a view object handles the rendering of any content in its area and also handles any interactions with that content. The UIView class itself provides b"
        }
        
        cell.load()
        
        return cell
    }
    
    
}
