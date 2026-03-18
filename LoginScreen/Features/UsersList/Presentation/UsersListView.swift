//
//  UsersListView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var viewModel: UserListViewModel
    
    var body: some View {
            List {
                ForEach($viewModel.users, id: \.uuid) { $user in
                    Button {
                        viewModel.selectUser(user: user)
                    } label: {
                        Text("\(user.username) is saved")
                    }
                }
                .onDelete { indexSet in
                    deleteUser(indexSet: indexSet)
                }
            }
            .onAppear {
                viewModel.getAllUsers()
            }
            .navigationTitle("User List")
    }
    
    func deleteUser(indexSet: IndexSet) {
        viewModel.deleteUser(indexSet: indexSet)
    }
}

/*#Preview {
    UsersListView()
}*/
