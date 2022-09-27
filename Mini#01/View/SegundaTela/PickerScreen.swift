//
//  PickerScreen.swift
//  provaConeceitoMini1
//
//  Created by Gustavo Assis on 15/09/22.
//
import SwiftUI

struct CircleButton: ButtonStyle{
    
    internal func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill()
            .overlay(
                Circle()
                    .fill(Color.white)
                    .opacity(configuration.isPressed ? 0.3 : 0)
            )
            .overlay(
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(red: 30/255, green: 14/255, blue: 51/255))
                    .padding(4))
            .overlay(
                configuration.label
                    .foregroundColor(.black))
    }
}

struct PickerScreen: View {
    
    @State var ruidos: Ruidos
    @Binding var sensor: Bool
    @Binding var ativo: Bool
    @State var hourSelection = 0
    @State var minuteSelection = 0
    @Binding var timerOnOff : Bool //usei para mudar do picker para o countdown
    @State var aux = true
    
    @Binding var totalSegundos: Int
    
    @ObservedObject private var mic = MicrophoneMonitor(ruidos: nil)
    
    @Binding var isPlaying: Bool
    
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    var body: some View {
        VStack(spacing: 170){
        
            if timerOnOff {
            VStack(alignment: .center,spacing: 100){
                HStack(alignment: .center){
                    
                    Picker(selection: self.$hourSelection, label: Text("")){
                        ForEach(0 ..< hours.count, id: \.self){ index in
                            Text("\(self.hours[index]) hours").font(.title).fontWeight(.medium).foregroundColor(Color.white).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    
                    Picker(selection: self.$minuteSelection, label: Text("")){
                        ForEach(0 ..< minutes.count, id: \.self){ index in
                            Text("\(self.minutes[index]) min").font(.title).fontWeight(.medium).foregroundColor(Color.white).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                }
                
                // MARK: - Botoes
                HStack(alignment: .center){
                    
                    Button(action:{
                        if hourSelection == 0 && minuteSelection == 0 {
                            return
                        } else {
                            timerOnOff = false
                            isPlaying = true
                            //Start button action
                        }
                        
                        print(self.minuteSelection)
                        
                    }){
                        Text("Start")
                            .foregroundColor(Color(red: 30/255, green: 14/255, blue: 51/255))
                    }
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                    
                    // .frame(width: 75, height: 75)
                }
                .buttonStyle(CircleButton())
            }
            .onAppear {
                self.totalSegundos = 0
            }
        } else{
            
            CircleLap(ruidos: self.ruidos, hourSelection: $hourSelection, minuteSelection: $minuteSelection,  timerOnOff: $timerOnOff, isPlaying: $isPlaying, totalSegundos: $totalSegundos, aux: totalSegundos, sensor: $sensor, ativo: $ativo)
        }
    }
}

}

//MARK: - Extensions
extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
        
    }
}

//struct PickerScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerScreen()
//    }
//}


