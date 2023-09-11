//
//  SwiftUIClockWidget.swift
//  SwiftUIClockWidget
//
//  Created by Richard Lam on 11/9/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let theDate = Calendar.current.dateComponents([.second], from: currentDate)
        let nextTime = Calendar.current.date(byAdding: .second, value: (60-theDate.second!), to: currentDate)!
        for minOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minOffset, to: nextTime)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SwiftUIClockWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Text(entry.date, style: .time)
                .font(.system(size: 60))
        }.padding(.all)
    }
}

struct SwiftUIClockWidget: Widget {
    let kind: String = "SwiftUIClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SwiftUIClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct SwiftUIClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))

        SwiftUIClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))

        SwiftUIClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))

        SwiftUIClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))

    }
}
