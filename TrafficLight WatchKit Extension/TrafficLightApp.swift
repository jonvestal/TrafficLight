//
//  TrafficLightApp.swift
//  TrafficLight WatchKit Extension
//
//  Created by Jon Vestal on 6/1/21.
//

import SwiftUI

@main
struct TrafficLightApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                WatchStatsView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
