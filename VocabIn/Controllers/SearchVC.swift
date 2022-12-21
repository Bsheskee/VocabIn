//
//  ViewController.swift
//  VocabIn
//
//  Created by bartek on 25/09/2022.
//

import UIKit
import AVFoundation

class SearchVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchPressed: UISearchBar!
    
    var wordManager = WordManager()
    var wordData = [WordData]()
    var searchButtonPressed = false
    var cellsCount = 0
    var cell = UITableViewCell()
    
    public var audioUrl = URL(string: "")
    var player: AVPlayer?
    var word = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FirstDefinitionCell", bundle: nil), forCellReuseIdentifier: "FirstDefinitionCell")
        tableView.register(UINib(nibName: "DefExampleCell", bundle: nil), forCellReuseIdentifier: "DefExampleCell")
        tableView.register(UINib(nibName: "DefinitionCell", bundle: nil), forCellReuseIdentifier: "DefinitionCell")
        tableView.register(UINib(nibName: "SynAntonCell", bundle: nil), forCellReuseIdentifier: "SynAntonCell")
        tableView.register(UINib(nibName: "pOsCell", bundle: nil), forCellReuseIdentifier: "pOsCell")
    }
}
//MARK: - Tableview Datasource Methods
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func isSynIndexZero() -> Int {
        if wordData[0].meanings[0].synonyms != [] {
            return 1
        } else {
            return 0
        }
    }
    func isSynIndexOne() -> Int {
        if wordData[0].meanings[1].synonyms != [] {
            return 1
        } else {
            return 0
        }
    }
    
    func isMeaningsIndexOne() -> Bool {
        if wordData[0].meanings.count > 1 {
            return true
        } else {
            return false
        }
    }
    
    func cellsCounter() -> Int {
        if wordData[0].meanings.count > 1 {
            if wordData[0].meanings[1].synonyms != nil {
                cellsCount = wordData[0].meanings[1].definitions.count + wordData[0].meanings[0].definitions.count + isSynIndexOne() + isSynIndexZero() + 1
            } else {
                cellsCount = wordData[0].meanings[1].definitions.count + wordData[0].meanings[0].definitions.count + isSynIndexZero()
            }
        } else if wordData[0].meanings[0].partOfSpeech != nil {
            if wordData[0].meanings[0].synonyms != nil {
                cellsCount = wordData[0].meanings[0].definitions.count + isSynIndexZero()
            } else {
                cellsCount = wordData[0].meanings[0].definitions.count
            }
        }
        return cellsCount
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchButtonPressed {
            if wordData[0].meanings[0].definitions.count >= 1 {
                cellsCount = cellsCounter()
            }
        }
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstDefinitionCell", for: indexPath) as! FirstDefinitionCell
            cell.entryName.text = wordData[0].word
            cell.partOfSpeech.text = wordData[0].meanings[0].partOfSpeech
            cell.phoneticTrans.text = wordData[0].phonetic
            cell.definition.text = "1.  \(wordData[0].meanings[0].definitions[0].definition)"
            cell.exampleLabel.text = "e.g. \(wordData[0].meanings[0].definitions[0].example ?? "")"
            return cell
        }
        
        let zeroIndexDefCount = wordData[0].meanings[0].definitions.count - 1
        let forPoS = zeroIndexDefCount + 1 + isSynIndexZero()
        let meaningsZeroMax = zeroIndexDefCount + isSynIndexZero()
        let minSubscript = zeroIndexDefCount + isSynIndexZero() + 1
        let maxSubscript = cellsCount - 1
        let maxIndex = maxSubscript - isSynIndexOne()
        let myIndex = minSubscript + 1

        if indexPath.row <= meaningsZeroMax {
            if indexPath.row <= zeroIndexDefCount {
                if wordData[0].meanings[0].definitions[indexPath.row].example == nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionCell
                    cell.definition.text = "\(indexPath.row + 1).  \(wordData[0].meanings[0].definitions[indexPath.row].definition)"
                    return cell
                } else if wordData[0].meanings[0].definitions[indexPath.row].example != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefExampleCell", for: indexPath) as! DefExampleCell
                    cell.exampleLabel.text = wordData[0].meanings[0].definitions[indexPath.row].example
                    cell.definition.text = "\(indexPath.row + 1).  \(wordData[0].meanings[0].definitions[indexPath.row].definition)"
                    return cell
                }
            } else if wordData[0].meanings[0].synonyms != [] {
                if indexPath.row == meaningsZeroMax {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SynAntonCell", for: indexPath) as! SynAntonCell
                    guard let synLokIndex = wordData[0].meanings[0].synonyms?.count else { return cell }
                    let synonymsArray = wordData[0].meanings[0].synonyms?[0..<synLokIndex]
                    cell.synAnton.text = synonymsArray?.joined(separator: " ,  ")
                    return cell
                }
            }
            
        } else if isMeaningsIndexOne() == true {
        
            if indexPath.row == forPoS {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pOsCell", for: indexPath) as! pOsCell
                cell.partOfSpeech.text = wordData[0].meanings[1].partOfSpeech
                return cell
            } else if indexPath.row > minSubscript && indexPath.row <= maxIndex {
                
                if wordData[0].meanings[1].definitions[safe: indexPath.row - myIndex]?.example == nil {
                    if let safeDefinition = wordData[0].meanings[1].definitions[safe: indexPath.row - myIndex]?.definition {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DefinitionCell", for: indexPath) as! DefinitionCell
                        cell.definition.text = "\(indexPath.row - minSubscript).  \(safeDefinition)"
                        return cell
                    }
                } else {
                    if let safeDefinition = wordData[0].meanings[1].definitions[safe: indexPath.row - myIndex]?.definition,
                    let safeExample = wordData[0].meanings[1].definitions[safe: indexPath.row - myIndex]?.example {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "DefExampleCell", for: indexPath) as! DefExampleCell
                        cell.exampleLabel.text = safeExample
                        cell.definition.text = "\(indexPath.row - minSubscript).  \(safeDefinition)"
                        return cell
                    }
                }
            } else if wordData[0].meanings[1].synonyms != [] {
                
                if indexPath.row == maxSubscript {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SynAntonCell", for: indexPath) as! SynAntonCell
                    guard let synLokIndex = wordData[0].meanings[1].synonyms?.count else { return cell }
                    let synonymsArray = wordData[0].meanings[1].synonyms?[0..<synLokIndex]
                        cell.synAnton.text = synonymsArray?.joined(separator: " ,  ")
                    return cell
                }
            }
        }
        return cell
    }
}

//MARK: - Searchbar methods
extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // { (data: [WordData], [Definitions])
        word = searchBar.text!
        wordManager.performRequest(word: word) { data in
            self.wordData = data
            self.searchButtonPressed = true
            //                print(data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        fetchAudio(word: word) { data in
            DispatchQueue.main.async {
                self.wordData = data
            }
        }
    }
    
    func fetchAudio(word: String, comp: @escaping ([WordData])-> Void) {
        let wordURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
        let urlString = "\(wordURL)\(word)"
        
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
                (data,response,error) in
                guard let data = data, error == nil else {
                    print("Error occured while accessing data with URL")
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode([WordData].self, from: data)
                    comp(decoded)
                    if let sound = decoded[0].phonetics[0].audio,
                       let sound2 = decoded[0].phonetics[1].audio {
                        print("sound = \(sound)")
                        let nonEmpty = (sound != "") ? sound : sound2 //write switch cases or another ternary with more urls to choose from if both are empty
                        self.audioUrl = URL(string: nonEmpty)
                        //            url = URL(string: sound2)
                        
                        do {
                            try AVAudioSession.sharedInstance().setMode(.default)
                            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                            
                            self.player = AVPlayer(url: self.audioUrl!)
                            
                            guard let player = self.player else { return }
                            
                            player.play()
                        } catch let error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    //comp(decoded, entries.self)
                } catch {
                    print("Error occured while decoding JSON into Swift structure \(error)")
                }
            })
            dataTask.resume()
        }
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
