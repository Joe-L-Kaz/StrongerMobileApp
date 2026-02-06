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
    //@Environment(\.dismiss) var dismiss
    @State private var showSuccessAlert: Bool = false
    
    let goBack: () -> Void
    
    var body: some View {
        let onNextPressed: () -> Void = {
            viewModel.advanceStep()
        }
        let onBackPressed: () -> Void = {
            viewModel.previousStep()
        }
        let onSignInPressed: () -> Void = {
            Task {
                await viewModel.register(
                    forename: viewModel.forename,
                    surname: viewModel.surname,
                    dob: viewModel.dob,
                    email: viewModel.email,
                    password: viewModel.password,
                    confirmPassword: viewModel.confirmPassword,
                    onSuccess: {
                        showSuccessAlert = true
                    }
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
                            SetPassword(
                                password: $viewModel.password,
                                confirmPassword: $viewModel.confirmPassword,
                                isLoading: $viewModel.isLoading,
                                onSignInPressed: onSignInPressed,
                                onBackPressed: onBackPressed
                            )
                        }
                    }
                    
                    
                }
            
            HStack (spacing: 10){
                Text("Already have an account?")
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        goBack()
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
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Account created"),
                message: Text("Your account has been created successfully."),
                dismissButton: .default(Text("OK"), action: {
                    goBack()
                })
            )
        }
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
                InputField(value: $forename, placeholder: "John")
            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Surname:")
                InputField(value: $surname, placeholder: "Doe")
            }
            
            
            VStack (alignment: HorizontalAlignment.leading) {
                Text("Email:")
                InputField(value: $email, placeholder: "Email")
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
    var onBackPressed: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Password:")
                InputField(
                    value: $password,
                    placeholder: "Password",
                    isSecureTextEntry: true
                )
            }
            
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Confirm Password:")
                InputField(
                    value: $confirmPassword,
                    placeholder: "Confirm Password",
                    isSecureTextEntry: true
                )
            }
            HStack {
                StaticButton(onSubmit: onBackPressed){
                    Text("Back")
                }
                LoadingButton(isLoading: $isLoading, onSubmit: onSignInPressed) {
                    Text("Create")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    RegisterView(){}
}
