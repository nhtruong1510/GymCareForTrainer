//
//  GymCareForTrainerApp.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 27/02/2023.
//

import SwiftUI

@main
struct GymCareForTrainerApp: App {
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
