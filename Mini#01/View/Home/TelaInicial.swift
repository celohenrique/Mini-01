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
    
    @State var ruidos = [Ruidos(imagem: "0", nome: "Ventilador", id: 0),
                         Ruidos(imagem: "1", nome: "Shushing", id: 1),
                         Ruidos(imagem: "2", nome: "Secador", id: 2),
                         Ruidos(imagem: "3", nome: "Ar-Condicionado", id: 3),
                         Ruidos(imagem: "4", nome: "Ondas", id: 4)]
    
    var body: some View {
        
        NavigationView{
            
            
            VStack(spacing: 50){
                
                Text("Sounds")
                    .font(.largeTitle)
                
                
                
                VStack(spacing: 40){
                    
                    HStack(spacing: 10){
                        
                        ForEach(linha1, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item)){
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                    
                    HStack(spacing: 10){
                        
                        ForEach(linha2, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item)){
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                    
                    HStack(spacing: 10){
                        
                        ForEach(linha3, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item)){
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                    
                    HStack(spacing: 10){
                        
                        ForEach(linha4, id: \.self){ item in
                            NavigationLink(destination: SegundaTela(ruidos: item)){
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 70)
                }
            }
            .padding()
            
            
        }
        
    }
}

struct RuidoBranco_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicial()
    }
}

