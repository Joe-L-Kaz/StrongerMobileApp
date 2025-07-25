//
//  Login.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/07/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var authState : AuthenticationState
    
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
            
            AuthCard(
                email: $viewModel.email,
                password: $viewModel.password,
                isLoading: $viewModel.isLoading,
                login: {
                    Task {
                        await viewModel.login() { success in
                            authState.isAuthenticated = success
                        }
                    }
                }
            )
            
            Button(action: {
                print("")
            }) {
                Text("Sign Up")
                    .foregroundStyle(Color.black)
            }
        }
        .padding(20)
    }
}

struct AuthCard: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isLoading: Bool
    var login: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Lets sign you in:")
                .bold(true)
                .font(.headline)
            
            VStack (alignment: HorizontalAlignment.leading) {
                Text("Email:")
                
                TextField("Username", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                
            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Password:")
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            
            Button(action: {
                login()
            }) {
                if isLoading {
                    HStack {
                        ProgressView()
                            .tint(Color.white)
                        
                        Text("Sign In")
                            .foregroundColor(.white)
                    }
                    .padding(10)
                } else {
                    Text("Sign In")
                        .padding(10)
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
            .cornerRadius(5)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 5, x: 0, y: -1)
    }
    
}

#Preview {
    LoginView()
}
