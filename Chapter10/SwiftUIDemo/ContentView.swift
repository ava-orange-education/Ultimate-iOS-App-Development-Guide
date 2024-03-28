//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Surabhi Chopada on 10/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserModel()
    @State private var showAlert = false
    @State private var registerStatus = false
    var body: some View {
        VStack(){
            Text("Create Account")
                .font(.title)
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .padding()
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                registerStatus = false
                showAlert.toggle()
                if(!viewModel.name.isEmpty && !viewModel.email.isEmpty && !viewModel.password.isEmpty){
                    registerStatus.toggle()
                }
            }
        label: {
            Text("Create Account")
                .font(.system(size: 18, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(10)
        }.alert(isPresented: $showAlert) {
            if registerStatus {
                return Alert(title: Text("Welcome \(viewModel.name)"), message: Text("You have successfully registered"), dismissButton: .default(Text("OK")))
            } else {
                return  Alert(title: Text("Failed to register"), message: Text("Please enter all the details"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        }
    }
}

#Preview {
    ContentView()
}
