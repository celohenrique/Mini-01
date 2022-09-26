//
//  SegundaTela.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 12/09/22.
//

import SwiftUI



struct SegundaTela: View {
    
    @State var ruidos: Ruidos
    @Binding var isPlaying: Bool
    @Binding var timerOnOff: Bool
    
    @Binding var totalSegundos: Int
    
    var body: some View{
    
        ZStack{
        
            Image("Fundo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Image(ruidos.background)
                .resizable(resizingMode: .stretch)
            
            
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 160)
                Text(ruidos.nome)
                .font(.largeTitle)
                .foregroundColor(Color.white)
                Spacer()
                    .frame(height: 70)
                PickerScreen(ruidos: self.ruidos, timerOnOff: $timerOnOff,totalSegundos: $totalSegundos, isPlaying: $isPlaying)
                
                Spacer()
            } 
        } 
    }
}


//
//        struct SegundaTela_Previews: PreviewProvider {
//            static var previews: some View {
//                SegundaTela()
//            }
//        }
