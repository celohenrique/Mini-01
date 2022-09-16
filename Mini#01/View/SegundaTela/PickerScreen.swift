//
//  ContentView.swift
//  testTimer2
//
//  Created by Marcelo Araujo on 12/09/22.
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
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .padding(4))
            .overlay(
                configuration.label
                    .foregroundColor(.black))
    }
}

struct PickerScreen: View {
    
    @State var hourSelection = 0
    @State var minuteSelection = 0
    
    @State var timerOnOff = true
    @State var isPlaying = true
    
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    
    var body: some View {
        if timerOnOff {
            
            VStack(alignment: .center,spacing: 110){
                HStack(alignment: .center){
                    
                    Picker(selection: self.$hourSelection, label: Text("")){
                        ForEach(0 ..< self.hours.count){ index in
                            Text("\(self.hours[index]) hours").tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    // .compositingGroup()
                    // .clipped()
                    
                    Picker(selection: self.$minuteSelection, label: Text("")){
                        ForEach(0 ..< self.minutes.count){ index in
                            Text("\(self.minutes[index]) min").tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 150, alignment: .center)
                    // .compositingGroup()
                    //.clipped()
                    
                }
                HStack(spacing:170){
                    
                    Button(action: {}){ //action here
                        
                        Text("Cancel")
                    }
                    
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 228/255, green: 228/255, blue: 228/255))
                    .frame(width: 75, height: 75)
                    
                    Button(action:{
                        
                        timerOnOff = false //Start button action
                        
                    }){
                        Text("Start")
                            .foregroundColor(Color(red: 61/255, green: 197/255, blue: 94/255))
                    }
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 105/255, green: 152/255, blue: 117/255))
                    .frame(width: 75, height: 75)
                }
                .buttonStyle(CircleButton())
            }
        }
        
        
        else {
            
            CircleLap(hourSelection: $hourSelection, minuteSelection: $minuteSelection, timerOnOff: $timerOnOff, isPlaying: $isPlaying)
            
            
        }
        
        
        
    }
}


extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
        
    }
}


//        struct ContentView_Previews: PreviewProvider {
//            static var previews: some View {
//                ContentView()
//            }
//        }