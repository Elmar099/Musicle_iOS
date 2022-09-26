//
//  PlayerView.swift
//  Musicle
//
//  Created by Yusif Imanov on 9/25/22.
//

import Foundation
import SwiftUI
import Firebase
import AVFoundation

struct PlayerView : View {
    @State var album : Album
    @State var song : Song
    
    @State var player = AVPlayer()
    
    @State var isPlaying : Bool = false
    
    var body : some View {
        ZStack {
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                AlbumArt(album: album, isWithText: false)
                Text(song.name).font(.title).fontWeight(.light).foregroundColor(.white)
                Text(song.time).font(.caption).fontWeight(.light).foregroundColor(.white)
                Spacer()
                
                ZStack{
                    Color.black.cornerRadius(20).shadow(radius: 10)
                    HStack {
                        Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle").resizable()
                        }).frame(width: 60, height: 60, alignment: .center).foregroundColor(Color.white.opacity(0.2)).padding(20)
                        
                        Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
                        }).frame(width: 90, height: 90, alignment: .center).foregroundColor(Color.red)
                        
                        Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle").resizable()
                        }).frame(width: 60, height: 60, alignment: .center).foregroundColor(Color.white.opacity(0.2)).padding(20)
                    }
                }.edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)
            }
        }.onAppear() {
            let storage = Storage.storage().reference(forURL: self.song.file)
            storage.downloadURL { (url, error) in
                if error != nil {
                    print(error)
                } else {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    }
                    catch {
                        //report for error
                    }
                    
                    player = AVPlayer(playerItem: AVPlayerItem (url: url!))
                    player.play()
                }
            }
        }
    }
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false {
            player.pause()
        } else {
            player.play()
        }
    }
    func next() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == album.songs.count {
                
            }else {
                song = album.songs[currentIndex + 1]
            }
        }
    }
    func previous() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == album.songs.count {
                
            }else {
                song = album.songs[currentIndex - 1]
            }
        }
    }
}
