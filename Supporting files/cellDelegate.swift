//
//  cellDelegate.swift
//  ToDO
//
//  Created by Саша Руцман on 21.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import Foundation

protocol cellDelegate: class {
    
    func completedButtonPressed(onCell: TableViewCell)
    
}
