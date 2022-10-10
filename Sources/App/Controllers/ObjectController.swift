//
//  ObjectController.swift
//  
//
//  Created by Oliver Wächter on 11.08.22.
//

import Vapor
import Fluent

struct ObjectController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let objects = routes.grouped("objects")
        objects.group("objects"){ Object in
        objects.get(use: index)
        objects.post(use:createObject)
        objects.put(use:updateObject)
        objects.get(":objectId", use:findObject)
        objects.delete(":objectId", use:deleteObject)
        objects.get("search",":searchName",use:findObjectWithName)
        objects.get("searchLocation",":searchLocation", use: findObjectByLocation)
    }
}


    func index(req: Request) throws -> EventLoopFuture<[Object]> {
        return Object.query(on: req.db).all()
    }


    func createObject(req:Request) throws -> EventLoopFuture<HTTPStatus>{
        let object = try req.content.decode(Object.self)
        return object.create(on: req.db).transform(to: .ok)
    }

    func findObject(req:Request) throws -> EventLoopFuture<Object>{
        return Object.find(req.parameters.get("objectId"),on:req.db)
        .unwrap(or: Abort(.notFound))
        }


func updateObject(req:Request) throws -> EventLoopFuture<HTTPStatus>{
    let object = try req.content.decode(Object.self)
    return Object.find(object.id, on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap{
            $0.name = object.name
            $0.location = object.location
            $0.searchTerm = object.searchTerm?.lowercased()
            $0.description = object.description
            $0.modifiedAt = getDate()
            $0.modifiedFrom = object.modifiedFrom
            $0.text = object.text
            return $0.update(on: req.db).transform(to: .ok)
        }
}
func deleteObject(req:Request) throws -> EventLoopFuture<HTTPStatus>{
        return Object.find(req.parameters.get("objectId"),on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{$0.delete(on: req.db)}
            .transform(to: .ok)
    }

func findObjectWithName(req:Request) throws -> EventLoopFuture<[Object]> {
    return Object.query(on: req.db)
        .filter(\.$searchTerm ~~ req.parameters.get("searchName")!)
        .sort(\.$name)
        .all()
    }

func findObjectByLocation(req:Request) throws -> EventLoopFuture<[Object]> {
    
    return Object.query(on: req.db)
        .filter(\.$location ~~ req.parameters.get("searchLocation")!)
        .sort(\.$name)
        .all()
    }
    
    private func getDate() -> Date{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return date
    }

}
