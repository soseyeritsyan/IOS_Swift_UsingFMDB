//
//  TableViewCell.swift
//  UsingFMDB
//
//  Created by Sose Yeritsyan on 5/23/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ parameter: User) {
        
        firstNameLbl.text = parameter.firstname
        lastNameLbl.text = parameter.lastname
        emailLbl.text = parameter.email

    }
    
    func getEmail() -> String? {
        return self.emailLbl.text
    }
    
}
