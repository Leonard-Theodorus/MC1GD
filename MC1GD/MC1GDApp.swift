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
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
