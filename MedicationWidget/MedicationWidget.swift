//
//  MedicationWidget.swift
//  MedicationWidget
//
//  Created by Regula Susan Heisch on 27.06.21.
//

import WidgetKit
import SwiftUI
import CoreData

//public extension URL{
//    static func storeURL(for appGroup: String, databaseName: String) -> URL {
//        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
//            fatalError("Shared file container could not be created.")
//        }
//        
//        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
//    }
//}
//
//var managedObjectContext: NSManagedObjectContext {
//    return persistentContainer.viewContext
//}
//
//var workingContext: NSManagedObjectContext {
//    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//    context.parent = managedObjectContext
//    return context
//}
//
//var persistentContainer: NSPersistentCloudKitContainer = {
//    let container = NSPersistentCloudKitContainer(name: "MyMedis")
//    
//    let storeURL = URL.storeURL(for: "group.com.heisch.regula.coredata", databaseName: "MyMedis")
//    let description = NSPersistentStoreDescription(url: storeURL)
//    
//    container.loadPersistentStores(completionHandler: {storeDescription, error in
//        if let error = error as NSError? {
//            print(error)
//        }
//    })
//    
//    container.viewContext.automaticallyMergesChangesFromParent = true
//    container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
//    
//    return container
//}()

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
    let persistenceController = PersistenceController.shared

    var body: some View {
        WidgetView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

@main
struct MedicationWidget: Widget {
    let kind: String = "MedicationWidget"
    let persistenceController = PersistenceController.shared

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MedicationWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
