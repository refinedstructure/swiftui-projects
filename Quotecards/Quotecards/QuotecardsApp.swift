//
//  QuotecardsApp.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import SwiftUI
import SwiftData


@main
struct QuotecardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Collection.self)
    }
}
