//
//  SegundaTela.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 12/09/22.
//

import SwiftUI

struct SegundaTela: View {
    
    @State var ruidos: Ruidos
    
    var body: some View {
        
        ZStack{
//            Image("back")
//                .resizable(resizingMode: .stretch)
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
            
            VStack {
                Text(ruidos.nome)
                    .font(.title)
                Spacer()
                    .frame(height: 500)
                    
            }
        }
        
    }
    
}

//struct SegundaTela_Previews: PreviewProvider {
//    static var previews: some View {
//        SegundaTela()
//    }
//}
