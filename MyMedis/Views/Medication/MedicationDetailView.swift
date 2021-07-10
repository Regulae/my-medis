//
//  MedicationDetailView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 10.07.21.
//
//

import SwiftUI

struct MedicationDetailView: View {
    var medication: Medication

    var body: some View {
        VStack {
            Text(medication.name ?? "")
                    .font(.largeTitle)
            if medication.substances != "" {
                Text("Substances: \(medication.substances ?? "")")
            }
            if medication.authHolder != nil {
                Text("Authorization Holder: \(medication.authHolder ?? "")")
            }
        }
                .padding()
    }
}
