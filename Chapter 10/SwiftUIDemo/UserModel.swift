//
//  LoginModel.swift
//  SwiftUIDemo
//
//  Created by Surabhi Chopada on 10/03/2024.
//

import SwiftUI

class UserModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}
