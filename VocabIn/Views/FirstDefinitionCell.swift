//
//  DefinitionCell.swift
//  VocabIn
//
//  Created by bartek on 03/11/2022.
//

import UIKit

class FirstDefinitionCell: UITableViewCell {

    let searchVC = SearchVC()
    var wordData = [WordData]()
    
    
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var partOfSpeech: UILabel!
    
    @IBOutlet weak var entryName: UILabel!
    
    @IBOutlet weak var phoneticTrans: UILabel!
    
    @IBOutlet weak var definition: UILabel!
    @IBAction func set(_ sender: UIButton) {
    }
    
    @IBAction func pronunciationButton(_ sender: UIButton) {
        
        searchVC.fetchAudio(word: searchVC.word) { data in
            self.wordData = data
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FirstDefinitionCell: UISearchBarDelegate {
    
}
