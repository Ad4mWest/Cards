//  CardAccountView.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI

struct CardAccountView: View {
    // MARK: Private properties
    @StateObject private var viewModel: CardAccountViewModel
    
    // MARK: Initialization
    init(viewModel: CardAccountViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Lifecycle
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Full name", text: $viewModel.profileStatePackage.data.name)
                    
                    Toggle(isOn: $viewModel.gender, label: {
                        viewModel.gender ? Text("Female") : Text("Male")
                    })
                    .toggleStyle(SwitchToggleStyle(tint: .mainAppC))
                    
                    Picker(selection: $viewModel.profileStatePackage.data.nationality) {
                        ForEach(Card.nationality, id: \.self) { nationality in
                            Text(nationality)
                        }
                    } label: {
                        Text("Nationality")
                    } .pickerStyle(.automatic)
                    
                    Picker(selection: $viewModel.profileStatePackage.data.age) {
                        ForEach(0..<110, id: \.self) { age in
                            Text("\(age)")
                        }
                    } label: {
                        Text("Age")
                    } .pickerStyle(.automatic)
                }
                Section(header: Text("Contacts")) {
                    TextField("Email", text: $viewModel.profileStatePackage.data.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Phone without code", text: $viewModel.profileStatePackage.data.phone)
                        .keyboardType(.phonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Contacts")) {
                    Button {
                        viewModel.saveChangesProfile()
                    } label: {
                        Text("Save profile")
                    } .foregroundColor(.red)
                }
            }
            .navigationTitle("Your Profile")
        }
        .onAppear {
            viewModel.retrieveCardData()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton)
        }
    }
    
}

struct CardAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CardAccountView(
            viewModel:
                CardAccountViewModel(
                    cardStatePackage:
                        ProfileStatePackage(
                            data:
                                Card()
                        )))
    }
}
