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
                    .opacity(configuration.isPressed ? 0.3 : 0) //use : for otherwise, so opacity will be 0.3 otherwise will be 0
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
    
    @State var hourSelection = 0
    @State var minuteSelection = 0
    
    @State var timerOnOff = true //usei para mudar do picker para o countdown
    @State var isPlaying = true
    
    @State var ruidos: Ruidos
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    var body: some View {
        
        if timerOnOff {
            VStack(alignment: .center,spacing: 100){
                HStack(alignment: .center){
                    
                    Picker(selection: self.$hourSelection, label: Text("")){
                        ForEach(0 ..< self.hours.count){ index in
                            Text("\(self.hours[index]) hours").font(.title).fontWeight(.medium).foregroundColor(Color.white).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    // .compositingGroup()
                    // .clipped()
                    
                    Picker(selection: self.$minuteSelection, label: Text("")){
                        ForEach(0 ..< self.minutes.count){ index in
                            Text("\(self.minutes[index]) min").font(.title).fontWeight(.medium).foregroundColor(Color.white).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    // .compositingGroup()
                    //.clipped()
                }
                
                // MARK: - Botoes
                HStack(alignment: .center){
                    
//                    Button(action: {}){ //action here
//                        Text("Cancel")
//                    }
//
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(Color(red: 228/255, green: 228/255, blue: 228/255))
                    // .frame(width: 75, height: 75)
                    
                    Button(action:{
                        if hourSelection == 0 && minuteSelection == 0 {
                            return
                        } else {
                            timerOnOff = false //Start button action
                        }
                        
                        
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
        } else{
            CircleLap(hourSelection: $hourSelection, minuteSelection: $minuteSelection, timerOnOff: $timerOnOff, isPlaying: $isPlaying, ruidos: self.ruidos)
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


