//
//  ViewExtensions.swift
//  UserList
//
//  Created by Kouassi Assoua on 02/03/2024.
//

import Foundation

import SwiftUI

extension View {
    func configureNavigationAndToolbar(with myViewModel: UserViewModel, isGridView: Binding<Bool>) -> some View {
        self
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: isGridView, label: Text("Display")) {
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
                        myViewModel.reloadUsers()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    }
                }
            }
    }
}

//let uUser: User = User(user: UserListResponse.User(from: .UTF8))
