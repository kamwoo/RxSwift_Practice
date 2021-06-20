//
//  Coordinator.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/12.
//

import Foundation
import UIKit

class Coordinator {
    let window : UIWindow
    
    init(window : UIWindow) {
        self.window = window
    }
    
    func start() {
        let RootViewController = RootViewController(viewModel: RootViewModel(articleServiceProtocol: ArticleService()))
        let NavigationRootViewContoller = UINavigationController(rootViewController: RootViewController)
        window.rootViewController = NavigationRootViewContoller
        window.makeKeyAndVisible()
    }
}
