//
//  AudioPlayer.swift
//  core
//
//  Created by Pablo Jair Angeles on 31/10/24.
//
import SwiftUI
import AVFoundation

class AudioPlayer: ObservableObject {
    var player: AVPlayer?
    
    func playAudio(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("URL no válida")
            return
        }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func pauseAudio() {
        player?.pause()
    }
    
    func stopAudio() {
        player?.pause()
        player = nil
    }
}
