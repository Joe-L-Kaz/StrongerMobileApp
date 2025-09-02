//
//  MainHeader.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 02/09/2025.
//

import SwiftUI

struct MainHeader: View {
    public let title : String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.largeTitle.bold())
            
            Divider()
        }
    }
}
