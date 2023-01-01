//
//  SceneDelegate.swift
//  VocabIn
//
//  Created by bartek on 25/09/2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDelegate = AppDelegate()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if Auth.auth().currentUser != nil {
                let searchVC = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SearchVC"))
                initialViewController = searchVC
            } else {
                let welcomeVC = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: K.welcomeVC))
                initialViewController = welcomeVC
            }
        // Make sure you set an Storyboard ID for the view controller you want to instantiate
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

//let authListener = Auth.auth().addStateDidChangeListener { auth, user in
//    if user != nil {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = vc
//        self.window?.makeKeyAndVisible()
//    } else {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = vc
//        self.window?.makeKeyAndVisible()
//    }
//}

//        self.window = UIWindow(windowScene: scene as! UIWindowScene)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        var viewController: UIViewController;
//        let window = UIWindow(frame: UIScreen.main.bounds)
//
//        if Auth.auth().currentUser != nil {
//          // User is signed in.
//            viewController = storyboard.instantiateViewController(withIdentifier: "SearchVC")
//        } else {
//          // No user is signed in.
//            viewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
//        }
//        (withIdentifier: "WelcomeViewController")
//        if Auth.auth().currentUser != nil {
//            window.rootViewController = SearchVC()
//        } else {
//            window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
//        }
//        self.window = window
//        self.window?.rootViewController = viewController
//        self.window?.makeKeyAndVisible()
