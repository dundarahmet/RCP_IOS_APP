//
//  testView.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 5.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Combine

struct testView: View {
    @State private var test = ""
    
    var body: some View {
        TextField("Enter some text", text: self.$test)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
