//
//  SidebarMenuItemView.swift
//  monitool
//
//  Created by Christianto Budisaputra on 17/08/21.
//

import SwiftUI

struct SidebarMenuItemView: View {
    private let icon: String
    private let title: String
    private let view: AnyView

    init(type: SidebarMenuItem) {
        icon = type.icon
        title = type.title
        view = type.view
    }

    var body: some View {
        NavigationLink(destination: view) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
        }
    }
}
