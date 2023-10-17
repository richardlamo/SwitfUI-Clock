//
//  SwitfUI_ClockApp.swift
//  SwitfUI Clock
//
//  Created by Richard Lam on 29/5/2022.
//

import SwiftUI

@main
struct SwitfUI_ClockApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            // Select the clock face that you want.
            // TODO: Use a swipe gesture to change the clock face.
            // DigitalClockView()
            AnalogClockView()
        }
    }
}
