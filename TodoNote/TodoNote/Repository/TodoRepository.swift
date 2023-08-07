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

    func add(objects: [Todo]) async throws {
        // n個のレコードを作成するたびに保存処理をおこなう
        let saveCount = 100

        try await MainActor.run {
            var counter = 0

            do {
                for object in objects {
                    let entity = TodoEntity(context: context)
//                    entity.card_id = object.cardId.rawValue
//                    entity.card_id_1 = object.cardId1
//                    entity.card_id_2 = object.cardId2
//                    entity.card_id_3 = object.cardId3
//                    entity.card_id_4 = object.cardId4
//                    entity.pin = object.pin
//                    entity.memo = object.memo
//                    entity.balance = Int32(object.balance)
//                    entity.update_at = Date()

                    counter += 1
                    if counter % saveCount == 0 {
                        try context.save()
                    }
                }

                if context.hasChanges {
                    try context.save()
                }
            } catch {
                context.rollback()
                throw error
            }
        }
    }

    func fetch() async throws -> [Todo] {
        let request = TodoEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "card_id", ascending: true),
        ]

        return try await MainActor.run {
            let result = try context.fetch(request)
            return result.compactMap { $0.toModel() }
        }
    }

    func fetch(ids: [TodoId]) async throws -> [Todo] {
        let request = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "card_id IN %@", ids.map { $0.rawValue })
        request.sortDescriptors = [
            NSSortDescriptor(key: "card_id", ascending: true),
        ]

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
