//
//  MusicleApp.swift
//  Musicle
//
//  Created by Elmar Imanov on 9/25/22.
//

import SwiftUI
import Firebase

@main
struct MusicleApp: App {
    let data = MyData()
    
    init() {
        FirebaseApp.configure()
        data.loadAlbums()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
