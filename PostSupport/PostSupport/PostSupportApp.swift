//
//  PostSupportApp.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import SwiftUI

@main
struct PostSupportApp: App {
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
