//
//  RegisterView.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 22/07/2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var authState : AuthenticationState
    
    var body: some View {
        let onNextPressed: () -> Void = {
            viewModel.advanceStep()
        }
        let onSignInPressed: () -> Void = {
            Task {
                await viewModel.register(
                    forename: viewModel.forename,
                    surname: viewModel.surname,
                    dob: viewModel.dob,
                    email: viewModel.email,
                    password: viewModel.password,
                    confirmPassword: viewModel.confirmPassword
                )
            }
        }
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
                actionButtonLabel: "Sign Up",
            ){
                    Group {
                        if viewModel.step == 1 {
                            EnterDetails(
                                forename: $viewModel.forename,
                                surname: $viewModel.surname,
                                email: $viewModel.email,
                                dob: $viewModel.dob,
                                isLoading: $viewModel.isLoading,
                                onNextPressed: onNextPressed
                            )
                        } else {
                            SetPassword(password: $viewModel.password, confirmPassword: $viewModel.confirmPassword, isLoading: $viewModel.isLoading, onSignInPressed: {
                                onSignInPressed()
                            })
                        }
                    }
                    
                    
                }
            
            HStack (spacing: 10){
                Text("Already have an account?")
                NavigationLink(destination: LoginView()) {
                    Text("Sign In")
                        .underline(true)
                }
            }
            .foregroundStyle(.black)
        }
        .padding(20)
    }
}

fileprivate struct EnterDetails: View {
    @Binding var forename: String
    @Binding var surname: String
    @Binding var email: String
    @Binding var dob: Date
    @Binding var isLoading: Bool
    var onNextPressed: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Name:")
                TextField("John", text: $forename)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Surname:")
                TextField("Doe", text: $surname)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            
            
            VStack (alignment: HorizontalAlignment.leading) {
                Text("Email:")
                TextField("email", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)

            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Date of Birth:")
                DatePicker("Birthdate", selection: $dob, displayedComponents: .date)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            
            VStack (alignment: HorizontalAlignment.center) {
                StaticButton(onSubmit:{
                    onNextPressed()
                }){
                    Text("Next")
                }
            }
            .frame(maxWidth: .infinity)
            
            
        }
    }
    
}

fileprivate struct SetPassword: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isLoading: Bool
    var onSignInPressed: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Password:")
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Confirm Password:")
                SecureField("Password", text: $confirmPassword)
                    .textInputAutocapitalization(.never)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
            }
            VStack (alignment: HorizontalAlignment.center) {
                LoadingButton(isLoading: $isLoading, onSubmit: onSignInPressed) {
                    Text("Sign In")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    RegisterView()
}
