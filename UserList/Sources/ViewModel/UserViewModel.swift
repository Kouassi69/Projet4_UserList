//
//  UserViewModel.swift
//  UserList
//
//  Created by Kouassi Assoua on 01/03/2024.
//

import Foundation
import SwiftUI


class UserViewModel: ObservableObject {

    // TODO: - Those properties should be viewModel's OutPuts
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var isGridView = false

    // TODO: - The property should be declared in the viewModel
    private let repository : UserListRepository
    init(repository : UserListRepository) {
        self.repository = repository
    }

    // Fonction asynchrone pour charger la liste des utilisateurs
    @MainActor
    func loadUsers() async {
        
        do {
            let fetchedUsers = try await repository.fetchUsers(quantity: 20)
            DispatchQueue.main.async { [weak self] in
                self?.users = fetchedUsers
            }
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }

    // TODO: - Should be a viewModel's input
    func fetchUsers() {

        if Thread.isMainThread {
            print("Ce code s'exécute sur le thread principal.")
        } else {
            print("Ce code s'exécute sur un thread secondaire.")
        }

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

    /*func fetchUsers() {
        Task {
            isLoading = true // Cette ligne pourrait potentiellement être exécutée hors du thread principal
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                DispatchQueue.main.async { [weak self] in
                    self?.users.append(contentsOf: users)
                    self?.isLoading = false // Assurez-vous que ceci est exécuté sur le thread principal
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching users: \(error.localizedDescription)")
                    self.isLoading = false // Ceci doit également être sur le thread principal
                }
            }
        }
    }*/

    // TODO: - Should be an OutPut
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

    // TODO: - Should be a viewModel's input
    func reloadUsers() {
        users.removeAll()
        fetchUsers()// fetchUsers()
    }

    // Func getImage
    func getImage(user: User, dim: Bool) -> some View {
        let dim = dim ? 50.0 : 150.0
        return AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: dim, height: dim)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .frame(width: dim, height: dim)
                .clipShape(Circle())
        }
    }

}
