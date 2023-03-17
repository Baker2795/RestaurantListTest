//
//  RestApp.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import SwiftUI

@main
struct RestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RestaurantListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
