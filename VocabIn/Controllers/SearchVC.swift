//
//  ViewController.swift
//  VocabIn
//
//  Created by bartek on 25/09/2022.
//

import UIKit


class SearchVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchPressed: UISearchBar!
    
    var index = 0
    var wordManager = WordManager()
    var wordData = [WordData]()
    var searchButtonPressed = false
    var definitionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FirstDefinitionCell", bundle: nil), forCellReuseIdentifier: "FirstDefinitionCell")
        tableView.register(UINib(nibName: "DefExampleCell", bundle: nil), forCellReuseIdentifier: "DefExampleCell")
        tableView.register(UINib(nibName: "DefinitionCell", bundle: nil), forCellReuseIdentifier: "DefinitionCell")
        tableView.register(UINib(nibName: "SynDefCell", bundle: nil), forCellReuseIdentifier: "SynDefCell")
    }
}
//MARK: - Tableview Datasource Methods
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        if searchButtonPressed {
            if wordData[0].meanings[0].definitions.count >= 1 {
                definitionsCount = wordData[0].meanings[0].definitions.count
            }
        }
        return definitionsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstDefinitionCell", for: indexPath) as! FirstDefinitionCell
            cell.entryName.text = wordData[0].word
            cell.phoneticTrans.text = wordData[0].phonetic
            cell.definition.text = "1.  \(wordData[0].meanings[0].definitions[0].definition)"
            cell.exampleLabel.text = "e.g. \(wordData[0].meanings[0].definitions[0].example ?? "")"
            return cell
        }

        if wordData[0].meanings[0].definitions[safe: indexPath.row]?.example == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionCell
            print("example is nil current index: \(indexPath.row)")
            cell.definition.text = "\(indexPath.row + 1).  \(wordData[0].meanings[0].definitions[indexPath.row].definition)"
          
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefExampleCell", for: indexPath) as! DefExampleCell
            print("example is not nil current index: \(indexPath.row)")
            cell.exampleLabel.text = wordData[0].meanings[0].definitions[indexPath.row].example
            cell.definition.text = "\(indexPath.row + 1).  \(wordData[0].meanings[0].definitions[indexPath.row].definition)"
            return cell
        }


        //if synonym != nil {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SynDefCell", for: indexPath) as! SynDefCell
//        cell.synonym.text = wordData[0].meanings[0].definitions[indexPath.row].synonym
//        0.meanings[1].definitions[0].definition
    }
}


//MARK: - Searchbar methods
extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // { (data: [WordData], [Definitions])
        if let word = searchBar.text {
            wordManager.performRequest(word: word) { data in
                self.wordData = data
                self.searchButtonPressed = true
                //                print(data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        //        filtering and sorting methods + tableView.reloadData()
    }
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchBar.text?.count == 0 {
    ////            populate the data with the default value
    //
    //            DispatchQueue.main.async {
    //                searchBar.resignFirstResponder()
    //            }
    //        }
    //    }
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

