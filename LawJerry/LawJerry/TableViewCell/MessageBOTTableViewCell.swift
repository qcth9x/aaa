//
//  MessageBOTTableViewCell.swift
//  LawJerry
//
//  Created by Lê Đình Linh on 25/09/2023.
//

import UIKit

class MessageBOTTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessageBOT: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius: CGFloat = 10
        lblMessageBOT.layer.cornerRadius = cornerRadius
        lblMessageBOT.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        lblMessageBOT.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
