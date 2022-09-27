//
//  DecibelSensor.swift
//  testMic
//
//  Created by Marcelo Araujo on 06/09/22.
//

import Foundation
import AVFoundation
import AVKit
import SwiftUI

class MicrophoneMonitor: ObservableObject {
    
    @State var ruidos: Ruidos? = nil
    
    
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    
    init(ruidos: Ruidos? = nil) {
        
        self.ruidos = ruidos
        
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    
                    print("Para usar o sensor de barulho é necessário aceitar.")
                }
            }
        }
        
        
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
    public func startMonitoring(controle: Bool) {
        if controle {
            
            audioRecorder.isMeteringEnabled = true
            audioRecorder.record()
            
            if timer == nil{
                timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            return
            
        } else{
            desliga()
        }
        
    }
    
    @objc func timerAction(){
        self.audioRecorder.updateMeters()
        let decibel = self.audioRecorder.averagePower(forChannel: 0)
        print(decibel)
        if decibel > (-25) {
            playSound(key: "mar")
            desliga()
        }
    }
    
    func desliga (){
        timer?.invalidate()
        timer = nil
        audioRecorder.stop()
        print("stop is calling")
        return
    }
}
