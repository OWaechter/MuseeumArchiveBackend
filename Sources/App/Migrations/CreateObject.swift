//
//  File.swift
//  
//
//  Created by Oliver Wächter on 05.08.22.
//

import Fluent
import Vapor

struct CreateObject: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("object")
            .id()
            .field("name", .string, .required)
            .field("description", .string)
            .field("text", .string)
            .field("created at", .date)
            .field("modified at", .date)
            .field("created from", .string)
            .field("modified from", .string)
            .field("location", . string)
            .field("barcode", .data)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("objbect").delete()
    }
}
