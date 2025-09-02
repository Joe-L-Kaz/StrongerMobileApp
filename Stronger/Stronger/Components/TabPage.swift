//
//  TabPage.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct TabPage<Content: View>: View {
    public let title: String
    
    @ViewBuilder public let content: () -> Content
    
    var body: some View {
        VStack {
            MainHeader(title: title)
            
            VStack(spacing: 10) {
                content()
            }
            .padding(.horizontal, 15)
            .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
