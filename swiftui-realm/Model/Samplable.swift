//
//  Samplable.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 28/10/2020.
//

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
}
