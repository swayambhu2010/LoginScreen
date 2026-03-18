//
//  Coordinator.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 18/03/26.
//

import Foundation
import Combine
import SwiftUI

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    private let containter: AppContainer
    
    init(containter: AppContainer) {
        self.containter = containter
    }
    
    func route(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func makeScreenView(to route: Route) -> some View {
        switch route {
        case .loginScreen:
            makeLoginView()
        case .userList:
            makeUserListView()
        case .userDetails(let users):
            makeUserDetails(user: users)
        }
    }
    
    func makeLoginView() -> LoginScreenView {
        let loginViewModel = LoginViewModel(loginUseCase: LoginUseCase(loginRepository: containter.loginRepository))
        return LoginScreenView(viewModel: loginViewModel)
    }
    
    func makeUserListView() -> UsersListView {
        let usersListViewModel = UserListViewModel(userListUseCase: UserListUseCase(userListRepository: containter.userListRepository))
        return UsersListView(viewModel: usersListViewModel)
    }
    
    func makeUserDetails(user: Binding<LoginModel>) -> UserDetailView {
        let userDetailViewModel = UserDetailViewModel(userDetailsUseCase: UserDetailsUseCase(userDetailsRepository: containter.userDetailsRepository))
        return UserDetailView(users: user, viewModel: userDetailViewModel)
    }
}
