//
//  ViewController.swift
//  BaseRestServices
//
//  Created by DAMII on 16/05/18.
//  Copyright © 2018 cibertec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var usersData: NSMutableArray = []
    @IBOutlet weak var tabla: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !NetworkManager.isConnectedToNetwork() {
            return
        }
        
        tabla.delegate = self
        tabla.dataSource = self
        
        let url = "https://randomuser.me/api/?results=50"
    
        NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
            let results = response["results"] as! NSArray
            self.usersData = NSMutableArray(array: results)
            self.tabla.reloadData()
        }, method: .get)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CeldaTableViewCell
        let userData = usersData[indexPath.row] as! Dictionary<String, AnyObject>
        
        cell.initItem(itemData: userData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalles", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles" {
            let id = sender as! NSIndexPath
            let item = usersData[id.row]
            let destino = segue.destination as! DetallesViewController
            destino.itemData = item as! Dictionary<String, AnyObject>
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}

