//
//  CounterApp.swift
//  Counter
//
//  Created by Hoang Duc Nguyen on 14.09.20.
//

import SwiftUI

@main
struct CounterApp: App {
  var body: some Scene {
    WindowGroup {
      let appState = AppState(transaction: TransactionState(balance: 0))
      let store = Store(appState: appState)
      ContentView().environmentObject(store)
    }
  }
}
