//
//  Create Location.swift
//  
//
//  Created by Oliver Wächter on 12.08.22.
//
import Fluent
import Vapor

struct CreateLocation: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("location")
            .id()
            .field("name", .string, .required)
            .field("description", .string)
            .create()
            
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("location").delete()
    }
}
