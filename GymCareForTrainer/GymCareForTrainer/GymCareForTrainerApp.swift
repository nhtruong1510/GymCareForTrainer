//
//  GymCareForTrainerApp.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 27/02/2023.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var topMost: UIViewController? {
        var topController = window?.rootViewController

        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }

        return topController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        firebase(application)
        return true
    }
}

@main
struct GymCareForTrainerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if ServiceSettings.shared.userInfo != nil {
                TabbarView()
                    .environment(\.colorScheme, .light)
            } else {
                ContentView()
                    .environment(\.colorScheme, .light)
            }
        }
    }
}
