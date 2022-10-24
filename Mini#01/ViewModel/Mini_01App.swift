//
//  Mini_01App.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 29/08/22.
//

import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var notificacaopirocada = NotificationController()
    
    func applicationWillTerminate(_ application: UIApplication) {
        notificacaopirocada.cancelNotification()
        print("apago")
    }
}

@main
struct Mini_01App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LaunchScreen()
        }
    }
}
