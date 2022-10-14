//
//  RuidoBranco.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 01/09/22.
//

import SwiftUI
import HalfASheet
import UserNotifications

struct ruidosIcon: View{
    @State var ruidos: Ruidos
    var body: some View{
        VStack{
            GeometryReader{ geo in
                Image("\(ruidos.imagem)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 0.8)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            Spacer()
                .frame(height: 50)
            Text(LocalizedStringKey(ruidos.nome))
                .font(Font.custom("SF Pro Rounded", size: 16))
                .foregroundColor(Color.white)
        }
    }
}
struct TelaInicial: View {
    
    @State var isPlaying: Bool = false
    @State var isPause: Bool = false
    @State var timerOnOff: Bool = true
    @State var sensor: Bool = false
    @State var ativo: Bool = false
    @State var showSheet: Bool = false
    @State var toggleIsOn: Bool = false
    @State var permissionalert: Bool = false
    @State var tempo: Int?
    
    @State var totalSegundos = 0
    @State var atualSom: String = ""
    
    @State var mic = MicrophoneMonitor.shared
    
    let columns = [
        GridItem(spacing: 20),
        GridItem(spacing: 20),
        GridItem(spacing: 20)
    ]
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    var body: some View {
        NavigationView{
            
            ZStack {
                Image("Fundo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    
                
                GeometryReader{ geo in
                    VStack{
                        LazyVGrid(columns: columns, alignment: .center, spacing: 60){
                            
                            ForEach(ruidos, id: \.self){ item in
                                NavigationLink(destination: SegundaTela(ruidos: item, isPlaying: $isPlaying, isPause: $isPause, timerOnOff: $timerOnOff, sensor: $sensor, ativo: $ativo, atualSom: $atualSom, totalSegundos: $totalSegundos, mic: $mic)){
                                    ruidosIcon(ruidos: item)
                                }
                            }
                        }
                        .padding(.all)
                        
                    }.padding(.top, 40.0).frame(width: geo.size.width, height: geo.size.height) // se precisar de espaco tirar esse padding

                }
                .toolbar(){
                    ToolbarItem(placement: .automatic){
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .foregroundColor(Color.white)
                            .onTapGesture {
                                mic.askPermissionMic()
                                showSheet.toggle()
                            }
                    }
                }
                .navigationBarTitle("Sons")
                HalfASheet(isPresented: $showSheet){
                    VStack{
                        Toggle(isOn: $sensor, label: {
                            Text(sensorTxt)
                                .font(.title2)
                                .onChange(of: sensor, perform: { newValue in
                                    
                                    if mic.permission == false {
                                        
                                        sensor = false
                                        permissionalert = true
                                        ativo = false
                                    }
                                    else{
                                        if sensor && totalSegundos == 0 {
                                            ativo = false
                                        }
                                        else {
                                            ativo = false
                                        }
                                    }
                                    
                                }).alert(isPresented: self.$permissionalert) {
                                    
                                    Alert(
                                        title: Text(micTxt),
                                        message: Text(concederMicTxt),
                                        primaryButton: .cancel(Text(cancelarTxt)),
                                        secondaryButton: .default(Text(configTxt), action: {
                                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }))
                                }
                        })
                        
                        Spacer()
                            .frame(height: 20)
                        Text(reiniciaSensorTxt)
                        Spacer()
                            .frame(height: 150)
                    }
                }.height(.proportional(0.50))
            }
            //Ativar o sensor
            .onChange(of: ativo ) {newValue in
                if ativo {
                    mic.startMonitoring(controle: ativo)
                    return
                } else {
                    mic.desliga()
                }
                
            }
            //reconhecer na tela de inicio
            .onChange(of: totalSegundos) {newValue in
                if sensor && totalSegundos == 0{
                    ativo = true
                }
            }
        }
    }
}
//struct RuidoBranco_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaInicial()
//    }
//}
