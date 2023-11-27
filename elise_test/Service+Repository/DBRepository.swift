//
//  DBRepository.swift
//  elise_test
//
//  Created by Tabber on 2023/11/28.
//

import Foundation
import Combine
import CoreData

protocol DBRepositoryProtocol {
    func saveLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error>
    func loadLectureIDs() -> AnyPublisher<[LectureCDModel], Error>
    func deleteLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error>
    
}

struct DBRepository: DBRepositoryProtocol {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Models")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError("Cannot Load Core Data Model")
            }
        }
    }
    
    func deleteLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error> { promise in
            do {
                guard let entity = try getEntityById(lectureID) else {
                    promise(.success(()))
                    return
                }
                
                let context = container.viewContext
                context.delete(entity)
                
                do{
                    try context.save()
                    promise(.success(()))
                }catch{
                    context.rollback()
                    promise(.failure(error))
                }
                
            } catch {
                promise(.failure(error))
            }
        }
            .eraseToAnyPublisher()
        
        return future.eraseToAnyPublisher()
    }
    
    func loadLectureIDs() -> AnyPublisher<[LectureCDModel], Error> {
        
        let future = Future<[LectureCDModel], Error> { promise in
            let request = LectureCDModelEntity.fetchRequest()
            
            do {
                let data = try container.viewContext.fetch(request).map({ entity in
                    LectureCDModel(id: Int(entity.id))
                })
                
                promise(.success(data))
                
            } catch {
                promise(.failure(error))
            }
            
        }
            .eraseToAnyPublisher()
        
        return future
        
    }
    
    func saveLectureID(_ lectureID: Int) -> AnyPublisher<Void, Error> {
        
        let future = Future<Void, Error> { promise in
            let lectureIDEntity = LectureCDModelEntity(context: container.viewContext)
            lectureIDEntity.id = Int64(lectureID)
            let result = saveContext()
            
            if result.0 {
                promise(.success(()))
            } else {
                if let error = result.1 {
                    promise(.failure(error))
                }
            }
            
        }
            .eraseToAnyPublisher()
        
        return future
        
    }
    
    private func getEntityById(_ id: Int)  throws  -> LectureCDModelEntity? {
        let request = LectureCDModelEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "id == %lld", Int64(id))
        let context =  container.viewContext
        let todoCoreDataEntity = try context.fetch(request)[0]
        return todoCoreDataEntity
        
    }
    
    private func saveContext() -> (Bool, Error?) {
        let context = container.viewContext
        if context.hasChanges {
            do{
                try context.save()
                return (true, nil)
            }catch{
                return (false, error)
            }
        } else {
            return (false, nil)
        }
    }
}
