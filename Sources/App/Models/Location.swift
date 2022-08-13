//
//  File.swift
//  
//
//  Created by Oliver Wächter on 12.08.22.
//

import Fluent
import Vapor
import Foundation

final class Location: Model, Content{
    
    static let schema = "location"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String?
    
    init(){}
    
    init(id: UUID? = nil, name: String ){
        self.id = id
        self.name = name
        self.description = description
    }
    
}
    
    
