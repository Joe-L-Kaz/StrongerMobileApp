//
//  Sheet.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/11/2025.
//

import SwiftUI

struct Sheet<Content: View> : View {
    @ViewBuilder public let content: () -> Content
    
    var body: some View {
        VStack ( alignment: .center, spacing: 10){
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}
