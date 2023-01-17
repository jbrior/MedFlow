//
//  People.swift
//  MedFlow
//
//  Created by Colony Of Mercy on 1/3/23.
//

import Foundation

class People {
    var id: String?
    var name: String?
    var meds: [String]?
    var history: [String]?
    
    init( id: String? = nil, name: String? = nil, meds: [String]? = nil, history: [String]? = nil) {
        self.id = id
        self.name = name
        self.meds = meds
        self.history = history
    }
}
