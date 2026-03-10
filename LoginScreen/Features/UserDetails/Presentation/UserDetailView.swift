//
//  UserDetailView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 09/03/26.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
     var user: UserData
    // @State private var userName = ""
    @StateObject var viewModel: UserDetailViewModel = UserDetailViewModel(userDetailsUseCase: UserDetailsUseCase(userDetailsRepository: UserDetailsRepository(databaseManager: DataBaseManager())))
    
    @Environment(\.dismiss) var dismiss
    
    // If not an coredata object then alternative way
    /* init(user: UserData, userName: String, viewModel: LoginViewModel) {
        self.user = user
     // To check which one from the below actually works
         self.userName = userName
        _userName = State(initialValue: userName)
        self.viewModel = viewModel
    } */
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Below Binding works because user is a coredata object
                TextField("Please update username", text: Binding(
                    get: { user.userName ?? "" },
                    set: { user.userName = $0 }
                ), prompt: Text("Please update username"))
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
   UserDetailView(user: UserData(), viewModel: UserDetailViewModel(userDetailsUseCase: UserDetailsUseCase(userDetailsRepository: UserDetailsRepository(databaseManager: DataBaseManager()))))
}
