//
//  TestingAppDelegate.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 08/09/24.
//

import Foundation
import UIKit

final class TestingSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Logging.debug(message: "Running TestingSceneDelegate", _class: Self.self)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }
}

@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        clearAnySceneDelegateCacheFromTestsTarget(application)
        Logging.debug(message: "Running TestingAppDelegate", _class: Self.self)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfiguration: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = TestingSceneDelegate.self
        sceneConfiguration.storyboard = nil
        return sceneConfiguration
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    private func clearAnySceneDelegateCacheFromTestsTarget(_ application: UIApplication) {
        for sceneSession in application.openSessions {
            application.perform(Selector(("_removeSessionFromSessionSet:")), with: sceneSession)
        }
    }
}
