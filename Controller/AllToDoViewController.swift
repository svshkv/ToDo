//
//  AllToDoViewController.swift
//  ToDO
//
//  Created by Саша Руцман on 21.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class AllToDoViewController: UIViewController, cellDelegate {

    var selectedItemIndex: Int?
    var selectedItemSection: Int?
    var effect : UIVisualEffect!
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var blurEffectView = UIVisualEffectView()
    let iconsArray = [#imageLiteral(resourceName: "money"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "news"),#imageLiteral(resourceName: "job"),#imageLiteral(resourceName: "idea"),#imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "message")]
    var selectedIcon: Int?
    var ascendindSorting = true
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCompletedTasks: [ToDoItems] = []
    var filteredNotCompletedTasks: [ToDoItems] = []
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet var addToDoView: UIView!
    @IBOutlet weak var newToDoCollectionView: UICollectionView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupSettings()
    }

    
    fileprivate func setupSettings() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.rowHeight = UITableView.automaticDimension
        toDoTableView.estimatedRowHeight = 600
        toDoTableView.tableFooterView = UIView()
        
        detailsTextView.text = ""
        detailsTextView.layer.borderWidth = 1
        detailsTextView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        detailsTextView.layer.cornerRadius = 10
        
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        titleTextField.layer.cornerRadius = 10
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        newToDoCollectionView.delegate = self
        newToDoCollectionView.dataSource = self
        backButton.setImage(#imageLiteral(resourceName: "назад").withRenderingMode(.alwaysOriginal), for: .normal)
        addButton.setImage(#imageLiteral(resourceName: "плюс90").withRenderingMode(.alwaysOriginal), for: .normal)
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
    
    func completedButtonPressed(onCell: TableViewCell) {
        loadData()
        toDoTableView.reloadData()
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
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        
        ascendindSorting.toggle()
        
        if ascendindSorting == true {
            sortButton.image = #imageLiteral(resourceName: "сортПоВозр")
            ascendingSorting()
        } else {
            sortButton.image = #imageLiteral(resourceName: "сортПоУбыв")
            descendingSorting()
        }
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        if ascendindSorting == true {
            ascendingSorting()
        } else {
            descendingSorting()
        }
    }
    
    fileprivate func ascendingSorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            completedTasks = completedTasks.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
            notCompletedTasks = notCompletedTasks.sorted(by: { $0.date!.compare($1.date!) == .orderedAscending })
        } else {
            completedTasks = completedTasks.sorted(by: { $0.iconId > $1.iconId })
            notCompletedTasks = notCompletedTasks.sorted(by: { $0.iconId > $1.iconId })
        }
        toDoTableView.reloadData()
    }
    
    fileprivate func descendingSorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            completedTasks = completedTasks.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
            notCompletedTasks = notCompletedTasks.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
        } else {
            completedTasks = completedTasks.sorted(by: { $0.iconId < $1.iconId })
            notCompletedTasks = notCompletedTasks.sorted(by: { $0.iconId < $1.iconId })
        }
        toDoTableView.reloadData()
    }
    
}
