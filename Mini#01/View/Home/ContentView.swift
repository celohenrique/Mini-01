//
//  ContentView.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 29/08/22.
//

import SwiftUI
import Foundation
import AVFoundation



struct ContentView: View {
    var toolBarMain = ToolBar()
    private var notify = NotificationController()
    
    init(){
        notify.askPermissionNotification()
    }
    
    var body: some View {
        
        VStack{
            
            TelaInicial()
            
        }
    }
}


//MARK: - Preview da view
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

