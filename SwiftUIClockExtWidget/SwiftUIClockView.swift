//
//  SwiftUIClockView.swift
//  SwiftUIClockExtWidgetExtension
//
//  Created by Richard Lam on 17/10/2023.
//

import WidgetKit
import SwiftUI

struct SwiftUIClockExtWidgetEntryView : View {
    var entry: ClockProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @Environment(\.widgetRenderingMode) var renderingMode
    
    func determineFontSize() -> CGFloat {
        print("\(renderingMode)")
        if widgetFamily == .systemSmall {
            return 30
        }
        if widgetFamily == .systemMedium {
            return 70
        }
        if widgetFamily == .systemLarge {
            return 80
        }
        if widgetFamily == .systemExtraLarge {
            return 110
        }
        return 120
    }


    var body: some View {
        
        

        ZStack {
            switch renderingMode {
            case .fullColor:
                // Create views for full-color widgets and watch complications.
                Text(entry.date, style: .time)
                    .font(
                        .custom("Chalkboard", fixedSize: determineFontSize())
                    )
                    
                        
            case .accented:
                // Create views and group applicable views in the accented group.
                VStack {
                    Text(entry.date, style: .time)
                        .font(
                            .custom("Chalkboard", fixedSize: determineFontSize())
                        )
                        .fontWeight(.bold)
                        .widgetAccentable()
                
                }
                // Additional views that you don't group in the accented group.
            case .vibrant:
                // Create views for Lock Screen widgets on iPhone and iPad, and for the receded appearance on the Mac desktop.
                Text(entry.date, style: .time)
                    .font(
                        .custom("Chalkboard", fixedSize: determineFontSize())
                    )
                    .fontWeight(.bold)
                        
            default:
                VStack {
                    Text(entry.date, style: .time)
                        .font(
                            .custom("Chalkboard", fixedSize: determineFontSize())
                        )
                        .fontWeight(.bold)
                        .widgetAccentable()
                
                }
            }
            
        }
            
    }
}
