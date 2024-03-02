//
//  myGridView.swift
//  UserList
//
//  Created by Kouassi Assoua on 02/03/2024.
//

import SwiftUI

struct myGridView: View {
    @ObservedObject var myViewModel: UserViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(myViewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        VStack {
                            myViewModel.getImage(user: user, dim: !myViewModel.isGridView)

                            Text("\(user.name.first) \(user.name.last)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .onAppear {
                        if myViewModel.shouldLoadMoreData(currentItem: user) {
                            print("hereprint()")
                            myViewModel.fetchUsers()
                        }
                    }
                }
            }
        }
        .configureNavigationAndToolbar(with: myViewModel, isGridView: $myViewModel.isGridView)
    }
}

#Preview {
    myListView(myViewModel: UserViewModel(repository: UserListRepository()))
}
