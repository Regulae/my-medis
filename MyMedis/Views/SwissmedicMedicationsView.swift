//
//  SwissmedicMedicationsView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 26.06.21.
//

import SwiftUI

struct SwissmedicMedicationsView: View {
    @EnvironmentObject var modelData: ModelData
    
    var filteredMedications: [SwissmedicMedication]{
        modelData.swissmedicMedications.filter{ medication in
            (medication.substances != nil &&
            medication.substances!.contains("Ibuprofen"))
        }
    }
    
    var body: some View {
        List{
            ForEach(filteredMedications){ medication in
                Text(medication.name)
            }
        }
    }
}

struct SwissmedicMedicationsView_Previews: PreviewProvider {
    static var previews: some View {
        SwissmedicMedicationsView()
            .environmentObject(ModelData())
    }
}
