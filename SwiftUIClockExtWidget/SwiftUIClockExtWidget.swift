//
//  SwiftUIClockExtWidget.swift
//  SwiftUIClockExtWidget
//
//  Created by Richard Lam on 17/10/2023.
//

import WidgetKit
import SwiftUI

struct ClockProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleDateTimeEntry {
        SimpleDateTimeEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleDateTimeEntry {
        SimpleDateTimeEntry(date: Date(), configuration: configuration)
    }
    
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleDateTimeEntry> {
        var entries: [SimpleDateTimeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        entries.append(SimpleDateTimeEntry(date: currentDate, configuration: configuration))
        
        let theDate = Calendar.current.dateComponents([.second], from: currentDate)
        let nextTime = Calendar.current.date(byAdding: .second, value: (60-theDate.second!), to: currentDate)!
        for minOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minOffset, to: nextTime)!
            let entry = SimpleDateTimeEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleDateTimeEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}




struct SwiftUIClockExtWidget: Widget {
    let kind: String = "SwiftUIClockExtWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: ClockProvider()) { entry in
            SwiftUIClockExtWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    SwiftUIClockExtWidget()
} timeline: {
    SimpleDateTimeEntry(date: .now, configuration: .smiley)
    SimpleDateTimeEntry(date: .now, configuration: .starEyes)
}

#Preview(as: .systemMedium) {
    SwiftUIClockExtWidget()
} timeline: {
    SimpleDateTimeEntry(date: .now, configuration: .smiley)
    SimpleDateTimeEntry(date: .now, configuration: .starEyes)
}

#Preview(as: .systemLarge) {
    SwiftUIClockExtWidget()
} timeline: {
    SimpleDateTimeEntry(date: .now, configuration: .smiley)
    SimpleDateTimeEntry(date: .now, configuration: .starEyes)
}

#Preview(as: .systemExtraLarge) {
    SwiftUIClockExtWidget()
} timeline: {
    SimpleDateTimeEntry(date: .now, configuration: .smiley)
    SimpleDateTimeEntry(date: .now, configuration: .starEyes)
}
