//
//  SignInVC.swift
//  VocabIn
//
//  Created by bartek on 09/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        checkUserInfo()
//        print("viewDidAppear")
//    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self?.performSegue(withIdentifier: K.signInSegue, sender: self)
                }
//                self?.checkUserInfo()
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: K.signInSegue, sender: self)
            }
            }
        }
    }
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    
    
}


