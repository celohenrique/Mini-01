//
//  AudioManager.swift
//  Mini#01
//
//  Created by Gustavo Assis on 16/09/22.
//

import Foundation
import AVKit

var player: AVAudioPlayer!


func playSound(key: String, isPreview: Bool = false) {
    let url = Bundle.main.url(forResource: key, withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    do{
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        player = try AVAudioPlayer(contentsOf: url!)
        player.numberOfLoops = -1
        
        if isPreview {
            player?.prepareToPlay()
        } else {
            player?.play()
        }
        
    } catch {
        print("Url : \(key) nao encontrada")
    }
}

func playPause() {
    guard player != nil else {
        print("Instance of audio player not found")
        return
    }
    
    if player.isPlaying {
        player.pause()
    } else {
        player.play()
    }
}
 

