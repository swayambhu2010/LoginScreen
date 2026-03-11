//
//  UsersListView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var viewModel: UserListViewModel = UserListViewModel(userListUseCase: UserListUseCase(userListRepository: UsersListRepository()))
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.users, id: \.uuid) { $user in
                    NavigationLink {
                        UserDetailView(users: $user)
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
    }
    
    func deleteUser(indexSet: IndexSet) {
        viewModel.deleteUser(indexSet: indexSet)
    }
}

#Preview {
    UsersListView()
}
