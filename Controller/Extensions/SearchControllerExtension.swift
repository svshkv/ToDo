//
//  SearchControllerExtension.swift
//  ToDO
//
//  Created by Саша Руцман on 26.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import Foundation
import UIKit

extension AllToDoViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFotSearchText(searchController.searchBar.text!)
    } 
    
    private func filterContentFotSearchText(_ searchText: String) {
        filteredCompletedTasks = completedTasks.filter() { (($0.title?.contains(searchText))!) || (($0.details?.contains(searchText))!)}
        filteredNotCompletedTasks = notCompletedTasks.filter() { (($0.title?.contains(searchText))!) || (($0.details?.contains(searchText))!)}
        toDoTableView.reloadData()
    }
    
}
