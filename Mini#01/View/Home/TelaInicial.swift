//
//  RuidoBranco.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 01/09/22.
//

import SwiftUI



struct ruidosIcon: View{
    
    @State var ruidos: Ruidos
    
    var body: some View{
        
        VStack{
            Image("\(ruidos.imagem)")
                .resizable()
                .frame(width: 112, height: 112)
        }
        
    }
}

struct TelaInicial: View {
    

    var body: some View {
        
        NavigationView{
            
            
            ZStack {
                
                VStack(spacing: 50){
                    
                    
                    HStack{
                        Text("Sons")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
    
                    }
                    .padding(.leading)
                    .toolbar(){
                        ToolbarItem(placement: .automatic){
                            NavigationLink(destination: ToolBar(), label: {
                                Image(systemName: "mic.fill")
                                    .padding(.top, 20)
                                    
                            })
                        }
                    }
                        
                        HStack(spacing: 20){
                            
                            ForEach(linha1, id: \.self){ item in
                                NavigationLink(destination: SegundaTela(ruidos: item)){
                                    ruidosIcon(ruidos: item)
                                }
                            }
                        }
                        
                        HStack(spacing: 20){
                            
                            ForEach(linha2, id: \.self){ item in
                                NavigationLink(destination: SegundaTela(ruidos: item)){
                                    ruidosIcon(ruidos: item)
                                }
                            }
                        }
                        
                        HStack(spacing: 20){
                            
                            ForEach(linha3, id: \.self){ item in
                                NavigationLink(destination: SegundaTela(ruidos: item)){
                                    ruidosIcon(ruidos: item)
                                }
                            }
                        }
                        
                        HStack(spacing: 20){
                            
                            ForEach(linha4, id: \.self){ item in
                                NavigationLink(destination: SegundaTela(ruidos: item)){
                                    ruidosIcon(ruidos: item)
                                }
                            }
                        }
                        Spacer()
                            .frame(height: 80)
                    }
            }
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarTrailing){
//                        NavigationLink(destination: ToolBar(), label: {
//                            Image(systemName: "mic.fill")
//                        })
//                    }
//
//                    ToolbarItem(placement: .navigationBarLeading){
//                        navigationTitle("TESTE")
//
//
//
//
//                    }
//                }
        }.ignoresSafeArea(.all)
        
        
        
            
            
        }
}

struct RuidoBranco_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicial()
    }
}

