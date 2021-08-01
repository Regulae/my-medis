//
//  ContentView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selection: Tab = .medicationOverview
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Medication.timeStamp, ascending: true)], animation: .default) private var medications: FetchedResults<Medication>

    enum Tab {
        case medicationOverview
        case user
    }

    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "red")
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
    }

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                MedicationOverview(medications: medications, viewContext: viewContext)
                        .tabItem {
                            Label("Featured", systemImage: "calendar")
                        }
                        .tag(Tab.medicationOverview)
                UserView()
                        .tabItem {
                            Label("User", systemImage: "person")
                        }
                        .tag(Tab.user)
            }
                    .accentColor(.white)
        }
                .accentColor(Color("red"))
                .padding(.top, 0.0)

    }
}




