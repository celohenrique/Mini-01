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
    @Binding var sensor: Bool
    @Binding var ativo: Bool
    @Binding var atualSom: String
    @Binding var totalSegundos: Int
    @Binding var mic: MicrophoneMonitor
    
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
                    .font(Font.custom("SF Pro Rounded", size: 34, relativeTo: .title))
//                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Spacer()
                    .frame(height: 70)
                PickerScreen(ruidos: self.ruidos, sensor: $sensor, ativo: $ativo, timerOnOff: $timerOnOff,totalSegundos: $totalSegundos, isPlaying: $isPlaying)
                
                Spacer()
            } .onAppear{
                //MicrophoneMonitor(atualSom: "Deus")
                atualSom = ruidos.audio
                
            }
            .onDisappear {
                print(atualSom)
                mic.atualSom = atualSom
                print("atual som  OnDisapper CircleLap: \(atualSom)")
                
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
