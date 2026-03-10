//
//  UsersListView.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 10/03/26.
//

import SwiftUI

struct UsersListView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.users, id: \.self) { user in
                Text("\(user.userName ?? "") is saved")
            }
            .onDelete { indexSet in
                deleteUser(indexSet: indexSet)
            }
        }
    }
    
    func deleteUser(indexSet: IndexSet) {
        viewModel.deleteUser(indexSet: indexSet)
    }
}

#Preview {
    UsersListView(viewModel: LoginViewModel(dataBaseManager: DataBaseManager()))
}
