//
//  AnalogClockView.swift
//  SwitfUI Clock
//
//  Created by Richard Lam on 30/5/2022.
//
// This demonstrates an analog clock using Swift UI TimelineView feature. It also draws the clock hand using
// Swift UI Canvas
// 
import SwiftUI

struct AnalogClockView: View {
    let secondHandLength = 160.0
    let minHandLength = 160.0
    let hourHandLength = 90.0
    let calendar = Calendar.current
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                let currentDate = Date(timeIntervalSince1970: now)
                let second = Double(calendar.component(.second, from: currentDate))
                let minute = Double(calendar.component(.minute, from: currentDate)) + second/60.0
                let hour = Double(calendar.component(.hour, from: currentDate)) + minute/60.0
                
                let secondPath = fetchPathForClockHand(clockValue: second, size: size, handLength: secondHandLength)
                context.stroke(Path(secondPath), with: .color(.green), lineWidth: 1)
                let minutePath = fetchPathForClockHand(clockValue: minute, size: size, handLength: minHandLength)
                context.stroke(Path(minutePath), with: .color(.cyan), lineWidth: 4)
                let hourPath = fetchPathForClockHand(clockValue: hour * 5.0, size: size, handLength: hourHandLength)
                context.stroke(Path(hourPath), with: .color(.red), lineWidth: 4)

            }
        }
    }
    
    func fetchPathForClockHand(clockValue: Double,
                               size: CGSize,
                               handLength: Double) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.5 * size.width, y: 0.5 * size.height))
        let clockHand = clockValue
        path.addLine(to: CGPoint(x: calculateEndPointX(clockValue: clockHand,
                                                       size: size,
                                                       handLength: handLength),
                                 y: calculateEndPointY(clockValue: clockHand,
                                                       size: size,
                                                       handLength: handLength)))
        return path
    }
}



struct AnalogClockView_Previews: PreviewProvider {
    static var previews: some View {
         AnalogClockView()
    }
}
