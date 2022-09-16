//
//  CircleLap.swift
//  testTimer2
//
//  Created by Marcelo Araujo on 14/09/22.
//

import SwiftUI

struct CircleLap: View {
    
    // let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() should we implent that for logic?
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    @Binding var timerOnOff: Bool
    @Binding var isPlaying: Bool
    
    @State  var secondSelection = 0
    
    var body : some View{
        
        VStack(spacing: 70){
            ZStack{
                
//                Circle()
//                    .stroke(Color(red: 142/255, green: 142/255, blue: 147/255), style: StrokeStyle(lineWidth: 5, lineCap: .round))
//
//                Circle()
//                    .trim(from: 0, to: 0.5)
//                    .stroke(Color(red: 253/255, green: 148/255, blue: 38/255), style: StrokeStyle(lineWidth: 5, lineCap: .round))
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut)//change that for a not deprecated one
                
                Text((hourSelection < 10 ? "0\(hourSelection):\(minuteSelection)" : "\(hourSelection):\(minuteSelection)"))
                    .padding()
                    .font(.system(size: 48))
                    .onReceive(timer) { _ in
                        
                        if minuteSelection > 0 {
                            minuteSelection -= 1
                        }
                        else if minuteSelection == 0 {
                            if hourSelection >= 1{
                                minuteSelection = 59
                                hourSelection -= 1
                            }
                            if hourSelection == 0{
                                print("Timer Stopped")
                                //                                timer.invalidate()
                            }
                        }
                        //should we add Hstack or Vstack here?
                        
                        
                        
                    }
                
                HStack(spacing: 25){
                    
                    //maybe we can set the SF symble here not sure (systemImage)
                    //                    Label("bell.fill", systemImage: "bell.fill")
                    //                         .foregroundColor(.black)
                    //                         .font(.custom("", size: 15))
                    //                         .padding()
                }
                
            }.padding(.horizontal).frame(width: 248, height: 248)
            
            HStack(spacing:170){
                
                Button(action: {
                    timerOnOff = true
                }){
                    
                    Text("Cancel")
                }
                
                .frame(width: 80, height: 80)
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                // .frame(width: 75, height: 75)
                
                Button(action: {
                    
                    if isPlaying {
                        isPlaying = false
                    }
                    else {
                        isPlaying = true
                    }
                    
                })
                {
                    Text("\(isPlaying ? "Pause" : "Play")")
                        .foregroundColor(isPlaying ? Color(red: 253/255, green: 148/255, blue: 38/255) : Color(red: 61/255, green: 197/255, blue: 94/255))
                }
                .frame(width: 80, height: 80)
                .foregroundColor(isPlaying ? .orange.opacity(0.6) : Color(red: 105/255, green: 152/255, blue: 117/255))
                // .frame(width: 75, height: 75)
            }.buttonStyle(CircleButton())
            
        }
        
        
    }
    
}


//struct CircleLap_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleLap()
//    }
//}
