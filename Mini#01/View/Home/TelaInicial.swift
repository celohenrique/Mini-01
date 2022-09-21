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
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        
    }
}

struct TelaInicial: View {
    
    let columns = [
        GridItem(spacing: 20),
        GridItem(spacing: 20),
        GridItem(spacing: 20)
    ]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    @State var showSheet: Bool = false
    @State var toggleIsOn: Bool = false
    
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
                            NavigationLink(destination: SegundaTela(ruidos: item)){
                                ruidosIcon(ruidos: item)
                            }
                        }
                    }
                    .padding(.all)
                    
                }.toolbar(){
                    ToolbarItem(placement: .automatic){
                        Image(systemName: "mic.fill")
                            .foregroundColor(Color.white)
                            .onTapGesture {
                                showSheet.toggle()
                            }
                    }
                    
                }
                .navigationBarTitle("Sons")
                
                HalfASheet(isPresented: $showSheet){
                    VStack{
                        Toggle(isOn: $toggleIsOn, label: {
                            Text("Sensor de Barulho")
                                .font(.title2)
                        })
                        Spacer()
                            .frame(height: 20)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at risus. Quisque purus magna, auctor et, sagittis ac, posuere eu, lectus. Nam mattis, felis ut adipiscing.")
                        Spacer()
                            .frame(height: 90)
                    }
                    
                }.height(.proportional(0.55))
            }
            
        }
    }
    
    struct RuidoBranco_Previews: PreviewProvider {
        static var previews: some View {
            TelaInicial()
        }
    }
    
}

struct RuidoBranco_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicial()
    }
}

