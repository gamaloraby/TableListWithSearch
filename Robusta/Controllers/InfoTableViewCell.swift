//
//  InfoTableViewCell.swift
//  Robusta
//
//  Created by gamal on 12/18/20.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var OwnerImg: UIImageView!
    @IBOutlet weak var RepoName: UILabel!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var CreationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
