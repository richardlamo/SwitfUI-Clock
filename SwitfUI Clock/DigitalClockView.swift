//
//  ContentView.swift
//  SwitfUI Clock
//
//  Created by Richard Lam on 29/5/2022.
//

import SwiftUI

struct DigitalClockView: View {
    
    let clockTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let calendar = Calendar.current
    @State var currentDate = Date()
    @State var hour : NSInteger = 0
    @State var minute : NSInteger = 0
    @State var second : NSInteger = 0
    
    let cyclePeriod = 0.5
    
    var body: some View {
        ZStack {
            HStack {
                let hourString = String(format: "%02d", hour)
                let minuteString = String(format: "%02d", minute)
                let secondString = String(format: "%02d", second)
                Text("\(hourString):\(minuteString):\(secondString)")
                    .font(.system(size: 80))
            }
            .padding(.all)
        }
        .onReceive(clockTimer) {
            time in
            currentDate = time
            hour = calendar.component(.hour, from: currentDate)
            minute = calendar.component(.minute, from: currentDate)
            second = calendar.component(.second, from: currentDate)
        }
    }
}

struct DigitalClockView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalClockView()
    }
}
