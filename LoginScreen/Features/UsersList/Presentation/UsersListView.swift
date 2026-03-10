//
//  UsersListView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var viewModel: UserListViewModel = UserListViewModel(userListUseCase: UserListUseCase(userListRepository: UsersListRepository(databaseManager: DataBaseManager())))
    var userName: String
    var password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users, id: \.self) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        Text("\(user.userName ?? "") is saved")
                    }
                }
                .onDelete { indexSet in
                    deleteUser(indexSet: indexSet)
                }
            }
            .onAppear {
                viewModel.saveUser(userName: userName, passWord: password)
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
    UsersListView(userName: "Demo", password: "Demo")
}
