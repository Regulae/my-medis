//
//  MedicationRow.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 27.06.21.
//

import SwiftUI

struct MedicationRow: View {
    var items:  [Medication] = []
    let now = Date()
    
    var body: some View {
        List(items){ item in
            HStack{
                Text(item.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if((now.timeIntervalSince(item.lastTaken ?? Date()) > 86400)){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(1/1, contentMode: .fit)
                            .foregroundColor(.black)
                    }
                } else {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(1/1, contentMode: .fit)
                            .foregroundColor(Color("green"))
                    }
                }
                
            }
        }
        }
}

struct MedicationRow_Previews: PreviewProvider {
    static var medications = ModelData().testMedis
    
    static var previews: some View {
        MedicationRow(
            items: Array(medications.prefix(4))
        )
    }
}
