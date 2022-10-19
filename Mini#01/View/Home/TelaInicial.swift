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
                Image("\(ruidos.imagem)")

                Text(ruidos.nome)
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
            }
        else{
                self.spacer = 60
                self.sizeFont = 20
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
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                                        .padding(.all)
                    
                
            }
                .toolbar(){
                    ToolbarItem(placement: .automatic){
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .foregroundColor(Color.white)
                            .navigationTitle("Sons")
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
                            Text("Sensor de Barulho")
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
                                        title: Text("Microfone"),
                                        message: Text("Não foi concedido acesso ao microfone para esse aplicativo. Habilite o microfone nas configurações do sistema."),
                                        primaryButton: .cancel(Text("Cancelar")),
                                        secondaryButton: .default(Text("Configurações"), action: {
                                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }))
                                }
                        })
                        
                        Spacer()
                            .frame(height: 20)
                        Text("O sensor capta barulhos altos e reinicia o timer do último som selecionado. O microfone ficará ligado apenas quando o sensor estiver ligado")
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
//struct RuidoBranco_Previews: PreviewProvider {
//    static var previews: some View {
//        TelaInicial()
//    }
//}
