import Fluent
import Vapor


func routes(_ app: Application) throws {
    
try app.register(collection: ObjectController())
try app.register(collection: LocationController())
}
