//
//  RuidoBranco.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 01/09/22.
//

import SwiftUI



struct ruidosInitialView: View{
    
    @State var ruidos: Ruidos
    
    var body: some View{
        
        VStack{
            Image("\(ruidos.imagem)")
                .resizable()
                .cornerRadius(18)
                .frame(width: 142, height: 142)
//            Text(ruidos.nome)
//                .font(.subheadline)
//                .fontWeight(.bold)
            
        }
    }
}

struct RuidoBranco: View {
    
    @State var ruidos = [Ruidos(imagem: "0", nome: "Ventilador", id: 0),
                         Ruidos(imagem: "1", nome: "Shushing", id: 1),
                         Ruidos(imagem: "2", nome: "Secador", id: 2),
                         Ruidos(imagem: "3", nome: "Ar-Condicionado", id: 3),
                         Ruidos(imagem: "4", nome: "Ondas", id: 4)]
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    ForEach(ruidos, id: \.self){ item in
                        ruidosInitialView(ruidos: item)
                    }
                }
            }
        }
    }
}

struct RuidoBranco_Previews: PreviewProvider {
    static var previews: some View {
        RuidoBranco()
    }
}
