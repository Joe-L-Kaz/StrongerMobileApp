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
                isLoading: $viewModel.isLoading,
                actionButtonLabel: "Sign In"
            ){
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack (alignment: HorizontalAlignment.leading) {
                            Text("Email:")
                            
                            TextField("Username", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                                .padding(5)
                                .background(Color.gray.opacity(0.1))
                            
                                .cornerRadius(5)
                            
                        }

                        VStack(alignment: HorizontalAlignment.leading) {
                            Text("Password:")
                            SecureField("Password", text: $viewModel.password)
                                .textInputAutocapitalization(.never)
                                .padding(5)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                        }
                        
                        VStack (alignment: HorizontalAlignment.center) {
                            LoadingButton(isLoading: $viewModel.isLoading, onSubmit: {
                                Task {
                                    await viewModel.login() { success in
                                        authState.isAuthenticated = success
                                    }
                                }
                            }){
                                Text("Sign In")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            
            
            HStack (spacing: 10){
                Text("Don't have an account?")
                NavigationLink(destination: RegisterView()) {
                    Text("Sign Up")
                        .underline(true)
                }
                .underline(true)
            }
            .foregroundStyle(.black)
            
            
            
        }
        .padding(20)
    }
}

#Preview {
    LoginView()
}
