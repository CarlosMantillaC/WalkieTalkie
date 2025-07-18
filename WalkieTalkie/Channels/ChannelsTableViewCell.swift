//
//  ChannelsTableViewCell.swift
//  WalkieTalkie
//

//

import UIKit

class ChannelsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
