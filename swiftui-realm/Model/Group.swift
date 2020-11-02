//
//  Group.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import RealmSwift

/// Represents a collection of items.
final class ItemGroup: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Group.
    @objc dynamic var _id = ObjectId.generate()

    /// The collection of Items in this group.
    let items = RealmSwift.List<Item>()

    /// Declares the _id member as the primary key to the realm.
    override class func primaryKey() -> String? {
        "_id"
    }
}
