//
//  SceneDelegate.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let coordinate = Coordinator(window: self.window!)
        coordinate.start()
        
    }



}

