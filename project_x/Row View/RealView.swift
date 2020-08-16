//
//  RealView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Combine


struct RealView: View {
    
    @Binding var value: Any
    @State var interfaceValue: String
    
    var body: some View {
        HStack {
            Text("Value: ")
            TextField("", text: self.$interfaceValue)
                .onReceive(Just(interfaceValue)) { (newValue) in
                    var filtered = newValue.filter { (char) -> Bool in
                        "-1234567890.".contains(char)
                    }
                    if Float(filtered) == nil {
                        if filtered.count > 1 {
                            let last_index = filtered.index(before: filtered.endIndex)
                            filtered = String(filtered[..<last_index])
                        } else if filtered.first == "." {
                            filtered = ""
                        }
                    }
                    
                    self.interfaceValue = filtered
                    
                    self.value = Float(filtered) ?? Float(0)
                    
            }
        }
        .padding([.leading, .bottom], 3.0)
        .overlay(Rectangle().stroke(lineWidth: CGFloat(1.5)))
    }
}

struct RealView_Previews: PreviewProvider {
    static var previews: some View {
        RealView(value: .constant("gsdg"), interfaceValue: "5")
    }
}
