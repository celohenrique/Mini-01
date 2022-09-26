//
//  CircleLap.swift
//  Mini#01
//
//  Created by Gustavo Assis on 16/09/22.
//


import SwiftUI
struct CircleLap: View {
    
    // let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() should we implent that for logic?
    @State var ruidos: Ruidos
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    @State var seconds: Int = 0
    @Binding var timerOnOff: Bool
    @Binding var isPlaying: Bool
    
    @Binding var totalSegundos: Int
    @State var aux: Int
//    @State var estado: String = ""
    
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
                            player.stop()
                        }
                        
                        self.totalSegundos -= 1
                        hourSelection = self.totalSegundos / 3600
                        minuteSelection = (self.totalSegundos % 3600) / 60
                        seconds = self.totalSegundos % 60
                    }
            }
            .onAppear{
            
                
                totalSegundos = convertSelection(hrs: hourSelection,min: minuteSelection,sec: seconds)

              
                    playSound(key: "\(ruidos.audio)")
              
//                    else {
//                    playPause()
//                }
                
                
//                print("total segundos OnAppear CircleLap: \(totalSegundos)")
                print("isplaying  OnAppear CircleLap: \(isPlaying)")
                if aux != 0 {
                    totalSegundos = aux
                }
                
            }
            .onDisappear {
                print("isplaying  OnDisapper CircleLap: \(isPlaying)")
                isPlaying = true
            }
            
            HStack(spacing:130){
                
                Button(action: {
                    timerOnOff = true
                    isPlaying = false
                    player.stop()
                    self.totalSegundos = 0
                    self.minuteSelection = 0
                    self.hourSelection = 0
                    print("Total segundos ao cancelar: \(self.totalSegundos)")
//                    self.aux = 0
                }){
                    Text("Cancel") }
                .frame(width: 100, height: 100)
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                // .frame(width: 75, height: 75)
                
                Button(action: {
                    playPause()
                    
                    if isPlaying {
                        isPlaying = false
                        self.timer.upstream.connect().cancel()
//                        self.estado = "Pause"
                        
                    }
                    else {
                        isPlaying = true
                        self.timer = self.timer.upstream.autoconnect()
//                        self.estado = "Play"
                    }
                })
                {
                    
                    Text("\(isPlaying ? "Pause": "Play")")
//                    Text("\(estado)")
                    
                        .foregroundColor(Color(red: 28/255, green: 12/255, blue: 48/255))
                }
                .frame(width: 100, height: 100)
                .foregroundColor(isPlaying ? Color(red: 170/255, green: 170/255, blue: 170/255) : Color(red: 255/255, green: 255/255, blue: 255/255) )
                // .frame(width: 75, height: 75)
            }.buttonStyle(CircleButton())
            .onChange(of: totalSegundos) {newValue in
                self.totalSegundos = convertSelection(hrs: hourSelection,min: minuteSelection,sec: seconds)
            }
            
    }
}




//struct CircleLap_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleLap()
//    }
//}


