//
//  ExampleTableViewCell.swift
//  VocabIn
//
//  Created by bartek on 13/11/2022.
//

import UIKit

class DefinitionCell: UITableViewCell {

    @IBOutlet weak var definition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
