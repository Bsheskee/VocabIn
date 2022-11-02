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
    
    var wordManager = WordManager()
    var wordData = [WordData]()
    var test = ["dog", "cat", "toy", "doll", "trash"]
    var meanings = [Meanings]()
    var definitions = [Definitions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        wordManager.delegate = self
    }


}
//MARK: - Tableview Datasource Methods
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(wordData.count)
        return wordData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(wordData[indexPath.row].meanings)"
        return cell
    }
}
//cell.textLabel?.text = "\(indexPath.row+1). \(wordData[indexPath.row].word)"
//cell.textLabel?.text = "\(wordData[indexPath.row].meanings)"

//MARK: - Searchbar methods
extension SearchVC: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let word = searchBar.text {
            wordManager.performRequest(word: word) { data in
                self.wordData = data
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

