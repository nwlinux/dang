import WidgetKit
import SwiftUI

struct CountEntry: TimelineEntry {
    let date: Date
    let count: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CountEntry {
        CountEntry(date: Date(), count: 3)
    }

    func getSnapshot(in context: Context, completion: @escaping (CountEntry) -> Void) {
        completion(CountEntry(date: Date(), count: DangCounterShared.todayCount()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CountEntry>) -> Void) {
        let entry = CountEntry(date: Date(), count: DangCounterShared.todayCount())
        let midnight = Calendar.current.nextDate(
            after: Date(),
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTime
        ) ?? Date().addingTimeInterval(3600)
        completion(Timeline(entries: [entry], policy: .after(midnight)))
    }
}

struct DangCounterWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 4) {
            Text("\(entry.count)")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.red)
            Text(entry.count == 1 ? "dang today" : "dangs today")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct DangCounterWidget: Widget {
    let kind: String = "DangCounterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DangCounterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Dang Counter")
        .description("Shows how many times your mother in law has said dang today.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    DangCounterWidget()
} timeline: {
    CountEntry(date: .now, count: 3)
    CountEntry(date: .now, count: 7)
}
