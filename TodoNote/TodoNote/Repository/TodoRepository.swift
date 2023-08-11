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

    func updateTodoStatus(for object: Todo, with statuses: [RegistrationStatus]) async throws {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "todo_id == %@ AND status IN %@",
            object.id.rawValue,
            statuses.map { $0.rawValue }
        )

        try await MainActor.run {
            do {
                // 既存のレコードを削除する
                let matchedObjects = try context.fetch(request)
                for object in matchedObjects {
                    context.delete(object)
                }

                // ready のレコードを追加する
                let entity = TodoEntity(context: context)
                entity.todo_id = object.todoId.rawValue
                entity.status = object.status.rawValue
                entity.title = object.title
                entity.desc = object.description
                entity.datetime = object.datetime
                entity.created_at = object.createdAt
                entity.updated_at = object.updatedAt
                entity.finished = object.finished

                try context.save()
            } catch {
                context.rollback()
                throw error
            }
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

//    func fetch(id: TodoId) async throws -> [Todo] {
//        let request = TodoEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "todo_id == %@", id.rawValue)
    ////        request.sortDescriptors = [
    ////            NSSortDescriptor(key: "update_at", ascending: true),
    ////        ]
//
//        return try await MainActor.run {
//            let result = try context.fetch(request)
//            return result.compactMap { $0.toModel() }
//        }
//    }

    func fetch(by id: TodoId) async throws -> Todo? {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "todo_id == %@", id.rawValue
        )

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }.first
        }
    }

    func fetch(by id: TodoId, with statuses: [RegistrationStatus]) async throws -> Todo? {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "todo_id == %@ AND status IN %@",
            id.rawValue,
            statuses.map { $0.rawValue }
        )

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }.first
        }
    }

    func fetch(with statuses: [RegistrationStatus]) async throws -> [Todo] {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "status IN %@",
            statuses.map { $0.rawValue }
        )

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }
        }
    }

    // 新しいTODOを追加する
    func insert(object: Todo) async throws {
        try await MainActor.run {
            let entity = TodoEntity(context: context)
            entity.todo_id = object.todoId.rawValue
            entity.status = object.status.rawValue
            entity.title = object.title
            entity.desc = object.description
            entity.datetime = object.datetime
            entity.created_at = object.createdAt
            entity.updated_at = object.updatedAt
            entity.finished = object.finished

            try context.save()
        }
    }

    func fetchCount() throws -> Int {
        let request = TodoEntity.fetchRequest()
        return try context.count(for: request)
    }

    func delete(by id: TodoId, status: RegistrationStatus) async throws {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "todo_id == %@ AND status == %@",
            id.rawValue, status.rawValue
        )

        try await MainActor.run {
            let results = try context.fetch(request)
            for entity in results {
                context.delete(entity)
            }
            try context.save()
        }
    }

    /// 指定したステータスのレコードをすべて削除する
    func deleteAll(status: RegistrationStatus) async throws {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "status == %@", status.rawValue)

        try await MainActor.run {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        }
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
