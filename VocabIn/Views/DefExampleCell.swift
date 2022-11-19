//
//  newDefinitionCell.swift
//  VocabIn
//
//  Created by bartek on 06/11/2022.
//

import UIKit

class DefExampleCell: UITableViewCell {

    @IBOutlet weak var exampleLabel: UILabel!

    @IBOutlet weak var definition: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        contentView.addSubview(definition)
//        contentView.addSubview(exampleLabel)
//        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
//        definition.translatesAutoresizingMaskIntoConstraints = false

    }

//    public func configureDefinitionCell(data: Data) {
//        definition.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor ).isActive = true
//    }

    //Stare:
    //    if definition != nil {
//            definition.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor ).isActive = true
//            print("configureDefinitionCell called")
//    }
//    if definition != nil {
//        definition.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor ).isActive = true
//        print("configureDefinitionCell called")
//        if exampleLabel != nil {
//            exampleLabel.isHidden = false
//            print("isHidden false called")
//        }
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
