//
//  MedicationWidget.swift
//  MedicationWidget
//
//  Created by Regula Susan Heisch on 27.06.21.
//

import WidgetKit
import SwiftUI
import CoreData


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
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
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

struct MedicationWidgetEntryView : View {
    var entry: Provider.Entry
//    let persistenceController = PersistenceController.shared

    var body: some View {
        WidgetView()
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

@main
struct MedicationWidget: Widget {
    let kind: String = "MedicationWidget"
//    let persistenceController = PersistenceController.shared

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MedicationWidgetEntryView(entry: entry)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MedicationWidget_Previews: PreviewProvider {
    static var previews: some View {
        MedicationWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
