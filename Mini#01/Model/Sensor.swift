//
//  DecibelSensor.swift
//  testMic
//
//  Created by Marcelo Araujo on 06/09/22.
//

import Foundation
import AVFoundation

class MicrophoneMonitor: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    
    private var currentSample: Int
    private let numberOfSamples: Int
    
    
   // var totalsound : Float
    
    @Published public var soundSamples: [Float]
    
    init(numberOfSamples: Int) {
        
        
        self.numberOfSamples = numberOfSamples
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
      //  self.totalsound = 0
        
        
        let audioSession = AVAudioSession.sharedInstance()
        
       
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
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
            startMonitoring()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3 , repeats: true, block: { (timer) in
            
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            
            
            let decibel = self.audioRecorder.averagePower(forChannel: 0)
            print(decibel)
//            if self.audioRecorder.averagePower(forChannel: 0) > (-20){
//            self.totalsound += self.audioRecorder.averagePower(forChannel: 0)
                
            //}
        })
    }
    
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
