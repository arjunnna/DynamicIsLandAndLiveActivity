//
//  DynamicIsLandAndLiveActivityApp.swift
//  DynamicIsLandAndLiveActivity
//
//  Created by Malli on 03/04/23.
//

import SwiftUI

@main
struct DynamicIsLandAndLiveActivityApp: App {

    let center = UNUserNotificationCenter.current()
    
    init() {
        registerForNotification()
    }
    
    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {
                
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.1, *) {
                ContentView().onOpenURL { url in
                    guard let url = URLComponents(string: url.absoluteString) else { return }
                    if (url.queryItems?.first(where: { $0.name == "CourierNumber" })?.value) != nil {
                        // call courier
                    }
                }
            }
        }
    }
}
