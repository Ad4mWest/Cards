//  CardAccountView.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import SwiftUI

struct CardAccountView: View {
    // MARK: Private properties
    @ObservedObject private var viewModel: CardAccountViewModel
    
    // MARK: Initialization
    init(viewModel: CardAccountViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Lifecycle
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Full name", text: $viewModel.card.name)
                    TextField("Gender", text: $viewModel.card.gender)
                    Picker(selection: $viewModel.card.nationality) {
                        ForEach(Card.nationality, id: \.self) { nationality in
                            Text(nationality)
                        }
                    } label: {
                        Text("Nationality")
                    }
                    .pickerStyle(.automatic)
                    Picker(selection: $viewModel.card.age) {
                        ForEach(0..<110, id: \.self) { age in
                            Text("\(age)")
                        }
                    } label: {
                        Text("Age")
                    }
                    .pickerStyle(.automatic)
                }
                Section(header: Text("Contacts")) {
                    TextField("Email", text: $viewModel.card.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Phone without code", text: $viewModel.card.phone)
                        .keyboardType(.phonePad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Contacts")) {
                    Button("Save profile") {
                        viewModel.saveChangesProfile()
                    } .foregroundColor(.mainAppC)
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
                dismissButton: alertItem.dismissButton
            )
        }
    }
}

struct CardAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CardAccountView(
            viewModel:
                CardAccountViewModel(
                    profileStorageService:  ProfileStorageServiceImpl()
                )
        )
    }
}
