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
    
    func determineFontSize() -> CGFloat {
        if widgetFamily == .systemSmall {
            return 30
        }
        if widgetFamily == .systemMedium {
            return 60
        }
        if widgetFamily == .systemLarge {
            return 80
        }
        return 160
    }

    var body: some View {

        ZStack {
            Text(entry.date, style: .time)
                .font(.system(size: determineFontSize()))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
            Color(".ColourBackgroundColor")
                    .opacity(0.3)
                    .ignoresSafeArea()
            }
            
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
