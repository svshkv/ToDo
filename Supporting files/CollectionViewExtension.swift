//
//  CollectionViewExtension.swift
//  ToDO
//
//  Created by Саша Руцман on 20.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import Foundation
import UIKit

extension ToDoTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! ToDoCollectionViewCell
        myCell.imageView.image = iconsArray[indexPath.row]
        myCell.imageView.image?.withRenderingMode(.alwaysOriginal)
        myCell.imageView.contentMode = .scaleAspectFit
        //myCell.backgroundColor = UIColor.white
        myCell.layer.cornerRadius = min(myCell.frame.size.height, myCell.frame.size.width) / 2.0
        myCell.layer.masksToBounds = true
        myCell.layer.borderWidth = 1
        myCell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        selectedIcon = indexPath.row
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        print("User tapped on item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
}
