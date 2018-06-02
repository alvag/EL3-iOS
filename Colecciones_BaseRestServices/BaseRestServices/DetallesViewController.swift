//
//  DetallesViewController.swift
//  BaseRestServices
//
//  Created by Max Alva on 2/06/18.
//  Copyright © 2018 cibertec. All rights reserved.
//

import UIKit
import SDWebImage


class DetallesViewController: UIViewController {
    
    var itemData: Dictionary<String, AnyObject>!
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var foto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = itemData["name"] as! Dictionary<String, AnyObject>
        let title = name["title"] as! String
        let firstName = name["first"] as! String
        let lastName = name["last"] as! String
        self.nombre.text = title + " " + firstName + " " + lastName
        
        let picture = itemData["picture"] as! Dictionary<String, AnyObject>
        let urlPicture = picture["large"] as! String
        self.foto.sd_setImage(with: URL(string: urlPicture), completed: nil)

    }


}
