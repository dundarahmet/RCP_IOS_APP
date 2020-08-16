//
//  DatablockModel.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI


struct DatablockModel: Identifiable {
    var id: Int
    var dbName: String
    var size: Int
    var data: [DataModel]
    var isChange: Bool = false
    
    func getData() -> [String : Any] {
        var returningData: [String : Any] = [:]
        for index in 0 ..< self.data.count {
            if self.data[index].isChange {
                returningData["\(self.dbName)/data/\(index)/Value"] = self.data[index].value
            }
        }
        return returningData.isEmpty ? [:] : returningData
    }
}
