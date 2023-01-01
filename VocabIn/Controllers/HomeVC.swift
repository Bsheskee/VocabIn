//
//  HomeVC.swift
//  VocabIn
//
//  Created by bartek on 09/10/2022.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {

    var wordManager = WordManager()
//    var wordData = [WordData]()
   

    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: K.welcomeVC, sender: self)
//            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchData() {
        let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) in
            guard let data = data, error == nil else
            {
                print("Error occured while accessing data with URL")
                return
            }
//            var wData = [WordData]()
            do
            {
//                wData = try JSONDecoder().decode([WordData].self, from: data)
            }
            catch
            {
                print("Error while decoding JSON Swift structure \(error)")
            }
//            self.wordData = wData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        dataTask.resume()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row+1). \(wordData[indexPath.row].meanings)"
        return cell
//        cell.detailTextLabel?.text = "\(wordData[indexPath.row].)"
    }

}

extension HomeVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let word = searchBar.text {
//            wordManager.fetchWord(word: word)
        }
    }
}
