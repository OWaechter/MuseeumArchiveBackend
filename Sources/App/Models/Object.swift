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
    
    @Field(key: "text")
    var text: String?
    
    @Field(key: "description")
    var description: String?
    
    @Field(key: "created at")
    var createdAt: Date?
    
    @Field(key: "created from")
    var createdFrom: String?
    
    @Field(key: "modified from")
    var modifiedFrom: String?
    
    @Field(key: "modified at")
    var modifiedAt: Date?
    
    @Field(key: "location")
    var location: String?
    
    @Field(key: "barcode")
    var barcode: String?
    
    @Field(key: "searchTerm")
    var searchTerm: String?
    
    init() {}
    init(id: UUID? = nil, name: String){
        self.id = id
        self.name = name
        self.description = description
        self.text = text
        self.createdAt = createdAt
        self.createdFrom = createdFrom
        self.modifiedAt = modifiedAt
        self.modifiedFrom = modifiedFrom
        self.location = location
        self.barcode = id?.uuidString
        self.searchTerm = searchTerm?.lowercased()
    }
    
   
    
}
