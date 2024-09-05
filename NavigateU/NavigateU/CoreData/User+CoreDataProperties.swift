//
//  User+CoreDataProperties.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 25.07.2024.
//
//

import Foundation
import CoreData
import FirebaseAuth

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var cityOfResidence: String?
    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var nationality: String?
    @NSManaged public var password: String?
    @NSManaged public var uid: String?
    @NSManaged public var profileImageUrl: String?
    @NSManaged public var likedArticles: NSSet?

}

// MARK: Generated accessors for likedArticles
extension User {

    @objc(addLikedArticlesObject:)
    @NSManaged public func addToLikedArticles(_ value: Article)

    @objc(removeLikedArticlesObject:)
    @NSManaged public func removeFromLikedArticles(_ value: Article)

    @objc(addLikedArticles:)
    @NSManaged public func addToLikedArticles(_ values: NSSet)

    @objc(removeLikedArticles:)
    @NSManaged public func removeFromLikedArticles(_ values: NSSet)

}

extension User: Identifiable {

}
