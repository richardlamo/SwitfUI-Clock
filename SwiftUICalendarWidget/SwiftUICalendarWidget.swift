//
//  SwiftUICalendarWidget.swift
//  SwiftUICalendarWidget
//
//  Created by Richard Lam on 12/9/2023.
//

import WidgetKit
import SwiftUI

struct CalendarProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleCalendarEntry {
        SimpleCalendarEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleCalendarEntry) -> ()) {
        let entry = SimpleCalendarEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleCalendarEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleCalendarEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleCalendarEntry: TimelineEntry {
    let date: Date
    
}

struct SwiftUICalendarWidgetEntryView : View {
    var entry: CalendarProvider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    func determineFontSize() -> CGFloat {
        if widgetFamily == .systemSmall {
            return 38
        }
        if widgetFamily == .systemMedium {
            return 60
        }
        if widgetFamily == .systemLarge {
            return 80
        }
        return 160
    }
    
    func extract(component : Calendar.Component) -> String {
        let dateComponents = Calendar.current.dateComponents([component], from: entry.date)
        if (component == .day) {
            return String(dateComponents.day!)
        }
        if (component == .month){
            let monthVal = dateComponents.month!
            return DateFormatter().shortMonthSymbols[monthVal-1]
        }
        if (component == .weekday) {
            let weekVal = dateComponents.weekday!
            return DateFormatter().shortWeekdaySymbols[weekVal-1]
        }
        return String()
    }

    var body: some View {
        VStack {
            Text("\(extract(component : .weekday))")
                .foregroundColor(Color.red)
                .font(.custom("Chalkboard", size: determineFontSize()))
            HStack {
                Text("\(extract(component : .month))")
                    .font(.custom("Chalkboard", size: determineFontSize()))
                Text("\(extract(component : .day))")
                    .font(.custom("Chalkboard", size: determineFontSize()))
            }
            if widgetFamily == .systemExtraLarge {
                    Text("Wisdom goes here.")
            }

        }
    }
}

struct SwiftUICalendarWidget: Widget {
    let kind: String = "SwiftUICalendarWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CalendarProvider()) { entry in
            SwiftUICalendarWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Calendar Widget")
        .description("This is my Calendar Widget.")
    }
}

struct SwiftUICalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICalendarWidgetEntryView(entry: SimpleCalendarEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))

        SwiftUICalendarWidgetEntryView(entry: SimpleCalendarEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        SwiftUICalendarWidgetEntryView(entry: SimpleCalendarEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        SwiftUICalendarWidgetEntryView(entry: SimpleCalendarEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
