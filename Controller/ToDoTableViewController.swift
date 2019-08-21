//
//  ToDoTableViewController.swift
//  ToDO
//
//  Created by Саша Руцман on 14.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet var addToDoView: UIView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newToDoCollectionView: UICollectionView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    var effect : UIVisualEffect!
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView = UIVisualEffectView()
    let iconsArray = [#imageLiteral(resourceName: "money"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "news"),#imageLiteral(resourceName: "job"),#imageLiteral(resourceName: "idea"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "message")]
    var selectedIcon: Int?
    var selectedItemIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        detailsTextView.text = ""
        newToDoCollectionView.delegate = self
        newToDoCollectionView.dataSource = self
        //view.backgroundColor = .gray
        readyButton.layer.borderWidth = 1
        readyButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backButton.layer.borderWidth = 1
        
    }

    fileprivate func viewGetOut() {
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath)
        
        
        if indexPath.row == selectedItemIndex {
            if cell.textLabel?.text == toDoList[indexPath.row].details {
                cell.textLabel?.text = toDoList[indexPath.row].title
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
            cell.textLabel?.text = toDoList[indexPath.row].details
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        } else {
            
            cell.textLabel?.text = toDoList[indexPath.row].title
            cell.detailTextLabel?.text = ""
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        return cell
        //cell.detailTextLabel?.text = toDoList[indexPath.row].details
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            selectedItemIndex = indexPath.row
            viewShow()
            self.detailsTextView.text = toDoList[indexPath.row].details
            self.titleTextField.text = toDoList[indexPath.row].title
        }
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedItemIndex = indexPath.row
        UIView.transition(with: tableView,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
        
    }
    


    fileprivate func viewShow() {

        let mainWindow = UIApplication.shared.keyWindow!
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        mainWindow.addSubview(blurEffectView)
        blurEffectView.frame = CGRect(x: mainWindow.frame.origin.x, y: mainWindow.frame.origin.y, width: mainWindow.frame.width, height: mainWindow.frame.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mainWindow.addSubview(addToDoView)
        addToDoView.layer.cornerRadius = 10
        addToDoView.center = self.view.center
        addToDoView.backgroundColor = .gray
        newToDoCollectionView.backgroundColor = .gray
        addToDoView.alpha = 0
        self.addToDoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.4) {
            //self.effect = self.visualEffectView.effect
            self.addToDoView.alpha = 1
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        viewShow()
        
    }
    
    @IBAction func readyButtonPressed(_ sender: Any) {
        guard let title = titleTextField.text, let details = detailsTextView.text, let iconId = selectedIcon else { return }
        if selectedItemIndex == nil {
            addItem(title: title, details: details, iconId: iconId)
        } else {
            deleteItem(at: selectedItemIndex!)
            addItem(title: title, details: details, iconId: iconId)
            selectedItemIndex = nil
        }
        
        
        viewGetOut()
        tableView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        viewGetOut()
    }


}


