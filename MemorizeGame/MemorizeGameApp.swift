//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 8/2/2022.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    let viewModel = EmojiMemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
