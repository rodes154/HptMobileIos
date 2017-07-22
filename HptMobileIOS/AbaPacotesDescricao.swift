//
//  Aba5Descricao.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaPacotesDescricao: UIViewController {
    
    
    @IBOutlet weak var descricaoTextView: UITextView!
    
    private var descricaoVar: String = ""
    var rightBarButton = UIBarButtonItem(image: UIImage(named: "dotsIcon"), style: UIBarButtonItemStyle.done, target: self, action: #selector(AbaPacotesDescricao.botaoMaisClicked))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descricaoTextView.text = descricaoVar
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    public func preencherDescricao(indice: Int, descricao: String){
        descricaoVar = descricao
        title = "Pacote \(indice)"
    }
    func botaoMaisClicked(){
        
    }
    
}
