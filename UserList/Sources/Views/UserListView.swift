import SwiftUI

struct UserListView: View {
    
   @ObservedObject var myViewModel: UserViewModel
    // TODO: - Those properties should be viewModel's OutPuts
    //@State private var users: [User] = []
    //@State var isLoading = false
    //@State private var isGridView = false


    // TODO: - The property should be declared in the viewModel
    //private let repository = UserListRepository()

    var body: some View {
            NavigationView {
                if !myViewModel.isGridView {
                    // On affiche une liste des contacts
                    myListView(myViewModel: myViewModel)
                } else {
                    myGridView(myViewModel: myViewModel)
                }
            }
        .onAppear {
            myViewModel.fetchUsers()
        }
    }

    // TODO: - Should be a viewModel's input
   /* private func fetchUsers() {
        isLoading = true
        Task {
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                self.users.append(contentsOf: users)
                isLoading = false
            } catch {
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }

    // TODO: - Should be an OutPut
    private func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = myViewModel.users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

    // TODO: - Should be a viewModel's input
    private func reloadUsers() {
        myViewModel.users.removeAll()
        myViewModel.fetchUsers()// fetchUsers()
    }

// Func Liste ou Grid
   private func listOrGrid() {

        List(users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                HStack {
                    getImage(user: user, dim: !isGridView)

                    VStack(alignment: .leading) {
                        Text("\(user.name.first) \(user.name.last)")
                            .font(.headline)
                        Text("\(user.dob.date)")
                            .font(.subheadline)
                    }
                }
            }
            .onAppear {
                if self.shouldLoadMoreData(currentItem: user) {
                    self.fetchUsers()
                }
            }
        }
        .navigationTitle("Users")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker(selection: $isGridView, label: Text("Display")) {
                    Image(systemName: "rectangle.grid.1x2.fill")
                        .tag(true)
                        .accessibilityLabel(Text("Grid view"))
                    Image(systemName: "list.bullet")
                        .tag(false)
                        .accessibilityLabel(Text("List view"))
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    reloadUsers()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            }
        }
    }

    func listView() -> some View {
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
    func gridView() -> some View {
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
    }*/
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(myViewModel: UserViewModel(repository: UserListRepository()))
    }
}
