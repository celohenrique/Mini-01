//
//  BlurView.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 21/10/22.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context){
        
    }
}
