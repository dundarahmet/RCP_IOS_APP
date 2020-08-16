//
//  PLCModel.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Firebase

struct PLCModel: Identifiable {
    // id is id coming from firebase
    var id: String
    
    var name: String
    
    var ipv4: String
    var rackNumber: Int
    var slotNumber: Int
    var portNumber: Int
    
    var datablocks: [DatablockModel]
    
    func getData() -> [String : Any]{
        
        var data: [String : Any] = [:]
        
        for dbModel in self.datablocks {
            if dbModel.isChange {
                let getData = dbModel.getData()
                if getData.isEmpty {
                    continue
                }
                for (key, value) in zip(getData.keys, getData.values) {
                    data["/\(self.id)/current/datablocks/\(key)"] = value
                }
            }
        }
        
        if data.isEmpty {
            return [:]
        }
        
        data["/\(self.id)/changer_id"] = Auth.auth().currentUser!.uid
        
        return data
    }
}
