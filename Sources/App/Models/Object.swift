//
//  File.swift
//  
//
//  Created by Oliver Wächter on 05.08.22.
//

import Fluent
import Vapor

final class Object: Model, Content{
    
    static let schema = "object"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    init() {}
    init(id: UUID? = nil, name: String){
        self.id = id
        self.name = name
    }
}
