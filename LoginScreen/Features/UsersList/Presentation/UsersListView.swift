import SwiftUI

struct UsersListView: View {

    @StateObject var viewModel: UserListViewModel

    var body: some View {
        List {
            ForEach(viewModel.users, id: \.uuid) { user in
                Button {
                    viewModel.selectUser(user: user)
                } label: {
                    HStack {
                        Text("\(user.username) is saved")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .buttonStyle(.plain)
            }
            .onDelete { indexSet in
                viewModel.deleteUser(indexSet: indexSet)
            }
        }
        .onAppear {
            viewModel.getAllUsers()
        }
        .navigationTitle("User List")
    }
}
