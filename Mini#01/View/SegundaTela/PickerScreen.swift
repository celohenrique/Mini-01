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
    @Binding var timerOnOff : Bool 
    @State var aux = true
    
    @Binding var totalSegundos: Int    
    @Binding var isPlaying: Bool
    @Binding var isPause: Bool
    
    @State var notifyNum = NotificationController()
   
    @State var segundos = 0
    
    func convertSelection(hrs: Int, min: Int, sec: Int) -> Int{
        
        let hrs = hrs * 3600
        let min = min * 60
        let sec = sec
        let total = hrs + min + sec
        return total
    }
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    var body: some View {
        VStack(spacing: 170){
        
            if timerOnOff {
            VStack(alignment: .center,spacing: 50){
               
                HStack(alignment: .center){
                    
                    Picker(selection: self.$hourSelection, label: Text("")){
                        ForEach(0 ..< hours.count, id: \.self){ index in
                            Text("\(self.hours[index]) hours")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    
                    Picker(selection: self.$minuteSelection, label: Text("")){
                        ForEach(0 ..< minutes.count, id: \.self){ index in
                            Text("\(self.minutes[index]) min")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                }
                Spacer()
                    .frame(height: 50)
                
                
                // MARK: - Botoes
                HStack(alignment: .center){
                    
                    Button(action:{
                         
                        let total = convertSelection(hrs: hourSelection, min: minuteSelection, sec: segundos)
                      
                        if hourSelection == 0 && minuteSelection == 0 {
                            
                            
                            return
                        }
                        
                        else {
                                self.totalSegundos = 0
                                timerOnOff = false
                                isPlaying = true
                                notifyNum.sendNotification(type: "time",
                                                           timeInterval: Double(total),
                                                           title: "Alerta",
                                                           body: "Seu timer acabou")
                            }
                    })
                    {
                        Text("Start")
                            .foregroundColor(Color(red: 30/255, green: 14/255, blue: 51/255))
                           
                    }
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                   
                }
                .buttonStyle(CircleButton())
                // arrumar esse botao para caber em varias telas
            }
        } else{
            
            CircleLap(ruidos: self.ruidos, hourSelection: $hourSelection, minuteSelection: $minuteSelection,  timerOnOff: $timerOnOff, isPlaying: $isPlaying, isPause: $isPause, totalSegundos: $totalSegundos, aux: totalSegundos, sensor: $sensor, ativo: $ativo)
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



