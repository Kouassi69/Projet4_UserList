import SwiftUI

struct UserListView: View {
    
   @ObservedObject var myViewModel: UserViewModel

    var body: some View {
            NavigationView {
                if !myViewModel.isGridView {
                    myListView(myViewModel: myViewModel)
                } else {
                    myGridView(myViewModel: myViewModel)
                }
            }
        .onAppear {
            Task {
                await myViewModel.loadUsers()
                print(UserViewModel(repository: UserListRepository()))
            }
            myViewModel.fetchUsers()

        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(myViewModel: UserViewModel(repository: UserListRepository()))
    }
}
