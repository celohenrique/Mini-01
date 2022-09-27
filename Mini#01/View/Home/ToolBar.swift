//
//  ToolBar.swift
//  Mini#01
//
//  Created by Marcelo Araujo on 29/08/22.
//

import SwiftUI

struct ToolBar: View {
    var body: some View {
        NavigationView{
            VStack {
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Ruidos")
                        .font(.system(size: 32))
                }
            }
        }
    }
}

