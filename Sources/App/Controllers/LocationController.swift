//
//  File.swift
//  
//
//  Created by Oliver Wächter on 13.08.22.
//

import Vapor
import Fluent

struct LocationController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let locations = routes.grouped("locations")
        locations.group("locations"){ location in
            locations.get(use: locationList)
            locations.post(use: createLocation)
            locations.delete(":locationId", use: deleteLocation)
            locations.put(use: updateLocation)
            locations.get(":locationid", use: findLocation)
            
            
        }
    }
        
    private func locationList(req: Request) throws -> EventLoopFuture<[Location]>{
        return Location.query(on: req.db).all()
        
    }
    private func createLocation(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let location = try req.content.decode(Location.self)
        return location.create(on: req.db).transform(to: .ok)
        
    }
    
    private func deleteLocation(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        return Location.find(req.parameters.get("locationId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{$0.delete(on: req.db)}
            .transform(to: .ok)
    }
    
    private func updateLocation(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let location = try req.content.decode(Location.self)
        return Location.find(location.id, on :req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.name = location.name
                $0.description = location.description
                return $0.update(on: req.db).transform(to: .ok)
            }
        
    }
    
    private func findLocation(req: Request) throws -> EventLoopFuture<Location>{
        
        return Location.find(req.parameters.get("locationId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
}
