//
//  MessageUserTableViewCell.swift
//  LawJerry
//
//  Created by Lê Đình Linh on 25/09/2023.
//

import UIKit

class MessageUserTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessageUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius: CGFloat = 10
        lblMessageUser.layer.cornerRadius = cornerRadius
        lblMessageUser.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        lblMessageUser.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
