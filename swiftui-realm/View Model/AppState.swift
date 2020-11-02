//
//  AppState.swift
//  swiftui-realm
//
//  Created by Andrew Morgan on 26/10/2020.
//

import RealmSwift
import SwiftUI

/// State object for managing App flow.
class AppState: ObservableObject {
//    @Published var users: RealmSwift.Results<User>?
//    @Published var currentUser: User?
    @Published var shouldIndicateActivity = false

    var loggedIn: Bool {
        app.currentUser != nil && app.currentUser?.state == .loggedIn
    }

//    /// Publisher that monitors log in state.
//    var loginPublisher = PassthroughSubject<User, Error>()
//    /// Publisher that monitors log out state.
//    var logoutPublisher = PassthroughSubject<Void, Error>()
//    /// Cancellables to be retained for any Future.
//    var cancellables = Set<AnyCancellable>()
    /// Whether or not the app is active in the background.

//    /// The list of items in the first group in the realm that will be displayed to the user.
//    @Published var items: RealmSwift.List<Item>?
//    
//    init() {
//        // Create a private subject for the opened realm, so that:
//        // - if we are not using Realm Sync, we can open the realm immediately.
//        // - if we are using Realm Sync, we can open the realm later after login.
//        let realmPublisher = PassthroughSubject<Realm, Error>()
//        // Specify what to do when the realm opens, regardless of whether
//        // we're authenticated and using Realm Sync or not.
//        realmPublisher
//            .sink(receiveCompletion: { result in
//                // Check for failure.
//                if case let .failure(error) = result {
//                    print("Failed to log in and open realm: \(error.localizedDescription)")
//                }
//            }, receiveValue: { realm in
//                // The realm has successfully opened.
//                // If no group has been created for this app, create one.
//                if realm.objects(ItemGroup.self).count == 0 {
//                    try! realm.write {
//                        realm.add(ItemGroup())
//                    }
//                }
//                assert(realm.objects(Group.self).count > 0)
//                self.items = realm.objects(Group.self).first!.items
//            })
//            .store(in: &cancellables)
//        
//        // If the Realm app is nil, we are in the local-only use case
//        // and do not need to log in or configure the realm for Sync.
//        guard let app = app else {
//            // MARK: Local-Only Use Case
//            print("Not using Realm Sync - opening realm")
//            // Directly open the default local-only realm.
//            realmPublisher.send(try! Realm())
//            return
//        }
//        
//        // MARK: Realm Sync Use Case
//        
//        // Monitor login state and open a realm on login.
//        loginPublisher
//            .receive(on: DispatchQueue.main) // Ensure we update UI elements on the main thread.
//            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
//                // Logged in, now open the realm.
//                
//                // We want to chain the login to the opening of the realm.
//                // flatMap() takes a result and returns a different Publisher.
//                // In this case, flatMap() takes the user result from the login
//                // and returns the realm asyncOpen's result publisher for further
//                // processing.
//                
//                // We use "SharedPartition" as the partition value so that all users of this app
//                // can see the same data. If we used the user.id, we could store data per user.
//                // However, with anonymous authentication, that user.id changes upon logout and login,
//                // so we will not see the same data or be able to sync across devices.
//                let configuration = user.configuration(partitionValue: "SharedPartition")
//                
//                // Loading may take a moment, so indicate activity.
//                self.shouldIndicateActivity = true
//                
//                // Open the realm and return its publisher to continue the chain.
//                return Realm.asyncOpen(configuration: configuration)
//            }
//            .receive(on: DispatchQueue.main) // Ensure we update UI elements on the main thread.
//            .map { // For each realm result, whether successful or not, always stop indicating activity.
//                self.shouldIndicateActivity = false // Stop indicating activity.
//                return $0 // Forward the result as-is to the next stage.
//            }
//            .subscribe(realmPublisher) // Forward the opened realm to the handler we set up earlier.
//            .store(in: &self.cancellables)
//        
//        // Monitor logout state and unset the items list on logout.
//        logoutPublisher.receive(on: DispatchQueue.main).sink(receiveCompletion: { _ in }, receiveValue: { _ in
//            self.items = nil
//        }).store(in: &cancellables)
//        
//        // If we already have a current user from a previous app
//        // session, announce it to the world.
//        if let user = app.currentUser {
//            loginPublisher.send(user)
//        }
//    }
}
