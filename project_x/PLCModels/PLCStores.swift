//
//  PLCStores.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI
import Firebase
import Combine


class PLCStore: ObservableObject {
    
    var PLCModelArray: [PLCModel] = []
    var reference: DatabaseReference!
    
    var objectWillChange = PassthroughSubject<Array<PLCModel>, Never>()
    
    init() {
        self.reference = Database.database().reference()
        self.reference.observe(DataEventType.value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                self.AddNewPLC(database: value)
            }
        }
    }
    
    private func AddNewPLC(database: NSDictionary) {
        if database.count == 0 {
            return
        }
        
        self.PLCModelArray.removeAll(keepingCapacity: false)
        
        for key in database.allKeys { // first for loop
            if let id = key as? String {
                    // create new plc
                if let plc = database.value(forKey: id) as? NSDictionary {
                    if let parameters = plc.value(forKey: "plc_parameters") as? NSDictionary,
                        let current = plc.value(forKey: "current") as? NSDictionary,
                        let plc_name = plc.value(forKey: "plc_name") as? String {
                            
                        if let datablocks = current.value(forKey: "datablocks") as? NSDictionary {
                                    
                            if let ipv4 = parameters.value(forKey: "Ip_Address") as? String,
                                let rack = parameters.value(forKey: "Rack") as? Int,
                                let slot = parameters.value(forKey: "Slot") as? Int ,
                                let port = parameters.value(forKey: "Port") as? Int {
                                
                                var dbArray: [DatablockModel] = []
                                for dbName in datablocks.allKeys {
                                    // create DatablockModeland add DatablockModel to dbArray
                                    if let dbKey = dbName as? String, let db = datablocks.value(forKey: dbKey) as? NSDictionary {
                                        let dbModel = self.createDatablockModel(id: dbArray.count, name: dbKey, db: db)
                                        dbArray.append(dbModel)
                                    } else { print("Problem in dbKey or db// dbName: \(dbName)") }
                                }
                                let plcModel = PLCModel(id: id, name: plc_name,
                                                        ipv4: ipv4, rackNumber: rack, slotNumber: slot, portNumber: port, datablocks: dbArray)
                                self.PLCModelArray.append(plcModel)
                            } else { print("Problem in checking ip_address, rack or slot") }
                        } else { print("Problem in checking datablocks") }
                    } else { print("Problem in checking parameters, plc_name or current") }
                } else { print("Problem in creating plc variable") }
        }// get key as string
    }// start first for loop
        self.objectWillChange.send(self.PLCModelArray)
}
    
    private func createDatablockModel(id: Int, name: String, db: NSDictionary) -> DatablockModel {
        var dataModelArray: [DataModel] = []
        
        guard let size = db.value(forKey: "size") as? Int else {
            return DatablockModel(id: id, dbName: "ERROR", size: 1, data: dataModelArray)
        }
        
        if let dataArray = db.value(forKey: "data") as? NSArray {
            for item in dataArray {
                if let row = item as? NSDictionary {
                    if let data_type = row.value(forKey: "Data_type") as? String,
                        let row_name = row.value(forKey: "Name") as? String,
                        let offset = row.value(forKey: "Offset") as? Double,
                        let raw_value = row.value(forKey: "Value") {
                        
                        var value: Any
                        
                        switch data_type {
                        case "Bool":
                            value = raw_value as! Bool
                        case "String":
                            value = raw_value as! String
                        case "Real":
                            value = (raw_value as! NSNumber).floatValue
                        case "Int":
                            value = raw_value as! Int
                        default:
                            continue
                        }
                        let dataModel = DataModel(data_type: data_type,
                                                  name: row_name, offset: offset, value: value)
                        
                        dataModelArray.append(dataModel)
                        
                    } else { print("Problem in data_type, row_name, offset or value") }
                } else { print("Problem in row in createDatablockModel") }
            }
        } else { print("Problem in dataArray in createDatablockModel") }
        return DatablockModel(id: id, dbName: name, size: size, data: dataModelArray)
    }
    
}
