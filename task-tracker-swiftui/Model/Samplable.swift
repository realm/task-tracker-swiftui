//
//  Samplable.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
}
