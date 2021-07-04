//
//  WidgetView.swift
//  MedicationWidgetExtension
//
//  Created by Regula Susan Heisch on 04.07.21.
//

import SwiftUI

struct WidgetView: View {
    @FetchRequest(entity: Medication.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Medication.timeStamp, ascending: true)], animation: .default) private var medications : FetchedResults<Medication>
    
    var body: some View {
        VStack{
            List{
                ForEach(medications) { medication in
                    Text("Medication \(medication.name!): \(medication.substances!)")
                }
            }
            Text("Test")
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
