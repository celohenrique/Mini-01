//
//  RuidoBranco.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 01/09/22.
//

import SwiftUI
import HalfASheet

struct ruidosIcon: View{
    
    @State var ruidos: Ruidos
    
    
    var body: some View{
        VStack{
            Image("\(ruidos.imagem)")
            Spacer()
                .frame(height: 15)
            Text(ruidos.nome)
                .font(Font.custom("SF Pro Rounded", size: 16))
                .foregroundColor(Color.white)
        }
    }
}

struct TelaInicial: View {

    @State var isPlaying: Bool = false //inicia falsa
    @State var timerOnOff: Bool = true
    @State var sensor: Bool = false
    @State var ativo: Bool = false
    @State var showSheet: Bool = false
    @State var toggleIsOn: Bool = false
    @State var tempo: Int?
    @ObservedObject private var mic = MicrophoneMonitor()
    
    @State var totalSegundos = 0
    
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
            ZStack{
                Image("Fundo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    LazyVGrid(columns: columns, alignment: .center, spacing: 60){
                        
                        ForEach(ruidos, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item, isPlaying: $isPlaying, timerOnOff: $timerOnOff, sensor: $sensor, ativo: $ativo, totalSegundos: $totalSegundos )){
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
                            .onTapGesture {
                                showSheet.toggle()
                            }
                    }
                }
                .navigationBarTitle("Sons")
            
                HalfASheet(isPresented: $showSheet){
                    VStack{
                        Toggle(isOn: $sensor, label: {
                            Text("Sensor de Barulho")
                                .font(.title2)
                                .onChange(of: sensor, perform: { newValue in
                                    if sensor && totalSegundos == 0 {
                                        ativo = true
                                       // print(ativo)
                                    } else {
                                        ativo = false

                                    }
                                })
                        })
                        Spacer()
                            .frame(height: 20)
                        Text("O sensor capta barulhos altos e reinicia o timer do último som selecionado. O microfone ficará ligado apenas quando o sensor estiver ligado")
                        Spacer()
                            .frame(height: 150)
                    }
                    
                }.height(.proportional(0.50))
            }
            
            
            
            //gatilho para controle do sensor
            .onChange(of: ativo ) {newValue in
                if ativo {
                    mic.startMonitoring(controle: ativo)
                } else {
                    mic.desliga()
                }
                
            }
            
            
            //reconhecer na tela de inicio
            .onChange(of: totalSegundos) {newValue in
                if sensor {
                    if totalSegundos == 0 {
                                ativo = true

                        }
                    }
                }
    
        }
    }
}
struct RuidoBranco_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicial()
    }
}

