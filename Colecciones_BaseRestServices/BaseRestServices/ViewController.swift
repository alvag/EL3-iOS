//
//  ViewController.swift
//  BaseRestServices
//
//  Created by DAMII on 16/05/18.
//  Copyright © 2018 cibertec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var usersData: NSMutableArray = []
    @IBOutlet weak var collectionUsers: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !NetworkManager.isConnectedToNetwork() {
            return
        }
        
        collectionUsers.delegate = self
        collectionUsers.dataSource = self
        
        let url = "https://randomuser.me/api/?results=10"
        
        NetworkManager.sharedInstance.callUrlWithCompletion(url: url, params: nil, completion: { (finished, response) in
            let results = response["results"] as! NSArray
            self.usersData = NSMutableArray(array: results)
            self.collectionUsers.reloadData()
        }, method: .get)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionUsers.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CeldaCollectionViewCell
        
        let userData = self.usersData[indexPath.item] as! Dictionary<String, AnyObject>
        item.initItem(itemData: userData)
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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



}

