//
//  Article+CoreDataProperties.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 18.07.2024.
//
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: Int32
    @NSManaged public var imageURL: String?
    @NSManaged public var likes: String?
    @NSManaged public var title: String?
    @NSManaged public var likedByUser: NSSet?

}

// MARK: Generated accessors for likedByUser
extension Article {

    @objc(addLikedByUserObject:)
    @NSManaged public func addToLikedByUser(_ value: User)

    @objc(removeLikedByUserObject:)
    @NSManaged public func removeFromLikedByUser(_ value: User)

    @objc(addLikedByUser:)
    @NSManaged public func addToLikedByUser(_ values: NSSet)

    @objc(removeLikedByUser:)
    @NSManaged public func removeFromLikedByUser(_ values: NSSet)

}

extension Article: Identifiable {
}
