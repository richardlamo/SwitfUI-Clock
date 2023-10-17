//
//  SwiftUICalendarWidgetBundle.swift
//  SwiftUICalendarWidget
//
//  Created by Richard Lam on 12/9/2023.
//

import WidgetKit
import SwiftUI

@main
struct SwiftUICalendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        SwiftUICalendarWidget()
        SwiftUIClockWidget()
    }
}
