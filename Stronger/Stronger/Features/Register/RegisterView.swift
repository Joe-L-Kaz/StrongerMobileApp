//
//  RegisterView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//

import SwiftUI

struct Register: View {
    var body: some View {
        VStack (spacing: 20){
            HStack (spacing: 20) {
                Text("Stronger")
                    .font(.largeTitle)
                    .bold(true)
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
        .padding(20)
    }
}
