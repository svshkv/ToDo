//
//  AllToDoViewController.swift
//  ToDO
//
//  Created by Саша Руцман on 21.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class AllToDoViewController: UIViewController {

    var selectedItemIndex: Int?
    var selectedItemSection: Int?
    var effect : UIVisualEffect!
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let iconsArray = [#imageLiteral(resourceName: "money"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "news"),#imageLiteral(resourceName: "job"),#imageLiteral(resourceName: "idea"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "message")]
    var selectedIcon: Int?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet var addToDoView: UIView!
    @IBOutlet weak var newToDoCollectionView: UICollectionView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.rowHeight = UITableView.automaticDimension
        toDoTableView.estimatedRowHeight = 600
        toDoTableView.tableFooterView = UIView()
        
        detailsTextView.text = ""
        newToDoCollectionView.delegate = self
        newToDoCollectionView.dataSource = self
        backButton.setImage(#imageLiteral(resourceName: "назад").withRenderingMode(.alwaysOriginal), for: .normal)
        addButton.setImage(#imageLiteral(resourceName: "плюс90").withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func viewGetOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.addToDoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.addToDoView.alpha = 0
            self.detailsTextView.text = ""
            self.titleTextField.text = ""
        }) {(success:Bool) in
            self.addToDoView.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    
    
    func viewShow() {
        
        let mainWindow = UIApplication.shared.keyWindow!
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        mainWindow.addSubview(blurEffectView)
        blurEffectView.frame = CGRect(x: mainWindow.frame.origin.x, y: mainWindow.frame.origin.y, width: mainWindow.frame.width, height: mainWindow.frame.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mainWindow.addSubview(addToDoView)
        addToDoView.layer.cornerRadius = 10
        addToDoView.center = self.view.center
        addToDoView.backgroundColor = .white
        newToDoCollectionView.backgroundColor = .white
        addToDoView.alpha = 0
        self.addToDoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.4) {
            //self.effect = self.visualEffectView.effect
            self.addToDoView.alpha = 1
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        viewGetOut()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let title = titleTextField.text, let details = detailsTextView.text, let iconId = selectedIcon else { return }
        if selectedItemIndex == nil {
            addItem(title: title, details: details, iconId: iconId)
        } else {
            deleteItem(at: selectedItemSection!, at: selectedItemIndex!)
            addItem(title: title, details: details, iconId: iconId)
            selectedItemIndex = nil
        }
        
        
        viewGetOut()
        toDoTableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        viewShow()
    }
}
