//
//  LoginScreenView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 05/03/26.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextFieldProvider(isSecureField: false, placeHolderText: "Please enter your username", text: $viewModel.userName)
                TextFieldProvider(isSecureField: true, placeHolderText: "Please enter your password", text: $viewModel.password)
                HintText(hintText: $viewModel.passwordHintText)
                
                Button {
                    // Action
                    viewModel.validation()
                } label: {
                    Text("SignUp")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        })
                }
                .padding()
            }
            .navigationTitle("Login Page")
            .navigationDestination(isPresented: $viewModel.isValidPassword) {
                UsersListView()
            }
            .alert("Warning", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: {_ in viewModel.errorMessage = nil }
                )
            ) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

struct TextFieldProvider: View {
    var isSecureField: Bool = false
    var placeHolderText: String = ""
    // This will work but it will tightly couple the view so instead use Binding
   // @ObservedObject var viewModel: LoginViewModel
    
    @Binding var text: String
    
    var body: some View {
        if isSecureField {
            SecureField(placeHolderText, text: $text, prompt: Text(placeHolderText))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(.horizontal, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                })
                .padding(.horizontal)
        } else {
            TextField(placeHolderText, text: $text, prompt: Text(placeHolderText))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(.horizontal, 10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                })
                .padding()
        }
    }
}

struct HintText: View {
    @Binding var hintText: String
    var body: some View {
        Text(hintText)
            .font(.default)
            .foregroundColor(.red)
            .padding(.horizontal)
    }
}

#Preview {
    LoginScreenView()
}
