//
//  backgroundView.swift
//  Mini#01
//
//  Created by Gustavo Assis on 06/10/22.
//

import SwiftUI
import AVFoundation


struct backgroundView: UIViewRepresentable {
    
    @Binding var videoAtual: String
    
    
    func makeUIView(context: Context) -> some UIView {
        print ("atual som é \(videoAtual)")
        return QueuePlayerUIView(frame: .zero, video: videoAtual)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do nothing here 
    }
}


class QueuePlayerUIView: UIView{
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
//    var videoA : String
    
    
    
    
   init(frame: CGRect, video: String? = nil) {
        super.init(frame: frame)
        
       playVideo(key: video ?? "")
       
       print ("atual som é \(String(describing: video))")
        
         func playVideo (key: String) {
            //Load video
            let fileUrl = Bundle.main.url(forResource: key, withExtension: "mp4")!
            let playerItem = AVPlayerItem(url : fileUrl)
            
            //Setup Player
            let abc = AVQueuePlayer(playerItem: playerItem)
            
            playerLayer.player = abc
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)

            //Loop
            playerLooper = AVPlayerLooper(player: abc, templateItem: playerItem)
            
            //Play
            abc.play()
             return
        }
    }


    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//struct backgroundView_Previews: PreviewProvider {
//    static var previews: some View {
//        backgroundView()
//    }
//}
