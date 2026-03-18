//
//  UserDetailView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 09/03/26.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
    @StateObject var viewModel: UserDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack(spacing: 30) {
                TextField("Please update username", text: $viewModel.userName, prompt: Text("Please update username"))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                }
                
                Button {
                   
                     viewModel.updateUser()
                     dismiss()
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView().tint(.primary)
                        } else {
                            Text("Update")
                        }
                    }
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

#Preview {
   /* UserDetailView(
            users:
                LoginModel(
                    username: "Sjb",
                    password: "123",
                    uuid: UUID()
                )
        )*/
}
