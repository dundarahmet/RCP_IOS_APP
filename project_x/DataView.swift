//
//  DataView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct DataView: View {
    
    @Binding var dataModel: DataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: CGFloat(5)) {
            
            Text("Data Type: \(self.dataModel.data_type)")
            Text("Offset: \(self.dataModel.offset, specifier: "%.4f")")
            
            if self.dataModel.data_type == "Bool" {
                BoolView(value: self.$dataModel.value)
            } else if self.dataModel.data_type == "String" {
                StringView(value: self.$dataModel.value, interfaceValue: self.dataModel.value as! String)
            } else if self.dataModel.data_type == "Real" {
                RealView(value: self.$dataModel.value, interfaceValue: String((self.dataModel.value as! NSNumber).floatValue))
            } else {
                IntegerView(value: self.$dataModel.value, interfaceValue: String(self.dataModel.value as! Int))
            }
            
        }.padding(5)
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(dataModel: .constant(DataModel(data_type: "String", name: "string_1", offset: Double(0), value: "Hello")))
    }
}
