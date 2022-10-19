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
    @Binding var sizeIcon1: CGFloat
    @Binding var sizeIcon2: CGFloat
    @State var ruidos: Ruidos
    
    var body: some View{
        VStack{
            Image("\(ruidos.imagem)")
                .resizable()
                    .frame(width: sizeIcon1, height: sizeIcon2)
            
            Text(LocalizedStringKey(ruidos.nome))
                .font(Font.custom("SF Pro Rounded", size: TelaInicial().sizeFont)).foregroundColor(Color.white)
                .lineLimit(1)
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
    @State var spacer: CGFloat
    @State var sizeFont: CGFloat
    @State var sizeIcon1: CGFloat
    @State var sizeIcon2: CGFloat
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
        NotificationController().askPermissionNotification()
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight < 668 {
            self.spacer = 40
            self.sizeFont = 16
            self.sizeIcon2 = 70
            self.sizeIcon1 = 70
        }
        
        else if screenHeight > 895 {
            
            self.spacer = 70
            self.sizeFont = 22
            self.sizeIcon2 = 80
            self.sizeIcon1 = 80
            
        }
        
        else{
            self.spacer = 60
            self.sizeFont = 20
            self.sizeIcon2 = 70
            self.sizeIcon1 = 70
        }
    }
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 28/255, green: 13/255, blue: 47/255),
                    Color(red: 57/255, green: 36/255, blue: 89/255)
                ]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .all)
                
                VStack{
                    LazyVGrid(columns: columns, alignment: .center, spacing: spacer){
                        ForEach(ruidos, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item, isPlaying: $isPlaying, isPause: $isPause, timerOnOff: $timerOnOff, sensor: $sensor, ativo: $ativo, atualSom: $atualSom, totalSegundos: $totalSegundos, mic: $mic)){
                                ruidosIcon(sizeIcon1: $sizeIcon1, sizeIcon2: $sizeIcon2, ruidos: item )
                            }
                        }
                    }
                    .padding(.all)
                }
                .toolbar(){
                    ToolbarItem(placement: .automatic){
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .foregroundColor(Color.white)
                            .navigationTitle(LocalizedStringKey("sons"))
                            .onTapGesture {
                                mic.askPermissionMic()
                                showSheet.toggle()
                            }
                    }
                }
                HalfASheet(isPresented: $showSheet){
                    VStack{
                        Spacer()
                            .frame(height: 40)
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
                            .frame(height: 70)
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
