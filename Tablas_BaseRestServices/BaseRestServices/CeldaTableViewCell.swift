//
//  CeldaTableViewCell.swift
//  BaseRestServices
//
//  Created by Max Alva on 2/06/18.
//  Copyright © 2018 cibertec. All rights reserved.
//

import UIKit
import SDWebImage

class CeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var email: UILabel!
    
    func initItem(itemData: Dictionary<String, AnyObject>!) {
    
        let name = itemData["name"] as! Dictionary<String, AnyObject>
        let title = name["title"] as! String
        let firstName = name["first"] as! String
        let lastName = name["last"] as! String
        self.nombre.text = title + " " + firstName + " " + lastName
        
        let email = itemData["email"] as! String
        self.email.text = email
        
        let picture = itemData["picture"] as! Dictionary<String, AnyObject>
        let urlPicture = picture["large"] as! String
        self.imagen.sd_setImage(with: URL(string: urlPicture), completed: nil)
    }
    
}
