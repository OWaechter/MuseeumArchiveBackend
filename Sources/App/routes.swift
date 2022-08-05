import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.post("object") { req -> EventLoopFuture<Object> in
     
        let object = try req.content.decode(Object.self)
        return object.create(on: req.db).map {object}
        

                        
        }
    app.get("object"){ req in
        
        return "yes"
    }

}
