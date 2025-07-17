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
        setupUI()
    }
    
    private func setupUI() {
        customImageView.layer.cornerRadius =  customImageView.frame.height / 2
        customImageView.clipsToBounds = true
        customImageView.layer.borderColor = UIColor.systemIndigo.cgColor
        customImageView.layer.borderWidth = 2
        customImageView.contentMode = .scaleAspectFill
    }
}
