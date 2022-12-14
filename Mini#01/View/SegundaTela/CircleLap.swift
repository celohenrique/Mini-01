//
//  CircleLap.swift
//  Mini#01
//
//  Created by Gustavo Assis on 16/09/22.
//


import SwiftUI
struct CircleLap: View {
    
    
    @State var ruidos: Ruidos
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    @State var seconds: Int = 0
    @Binding var timerOnOff: Bool
    @Binding var isPlaying: Bool
    @Binding var isPause: Bool
//    @ObservedObject private var mic = MicrophoneMonitor()
    @Binding var totalSegundos: Int
    @State var aux: Int
    @Binding var sensor: Bool
    @Binding var ativo: Bool
    
    var isPreview: Bool = false
    
    
    
    func convertSelection(hrs: Int, min: Int, sec: Int) -> Int{
        
        let hrs = hrs * 3600
        let min = min * 60
        let sec = sec
        let total = hrs + min + sec
        return total
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String{
        
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    var body : some View{
        
        
            VStack(spacing: 25){
                Text(convertSecondsToTime(timeInSeconds: totalSegundos))
                    .foregroundColor(Color.white)
                    .padding()
                    .font(.system(size: 48))
                    .onReceive(timer) { _ in
                        
                        if self.totalSegundos == 0 {
                            timerOnOff = true
                            isPlaying = false
                            isPause = false
                            player.stop()
                        }
                        
                        self.totalSegundos -= 1
                        hourSelection = self.totalSegundos / 3600
                        minuteSelection = (self.totalSegundos % 3600) / 60
                        seconds = self.totalSegundos % 60
                    }
            }
            
            HStack(spacing:130){
                
                Button(action: {
                    timerOnOff = true
                    isPlaying = false
                    isPause = false
                    player.stop()
                    self.totalSegundos = 0
                    self.minuteSelection = 0
                    self.hourSelection = 0


                }){
                    Text("Cancel") }
                .frame(width: 100, height: 100)
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                // .frame(width: 75, height: 75)
                
                Button(action: {
                    playPause()
                    
                    if isPause {
                        isPause = false
                        self.timer.upstream.connect().cancel()
//                        self.estado = "Pause"
                        
                    }
                    else {
                        isPause = true
                        self.timer = self.timer.upstream.autoconnect()
//                        self.estado = "Play"
                    }
                })
                {
                    
                    Text("\(isPause ? "Pause": "Play")")

                    
                        .foregroundColor(Color(red: 28/255, green: 12/255, blue: 48/255))
                }
                .frame(width: 100, height: 100)
                .foregroundColor(isPause ? Color(red: 170/255, green: 170/255, blue: 170/255) : Color(red: 255/255, green: 255/255, blue: 255/255) )
                // .frame(width: 75, height: 75)
            }.buttonStyle(CircleButton())
            .onChange(of: totalSegundos) {newValue in
                self.totalSegundos = convertSelection(hrs: hourSelection,min: minuteSelection,sec: seconds)
                
                
            }

            .onAppear{
                totalSegundos = convertSelection(hrs: hourSelection,min: minuteSelection,sec: seconds)
                playSound(key: "\(ruidos.audio)")
                isPause = true
                
                if sensor{
                    ativo = false
                }

                if aux != 0 {
                    totalSegundos = aux
                }
            }
        
//
        
            .onDisappear {
                isPause = true
                
                if sensor && totalSegundos == 0 {
                    ativo = true
                }
            }
    }
}




//struct CircleLap_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleLap()
//    }
//}


