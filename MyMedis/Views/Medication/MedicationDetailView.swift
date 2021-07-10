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
        NavigationView {
            Text(medication.name ?? "")
                    .font(.largeTitle)
        }
    }
}
