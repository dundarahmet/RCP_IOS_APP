//
//  RowView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    @Binding var dataModel: DataModel
    
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showDetail.toggle()
            }) {
                Text(self.dataModel.name)
                    .font(.system(size: CGFloat(20)))
                    .frame(width: UIScreen.main.bounds.width * 0.90)
            }
            
            if self.showDetail {
                DataView(dataModel: self.$dataModel)
                    .padding(5)
                    .overlay(Rectangle().stroke(Color.red, lineWidth: 1))
            } else {
                EmptyView()
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(dataModel: .constant(DataModel(data_type: "String", name: "string_1", offset: Double(0), value: "Ahmet")))
    }
}
