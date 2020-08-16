//
//  DatablockView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct DatablockView: View {
    
    @Binding var datablockModel: DatablockModel
    @Binding var isChange: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var saveAlert = false
    @State private var data: [DataModel] = []
    
    init(dbModel: Binding<DatablockModel>, isChange: Binding<Bool>) {
        self._datablockModel = dbModel
        self._isChange = isChange
        self._data = State(initialValue: self.datablockModel.data)
    }
    
    var body: some View {
        
        VStack {
            ScrollView {
                ForEach(0 ..< self.data.count) { index in
                    RowView(dataModel: self.$data[index])
                    DividerView()
                }.padding(.top, 10)
            }.frame(width: UIScreen.main.bounds.width * 0.95)
            
            DividerView()
            
            Button(action: {
                self.saveAlert.toggle()
            }) {
                Text("Save")
                    .foregroundColor(.white)
            }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.bottom, 10)

        }.navigationBarTitle(Text("\(self.datablockModel.dbName) | Size: \(self.datablockModel.size)"),
                             displayMode: NavigationBarItem.TitleDisplayMode.inline)
            
            .alert(isPresented: self.$saveAlert) { () -> Alert in
                Alert(title: Text("Are you sure?"), message: Text("You are saving the data for uploading database."),
                      primaryButton: Alert.Button.default(Text("Continue"), action: { self.saveFile() }),
                      secondaryButton: Alert.Button.cancel())
        }
    }
    
    private func saveFile() {
        for index in 0 ..< self.data.count {
            if (self.datablockModel.data[index] != self.data[index]){
                self.datablockModel.data[index] = self.data[index]
                self.datablockModel.data[index].isChange = true
                if !self.datablockModel.isChange {
                    self.datablockModel.isChange = true
                    self.isChange = true
                }
            }
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DatablockView_Previews: PreviewProvider {
    static var previews: some View {
        DatablockView(dbModel: .constant(DatablockModel(id: 1, dbName: "test", size: 123, data: [DataModel(data_type: "asd", name: "asd", offset: Double(43), value: "543")])), isChange: .constant(true))
    }
}
