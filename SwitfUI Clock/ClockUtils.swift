//
//  ClockUtils.swift
//  SwitfUI Clock
//
//  Created by Richard Lam on 23/6/2022.
//

import Foundation
import SwiftUI

/**
 Calculates the X co-ordinate of the clock hand end tip based on the clock value and the size of the clock hand.
 */
func calculateEndPointX(clockValue: Double,
                        size: CGSize,
                        handLength: Double) -> Double {
    let centreX = 0.5 * size.width
    let result = centreX + handLength * cos(Double.pi * (2.0 * clockValue/60.0 + 1.5))
    return result
}

/**
 Calculates the Y co-ordinate of the clock hand end tip based on the clock value and the size of the clock hand.
 */
func calculateEndPointY(clockValue: Double,
                        size: CGSize,
                        handLength: Double) -> Double {
    let centreY = 0.5 * size.height
    let result = centreY + handLength * sin(Double.pi * (2.0 * clockValue/60.0 + 1.5))
    return result
}
