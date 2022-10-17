//
//  LauchScreen.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 14/10/22.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive{
            ContentView()
        }
        else{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 28/255, green: 13/255, blue: 47/255),
                    Color(red: 57/255, green: 36/255, blue: 89/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom)
                    .ignoresSafeArea(.all, edges: .all)
                VStack{
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 100, alignment: .center)
                }.scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.9)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.isActive = true
                }
            } 
        }
    }
}
