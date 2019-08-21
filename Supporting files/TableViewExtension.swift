//
//  TableViewExtension.swift
//  ToDO
//
//  Created by Саша Руцман on 21.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import Foundation
import UIKit

extension AllToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return notCompletedTasks.count
        case 1:
            return completedTasks.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        if section == 0 {
            label.text = "ToDo"
        } else {
            label.text = "Done"
        }
        label.font = UIFont(name: "Apple Color Emoji", size: 20)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath) as! TableViewCell
        if indexPath.section == 0 {
            cell.titleLabel.attributedText = .none
            cell.titleLabel.text = notCompletedTasks[indexPath.row].title
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.isCompletedButton.setImage(#imageLiteral(resourceName: "Квадрат").withRenderingMode(.alwaysOriginal), for: .normal)
            let iconId = notCompletedTasks[indexPath.row].iconId
            cell.iconImageView.image = iconsArray[Int(iconId)].withRenderingMode(.alwaysOriginal)
            cell.isCompletedButton.tag = (indexPath.section * 1000) + indexPath.row
        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: completedTasks[indexPath.row].title ?? " ")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.titleLabel.attributedText = attributeString
            cell.titleLabel.textColor = #colorLiteral(red: 0, green: 0.5843137255, blue: 0.8823529412, alpha: 1)
            cell.isCompletedButton.setImage(#imageLiteral(resourceName: "галочкаВКвадрате").withRenderingMode(.alwaysOriginal), for: .normal)
            let iconId = completedTasks[indexPath.row].iconId
            cell.iconImageView.image = iconsArray[Int(iconId)].withRenderingMode(.alwaysOriginal)
            cell.isCompletedButton.tag = (indexPath.section * 1000) + indexPath.row
        }
        cell.delegate = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(at: indexPath.section, at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            selectedItemIndex = indexPath.row
            viewShow()
            self.detailsTextView.text = toDoList[indexPath.row].details
            self.titleTextField.text = toDoList[indexPath.row].title
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemSection = indexPath.section
        selectedItemIndex = indexPath.row
        UIView.transition(with: tableView,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { tableView.reloadData() })
        
    }
}
