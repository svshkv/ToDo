//
//  TableViewCell.swift
//  ToDO
//
//  Created by Саша Руцман on 20.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func isCompletedButtonPressed(_ sender: Any) {
        ///print("func isCompletedButtonPressed")
        //isCompletedButton.imageView?.image = #imageLiteral(resourceName: "галочка")
    }
}
