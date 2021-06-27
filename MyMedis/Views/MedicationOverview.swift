//
//  MedicationOverview.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 20.06.21.
//

import SwiftUI

struct MedicationOverview: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Today")
                .font(.title)
                .bold()
            ForEach(modelData.medications.keys.sorted(), id: \.self){ key in
                Text(key)
                    .font(.title3)
                    .bold()
                MedicationRow(items: modelData.medications[key] ?? [])
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MedicationOverview_Previews: PreviewProvider {
    static var previews: some View {
        MedicationOverview()
            .environmentObject(ModelData())
    }
}
