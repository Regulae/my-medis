//
//  EditUserView.swift
//  MyMedis
//
//  Created by Regula Susan Heisch on 01.08.21.
//
//

import SwiftUI

struct EditUserView: View {
    @State var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State var gender: String = UserDefaults.standard.string(forKey: "gender") ?? "Male"
    @State var age: String = UserDefaults.standard.string(forKey: "age") ?? ""
    @State var language: String = UserDefaults.standard.string(forKey: "language") ?? "German"

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                Text("First Name")
                TextField("First Name", text: $firstName)
                Text("Last Name")
                TextField("Last Name", text: $lastName)
                Picker("Gender", selection: $gender){
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                Picker("Language", selection: $language){
                    Text("German").tag("German")
                    Text("French").tag("French")
                    Text("Italian").tag("Italian")
                    Text("English").tag("English")
                }
            }
            HStack(alignment: .center) {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
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
        .navigationBarTitle("Edit User")
    }

    private func editUser() {
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(language, forKey: "language")
        self.presentationMode.wrappedValue.dismiss()
    }
}

