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
    
    private enum Route: Hashable {
        case createAccount
    }
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
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
                                InputField(value: $viewModel.email, placeholder: "Email")
                                
                            }

                            VStack(alignment: HorizontalAlignment.leading) {
                                Text("Password:")
                                InputField(
                                    value: $viewModel.password,
                                    placeholder: "Password",
                                    isSecureTextEntry: true
                                )
                                
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
                
                
                HStack(spacing: 10) {
                    Text("Don't have an account?")
                    Button {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            path.append(Route.createAccount)
                        }
                    } label: {
                        Text("Sign Up")
                            .underline()
                    }
                    .buttonStyle(.plain)
                }
                .foregroundStyle(.black)
                
                
                
            }
            .padding(20)
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .createAccount:
                RegisterView() {
                    path = NavigationPath()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
