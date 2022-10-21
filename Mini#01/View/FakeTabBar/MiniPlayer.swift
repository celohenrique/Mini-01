//
//  MiniPlayer.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 21/10/22.
//

import SwiftUI
import Foundation

struct MiniPlayer: View {
    
//    @State var ruidos2: Ruidos
    @Binding var isPlaying: Bool
    @Binding var isPause: Bool
    
    var body: some View {
        VStack{  
            HStack(spacing: 15){
              //  Image(ruidos2.background)
              //  Image("\(ruidos2.imagem)")
                Image("2") // passar a imagem do icone
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .cornerRadius(15)
                Text("pipipo") //passar o nome
             //   Text(LocalizedStringKey(ruidos2.nome))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    playPause()
                    if isPause {
                        isPause = false
                       //pausar o timer
                     //   CircleLap().cancelTimer()
                    }
                    else {
                        isPause = true
                        
                   //pause o timer
                        
                    }
                    
                    
                    
                }, label: {
                    Image(systemName: "pause.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                })
                
            }
            .padding(.horizontal)
            
        }
        .frame(height: 80)
//        .background(BlurView())
        //.background(Color(red: 47/255, green: 31/255, blue: 71/255))
        .offset(y: -10)
                
            
    }
}
