//
//  TodoRepository.swift
//  TodoNote
//
//  Created by KENJIWADA on 2023/08/07.
//

import CoreData

class TodoRepository {
    static let shared = TodoRepository()

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.managedObjectContext) {
        self.context = context
    }

//    func add(objects: [Todo]) async throws {
//        // n個のレコードを作成するたびに保存処理をおこなう
//        let saveCount = 100
//
//        try await MainActor.run {
//            var counter = 0
//
//            do {
//                for object in objects {
//                    let entity = TodoEntity(context: context)
//                    entity.todo_id = object.todoId.rawValue
//                    entity.status = object.status.rawValue
//                    entity.title = object.title
//                    entity.body = object.body
//                    entity.datetime = object.datetime
//                    entity.created_at = object.createdAt
//                    entity.updated_at = object.updatedAt
//                    entity.finished = object.finished
//
//                    counter += 1
//                    if counter % saveCount == 0 {
//                        try context.save()
//                    }
//                }
//
//                if context.hasChanges {
//                    try context.save()
//                }
//            } catch {
//                context.rollback()
//                throw error
//            }
//        }
//    }

    func addOrUpdate(object: Todo) async throws {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "todo_id == %@", object.todoId.rawValue)

        try await MainActor.run {
            let entities = try context.fetch(request)
            if let entity = entities.first {
                entity.status = object.status.rawValue
                entity.title = object.title
                entity.desc = object.description
                entity.datetime = object.datetime
                entity.updated_at = object.updatedAt
                entity.finished = object.finished
            } else {
                let entity = TodoEntity(context: context)
                entity.todo_id = object.todoId.rawValue
                entity.status = object.status.rawValue
                entity.title = object.title
                entity.desc = object.description
                entity.datetime = object.datetime
                entity.created_at = object.createdAt
                entity.updated_at = object.updatedAt
                entity.finished = object.finished
            }

            try context.save()
        }
    }

    func fetch() async throws -> [Todo] {
        let request = TodoEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "todo_id", ascending: true),
        ]

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }
        }
    }

//    func fetch(ids: [TodoId]) async throws -> [Todo] {
//        let request = TodoEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "todo_id IN %@", ids.map { $0.rawValue })
//        request.sortDescriptors = [
//            NSSortDescriptor(key: "todo_id", ascending: true),
//        ]
//
//        return try await MainActor.run {
//            let result = try context.fetch(request)
//            return result.compactMap { $0.toModel() }
//        }
//    }

    func fetch(id: TodoId) async throws -> [Todo] {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "todo_id == %@", id.rawValue)
//        request.sortDescriptors = [
//            NSSortDescriptor(key: "update_at", ascending: true),
//        ]

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }
        }
    }

    func fetchCount() throws -> Int {
        let request = TodoEntity.fetchRequest()
        return try context.count(for: request)
    }

    /// すべてのレコードを削除する
    func deleteAll() async throws {
        let request = TodoEntity.fetchRequest()
        try await MainActor.run {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        }
    }
}
