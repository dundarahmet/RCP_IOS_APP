//
//  ContentView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var viewChanger: Bool = false
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertText = ""
    
    var body: some View {
        NavigationView {
            if self.viewChanger {
                PLCListView(viewChanger: self.$viewChanger,
                            alertTitle: self.$alertTitle,
                            alertText: self.$alertText)
            } else {
                SignInView(viewChanger: self.$viewChanger,
                           showAlert: self.$showAlert,
                           alertTitle: self.$alertTitle,
                           alertText: self.$alertText)
            }
        }.alert(isPresented: self.$showAlert) { () -> Alert in
            Alert(title: Text(self.alertTitle),
                  message: Text(self.alertText),
                dismissButton: Alert.Button.cancel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
