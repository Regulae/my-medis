//
//  UserView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 11.07.21.
//
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var draftUser = User.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Firstname: \(draftUser.firstName)")
        }
    }
}
