//
//  Vajra_WalletApp.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI

@main
struct Vajra_WalletApp: App {
    let ldkNode = LDKNodeManager.shared
    init() {
        ldkNode.start()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationWillTerminate(_ application: UIApplication) {
        try? LDKNodeManager.shared.stop()
    }
}
