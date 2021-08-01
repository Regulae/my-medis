//
//  EditUserView.swift.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 01.08.21.
//
//

import SwiftUI

struct EditUserView_swift: View {
       @State var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""

    var body: some View {
        VStack {
            Form {
                Text("First Name")
                TextField("First Name", text: $firstName)

            }
            HStack(alignment: .center) {
                Button(action: {}) {
                    Text("Cancel")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: editUser) {
                    Text("Save")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                }
                        .background(Color("red"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            }
                    .padding(.bottom)
        }
    }

    private func editUser(){
        UserDefaults.standard.set(firstName, forKey: "firstname");
    }
}

