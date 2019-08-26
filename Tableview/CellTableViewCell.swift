//
//  CellTableViewCell.swift
//  Tableview
//
//  Created by CTS-MACMINI-1 on 22/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {


    @IBOutlet var img: UIImageView!
    @IBOutlet var lbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
