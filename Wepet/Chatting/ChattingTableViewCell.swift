//
//  ChattingTableViewCell.swift
//  Wepet
//
//  Created by jaegu park on 18/01/24.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    
    @IBOutlet var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
