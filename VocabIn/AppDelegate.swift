//
//  AppDelegate.swift
//  VocabIn
//
//  Created by bartek on 25/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        configureInitialViewController()
        return true
    }

    func configureInitialViewController() {
           let initialViewController: UIViewController
           let storyboard = UIStoryboard(name: "Main", bundle: nil)

           window = UIWindow()

           if Auth.auth().currentUser != nil {
               let mainViewController = storyboard.instantiateViewController(withIdentifier: "SearchVC")
               initialViewController = mainViewController
           } else {
               let loginViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
               initialViewController = loginViewController
           }
           window?.rootViewController = initialViewController
           window?.makeKeyAndVisible()
       }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//let storyboard = UIStoryboard(name: "Main", bundle: nil)
//window = UIWindow()
//
//if Auth.auth().currentUser != nil {
//    print(Auth.auth().currentUser)
////            let searchVC: UIViewController
//    let mainVC = storyboard.instantiateViewController(withIdentifier: "SearchVC")
//    window?.rootViewController = mainVC
//} else {
////            window = UIWindow(frame: UIScreen.main.bounds)
//
//    window!.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
//}
//
//window?.makeKeyAndVisible()
