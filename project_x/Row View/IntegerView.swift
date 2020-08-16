//
//  IntegerView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Combine

struct IntegerView: View {
    
    @Binding var value: Any
    @State var interfaceValue: String
    
    var body: some View {
        return HStack {
            Text("Value: ")
            
            TextField("", text: self.$interfaceValue)
                .onReceive(Just(interfaceValue)) { (newValue) in
                    var filtered = newValue.filter { (Char) -> Bool in
                        return "-1234567890".contains(Char)
                    }
                    if let number = Int(filtered) {
                        if number > 32767 || number < -32768{
                            filtered = String(number / 10)
                        } else {
                            filtered = String(number)
                        }
                    } else if filtered.count > 1 {
                        let ristrictor_index: String.Index!
                        
                        if filtered.first! != "-" {
                            ristrictor_index = filtered.firstIndex(of: "-")!
                            filtered = String(filtered[..<ristrictor_index])
                        } else {
                            let first_index = filtered.index(after: filtered.startIndex)
                            ristrictor_index = String(filtered[first_index...]).firstIndex(of: "-")!
                            filtered = String(filtered[...ristrictor_index])
                        }
                    }
                    
                    if let number = Int(filtered) {
                        self.value = number
                    } else {
                        self.value = 0
                    }
                    self.interfaceValue = filtered
            }
                
        .padding([.leading, .bottom], 3.0)
        .overlay(Rectangle().stroke(lineWidth: CGFloat(1.5)))
        }
    }
}

struct IntegerView_Previews: PreviewProvider {
    static var previews: some View {
        IntegerView(value: .constant("Helele"), interfaceValue: "4")
    }
}
