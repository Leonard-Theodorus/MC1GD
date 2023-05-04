//
//  MC1GDApp.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI

@main
struct MC1GDApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = coreDataViewModel()
//    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            RootView(data : viewModel.chartDummyData())
                .environmentObject(viewModel)
        }
//        .onChange(of: scenePhase) { phase in
//            switch phase{
//                case .active:
//                    notificationModel.instance.setupNotifications(username: viewModel.getName())
//                case .background:
//                    notificationModel.instance.setupNotifications(username: viewModel.getName())
//                case .inactive:
//                    notificationModel.instance.setupNotifications(username: viewModel.getName())
//                @unknown default:
//                print("UNKNOWN ERROR")
//            }
//            
//        }
    }
}
