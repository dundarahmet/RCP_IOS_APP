//
//  PLCView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Firebase


struct PLCView: View {
    
    @State var plcModel: PLCModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showAlert = false
    @State private var isChange = false
    
    @State private var showError = false
    @State private var errorText = ""
    
    
    var body: some View {
        VStack {
            
            VStack {
                InformationView( text: "IP Address: \(self.plcModel.ipv4)")
                
                HStack {
                    InformationView( text: "Rack: \(self.plcModel.rackNumber)")
                    InformationView( text: "Slot: \(self.plcModel.slotNumber)")
                    InformationView( text: "Port: \(self.plcModel.portNumber)")
                }.padding(10)
            }.padding()
            
            DividerView()
            
            List(0 ..< self.plcModel.datablocks.count) { index in
                NavigationLink(destination: DatablockView(dbModel: self.$plcModel.datablocks[index], isChange: self.$isChange)) {
                    Text(self.plcModel.datablocks[index].dbName)
                }
            }
            
            DividerView()
            .alert(isPresented: self.$showError) { () -> Alert in
                Alert(title: Text("An error occurs when data is uploaded"), message: Text(self.errorText), dismissButton: Alert.Button.cancel())
            }
            
            Button(action: {
                self.showAlert.toggle()
            }) {
                Text("Upload")
                    .foregroundColor(.white)
            }
            .padding()
            .background(!self.isChange ? Color.gray : Color.blue)
            .cornerRadius(10)
            .padding(.bottom, 10)
            .disabled(!self.isChange)
            .alert(isPresented: self.$showAlert) { () -> Alert in
                Alert(title: Text("Are you sure?"), message: Text("This action cannot be undone."),
                      primaryButton: Alert.Button.default(Text("Continue"), action: {
                        self.upload()
                      }), secondaryButton: Alert.Button.cancel())
            }
            
        }.navigationBarTitle(Text(self.plcModel.name), displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
    
    private func upload() {
        // changer_id must be other or user_id
        
        if self.isChange {
            //upload data
            
            var reference: DatabaseReference!
            reference = Database.database().reference()
            
            self.isChange = false
            let uploadingData: [String : Any] = self.plcModel.getData()
            
            if !uploadingData.isEmpty {
                reference.updateChildValues(uploadingData) { (error, reference) in
                    if error != nil {
                        self.errorText = error!.localizedDescription
                        self.showError = true
                        return
                    }
                }
            }
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct InformationView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .padding(3)
            .overlay(Rectangle().stroke(lineWidth: 2))
    }
}

struct PLCView_Previews: PreviewProvider {
    static var previews: some View {
        PLCView(plcModel: PLCModel(id: "test", name: "test", ipv4: "255.255.255.255", rackNumber: 2, slotNumber: 2, portNumber: 9999, datablocks: [DatablockModel(id: 12, dbName: "123", size: 12, data: [DataModel(data_type: "123", name: "123", offset: Double(2), value: "sdfsdf")])]))
    }
}


