//
//  ContentView.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 29/08/22.
//

import SwiftUI


struct ContentView: View {
    var toolBarMain = ToolBar()
    var body: some View {
        
        VStack{
            
            Text("Sounds")
                .font(.title)
            Spacer()
                .frame(height: 40)
            VStack(alignment: .leading){
                
                Text("Ruído Branco")
                    .padding([.leading, .bottom])
                
                
                RuidoBranco()
                    .padding(.leading)
                
                Text("Ruído Branco")
                    .padding([.top, .leading, .bottom])
                
                RuidoBranco()
                    .padding(.leading)
                
                Text("Ruído Branco")
                    .padding([.top, .leading, .bottom])
                
                RuidoBranco()
                    .padding([.leading, .bottom])
            }
        }
    }
}




 //MARK: - Preview da view
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

