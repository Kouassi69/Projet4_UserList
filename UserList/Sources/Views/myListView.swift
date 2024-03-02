//
//  myListView.swift
//  UserList
//
//  Created by Kouassi Assoua on 02/03/2024.
//

import SwiftUI

struct myListView: View {
    @ObservedObject var myViewModel: UserViewModel
    var body: some View {
        List(myViewModel.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                HStack {
                    myViewModel.getImage(user: user, dim: !myViewModel.isGridView)

                    VStack(alignment: .leading) {
                        Text("\(user.name.first) \(user.name.last)")
                            .font(.headline)
                        Text("\(user.dob.date)")
                            .font(.subheadline)
                    }
                }
            }
            .onAppear {
                if myViewModel.shouldLoadMoreData(currentItem: user) {
                    myViewModel.fetchUsers()
                }
            }
        }
        .configureNavigationAndToolbar(with: myViewModel, isGridView: $myViewModel.isGridView)
    }
}

#Preview {
    myListView(myViewModel: UserViewModel(repository: UserListRepository()))
}
