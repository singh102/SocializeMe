//
//  ContactCell.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/14/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var contactPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
