//
//  PLCListView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Firebase

struct PLCListView: View {
    @Binding var viewChanger: Bool
    @Binding var alertTitle: String
    @Binding var alertText: String
    
    @State private var hideBarItems = false
    
    @ObservedObject var plcStore = PLCStore()
    
    var body: some View {
        NavigationView {
            List(self.plcStore.PLCModelArray) { plcModel in
                NavigationLink(destination: PLCView(plcModel: plcModel)) {
                    Text(plcModel.name)
                }
            }
            .navigationBarItems(leading: Button(action: {
                do {
                    try Auth.auth().signOut()
                    
                } catch {
                    self.alertTitle = "ERROR"
                    self.alertText = "an error occurs when system is tried sign out"
                }
                self.plcStore.reference.removeAllObservers()
                self.viewChanger = false
            }, label: {
                Text("Log Out")
            }))
        }
    .navigationBarHidden(true)
    }
}

struct PLCListView_Previews: PreviewProvider {
    static var previews: some View {
        PLCListView(viewChanger: .constant(false), alertTitle: .constant("Test"), alertText: .constant("Hello"))
    }
}
