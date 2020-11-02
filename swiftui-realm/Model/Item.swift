//
//  Item.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import RealmSwift

/// Random adjectives for more interesting demo item names
let randomAdjectives = [
    "fluffy", "classy", "bumpy", "bizarre", "wiggly", "quick", "sudden",
    "acoustic", "smiling", "dispensable", "foreign", "shaky", "purple", "keen",
    "aberrant", "disastrous", "vague", "squealing", "ad hoc", "sweet"
]

/// Random noun for more interesting demo item names
let randomNouns = [
    "floor", "monitor", "hair tie", "puddle", "hair brush", "bread",
    "cinder block", "glass", "ring", "twister", "coasters", "fridge",
    "toe ring", "bracelet", "cabinet", "nail file", "plate", "lace",
    "cork", "mouse pad"
]

/// An individual item. Part of a `Group`.
final class Item: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Item.
    @objc dynamic var _id = ObjectId.generate()

    /// The name of the Item, By default, a random name is generated.
    @objc dynamic var name = "\(randomAdjectives.randomElement()!) \(randomNouns.randomElement()!)"

    /// A flag indicating whether the user "favorited" the item.
    @objc dynamic var isFavorite = false

    /// The backlink to the `ItemGroup` this item is a part of.
    let group = LinkingObjects(fromType: ItemGroup.self, property: "items")

    /// Declares the _id member as the primary key to the realm.
    override class func primaryKey() -> String? {
        "_id"
    }
}
