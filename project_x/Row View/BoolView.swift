//
//  BoolView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct BoolView: View {
    
    @Binding var value: Any
    
    var body: some View {
        
        var toggleValue = Binding(get: {
            return self.value as! Bool
        }) { (newValue) in
            if newValue != self.value as! Bool {
                self.value = newValue
            }
        }

        return Toggle(isOn: toggleValue) {
            Text("Value")
        }
        .padding(3)
        .overlay(Rectangle().stroke(lineWidth: CGFloat(1.5)))
    }
}

struct BoolView_Previews: PreviewProvider {
    static var previews: some View {
        BoolView(value: .constant("true"))
    }
}
