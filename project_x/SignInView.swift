//
//  SignInView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @Binding var viewChanger: Bool
    
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertText: String
    
    @State private var userEMail = ""
    @State private var userPassword = ""
    
    var body: some View {
        VStack {
            TextField("E-Mail", text: self.$userEMail)
                .keyboardType(UIKeyboardType.emailAddress)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                .padding(5)
                .overlay(Rectangle().stroke())
                .padding(.bottom, 10)
            
            SecureField("Password", text: self.$userPassword)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                .padding(5)
                .overlay(Rectangle().stroke())
                .disabled(self.userEMail.isEmpty)
            
                
            
            Button(action: {
                Auth.auth().signIn(withEmail: self.userEMail, password: self.userPassword) { (result, error) in
                    if error != nil {
                        self.alertTitle = "Sing In Error"
                        self.alertText = error!.localizedDescription
                        
                        self.userPassword = ""
                        
                        self.showAlert = true
                    } else {
                        self.viewChanger = true
                    }
                }
            }) {
                Text("Sign In")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding(10)
            .background(self.userPassword.isEmpty || self.userEMail.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(10)
            .padding(.top, 20)
            .disabled(self.userPassword.isEmpty || self.userEMail.isEmpty)
            
        }
        .navigationBarTitle("RCP System")
        .navigationBarHidden(self.viewChanger)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        
        return SignInView(viewChanger: .constant(false), showAlert: .constant(false), alertTitle: .constant("false"), alertText: .constant("false"))
    }
}
