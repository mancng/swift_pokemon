//
//  TypeTableViewCell.swift
//  pokemon
//
//  Created by Rachel Ng on 1/24/18.
//  Copyright © 2018 Rachel Ng. All rights reserved.
//

import UIKit

class TypeTableViewCell: UITableViewCell {

    @IBOutlet weak var displayNum: UILabel!
    
    @IBOutlet weak var displayName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
