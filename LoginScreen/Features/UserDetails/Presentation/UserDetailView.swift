//
//  UserDetailView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 09/03/26.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
    @Binding var users: LoginModel
    @StateObject var viewModel: UserDetailViewModel = AppContainer.shared.makeUserDetailsViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                TextField("Please update username", text: $users.username, prompt: Text("Please update username"))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                }
                
                Button {
                     viewModel.updateUser(user: users)
                     dismiss()
                } label: {
                    Text("Update")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        }
                }
            }
            .navigationTitle("User Details")
            .padding()
        }
    }
}

#Preview {
    UserDetailView(
            users: .constant(
                LoginModel(
                    username: "Sjb",
                    password: "123",
                    uuid: UUID()
                )
            )
        )
}
