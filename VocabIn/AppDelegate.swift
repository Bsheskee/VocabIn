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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

          // In project directory storyboard looks like Main.storyboard,
          // you should use only part before ".storyboard" as its name,
          // so in this example name is "Main".
          let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
          
          // controller identifier sets up in storyboard utilities
          // panel (on the right), it is called 'Storyboard ID'
          let viewController = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC

          self.window?.rootViewController = viewController
          self.window?.makeKeyAndVisible()
        
        return true
    }

    func configureInitialViewController() {
           let initialViewController: UIViewController
           let storyboard = UIStoryboard(name: "Main", bundle: nil)

           window = UIWindow()
    
           if Auth.auth().currentUser != nil {
//               print("Current user = \(Auth.auth().currentUser)")
               let mainViewController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "SearchVC"))
               initialViewController = mainViewController
           } else {
               let loginViewController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: K.welcomeVC))
               initialViewController = loginViewController
           }
           window?.rootViewController = initialViewController
           window?.makeKeyAndVisible()
       }
//    storyboard.instantiateViewController(withIdentifier: "SearchVC")
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
