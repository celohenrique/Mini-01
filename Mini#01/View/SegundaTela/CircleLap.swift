//
//  CircleLap.swift
//  Mini#01
//
//  Created by Gustavo Assis on 16/09/22.
//


import SwiftUI
struct CircleLap: View {
    
    // let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() should we implent that for logic?
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    @State var seconds: Int = 0
    @Binding var timerOnOff: Bool
    @Binding var isPlaying: Bool
    
    var isPreview: Bool = false
    @State var ruidos: Ruidos
    //    @State  var secondSelection = 0
    
    func convertSelection() -> Int{
        
        let hora1 = hourSelection * 3600
        let minuto1 = minuteSelection * 60
        let second = seconds
        let total1 = hora1 + minuto1 + second
        
        return total1
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String{
        
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i",
                      hours,
                      minutes,
                      seconds)
    }
    
    var body : some View{
        
        var timeRemaining = convertSelection()
        
        
        
        
        VStack(spacing: 25){
            //            ZStack{
            //                Circle()
            //                    .stroke(Color(red: 142/255, green: 142/255, blue: 147/255), style: StrokeStyle(lineWidth: 5, lineCap: .round))
            //
            //                Circle()
            //                    .trim(from: 0, to: 0.5)
            //                    .stroke(Color(red: 253/255, green: 148/255, blue: 38/255), style: StrokeStyle(lineWidth: 5, lineCap: .round))
            //                    .rotationEffect(.degrees(-90))
            //                    .animation(.easeInOut) //change that for a not deprecated one
            
            Text(convertSecondsToTime(timeInSeconds: timeRemaining))
            
                .padding()
                .font(.system(size: 48))
                .onReceive(timer) { _ in
                    
                    if timeRemaining == 0 {
                        timerOnOff = true
                        isPlaying = true
                        player.stop()
                    }
                    
                    timeRemaining -= 1
                    hourSelection = timeRemaining / 3600
                    minuteSelection = (timeRemaining % 3600) / 60
                    seconds = timeRemaining % 60
                    
                    
                    //                            if hourSelection == 0 && minuteSelection == 0{
                    //                                timerOnOff = true
                    //                                player.stop()
                    //
                    //                            }
                }
        }
        
        //            }.frame(width: 248, height: 248)
        
        HStack(spacing:130){
            
            Button(action: {
                timerOnOff = true
                isPlaying = true
                player.stop()
            }){
                
                Text("Cancel")
            }
            
            .frame(width: 100, height: 100)
            .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
            // .frame(width: 75, height: 75)
            
            Button(action: {
                playPause()
                if isPlaying {
                    isPlaying = false
                    self.timer.upstream.connect().cancel()
                }
                else {
                    isPlaying = true
                    self.timer = self.timer.upstream.autoconnect()
                }
            })
            {
                Text("\(isPlaying ? "Pause" : "Play")")
                    .foregroundColor(Color(red: 28/255, green: 12/255, blue: 48/255))
            }
            .frame(width: 100, height: 100)
            .foregroundColor(isPlaying ? Color(red: 170/255, green: 170/255, blue: 170/255) : Color(red: 255/255, green: 255/255, blue: 255/255) )
            // .frame(width: 75, height: 75)
        }.buttonStyle(CircleButton())
        
        .onAppear{
            playSound(key: "\(ruidos.audio)")
        }
    }
}




//struct CircleLap_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleLap()
//    }
//}


