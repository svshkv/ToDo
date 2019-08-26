//
//  TableViewCell.swift
//  ToDO
//
//  Created by Саша Руцман on 21.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    weak var delegate: cellDelegate?
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func isCompletedButtonPressed(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        if section == 0 {
            let item = notCompletedTasks[row]
            updateItem(item: item)
        } else {
            let item = completedTasks[row]
            updateItem(item: item)
        }
        delegate?.completedButtonPressed(onCell: self)
        
    }
}
