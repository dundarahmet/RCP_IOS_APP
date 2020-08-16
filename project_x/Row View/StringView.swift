//
//  StringView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Combine

struct StringView: View {
    
    @Binding var value: Any
    @State var interfaceValue: String
    
    var body: some View {
        return HStack {
            Text("Value: ")
            
            TextField("", text: self.$interfaceValue)
                .disableAutocorrection(true)
                .onReceive(Just(interfaceValue)) { (newValue) in
                    
                    let filtered = newValue.filter { (char) -> Bool in
                        return char.isASCII
                    }
                    
                    
                    if filtered.count > 250 {
                        let ristrictor_index = newValue.index(newValue.startIndex, offsetBy: 254)
                        self.interfaceValue = String(filtered[...ristrictor_index])
                    } else {
                        self.interfaceValue = filtered
                    }
                    
                    self.value = self.interfaceValue                    
            }
        }
        .padding([.leading, .bottom], 3.0)
        .overlay(Rectangle().stroke(lineWidth: CGFloat(1.5)))
    
    }
}


struct StringView_Previews: PreviewProvider {
    static var previews: some View {
        StringView(value: .constant("Hebele"), interfaceValue: "Heheh")
    }
}
