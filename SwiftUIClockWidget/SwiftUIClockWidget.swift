//
//  SwiftUIClockWidget.swift
//  SwiftUIClockWidget
//
//  Created by Richard Lam on 11/9/2023.
//

import WidgetKit
import SwiftUI

struct ClockProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleClockEntry {
        SimpleClockEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleClockEntry) -> ()) {
        let entry = SimpleClockEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleClockEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        entries.append(SimpleClockEntry(date: currentDate))
        let theDate = Calendar.current.dateComponents([.second], from: currentDate)
        let nextTime = Calendar.current.date(byAdding: .second, value: (60-theDate.second!), to: currentDate)!
        for minOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minOffset, to: nextTime)!
            let entry = SimpleClockEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleClockEntry: TimelineEntry {
    let date: Date
}

struct SwiftUIClockWidgetEntryView : View {
    var entry: ClockProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @Environment(\.widgetRenderingMode) var renderingMode
    
    func determineFontSize() -> CGFloat {
        if widgetFamily == .systemSmall {
            return 35
        }
        if widgetFamily == .systemMedium {
            return 60
        }
        if widgetFamily == .systemLarge {
            return 70
        }
        return 70
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
                    .fontWeight(.bold)
                        
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
                Text("Default")
            }
            
        }
            
//        ZStack {
//            Text(entry.date, style: .time)
//                .font(
//                    .custom("Chalkboard", fixedSize: determineFontSize())
//                )
//                .fontWeight(.bold)
//                .containerBackground(for: .widget) {
//                    
//                }
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
        
            
    }
}

struct SwiftUIClockWidget: Widget {
    let kind: String = "SwiftUIClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ClockProvider()) { entry in
            SwiftUIClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Clock")
        .description("This is an clock widget.")
    }
}

struct SwiftUIClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIClockWidgetEntryView(entry: SimpleClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))

        SwiftUIClockWidgetEntryView(entry: SimpleClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))

        SwiftUIClockWidgetEntryView(entry: SimpleClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))

        SwiftUIClockWidgetEntryView(entry: SimpleClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
        

    }
}
