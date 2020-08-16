//
//  DataModel.swift
//  project_x
//
//  Created by AHMET DÜNDAR on 2.06.2020.
//  Copyright © 2020 AHMET DÜNDAR. All rights reserved.
//

import SwiftUI

struct DataModel: Equatable {
    
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        if lhs.data_type == "Bool" && rhs.data_type == "Bool" {
            return lhs.value as! Bool == rhs.value as! Bool
        } else if lhs.data_type == "String" && rhs.data_type == "String" {
            return lhs.value as! String == rhs.value as! String
        } else if lhs.data_type == "Int" && rhs.data_type == "Int" {
            return lhs.value as! Int == rhs.value as! Int
        } else if lhs.data_type == "Real" && rhs.data_type == "Real" {
            return (lhs.value as! NSNumber).floatValue == (rhs.value as! NSNumber).floatValue
        } else {
            return false
        }
    }
    
    var data_type: String
    var name: String
    var offset: Double
    var value: Any
    var isChange: Bool = false
    
    enum MyError: Error {
        case runTimeError(String)
    }
}

