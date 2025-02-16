//
//  GoogleSignInHelper.swift
//  Habito
//
//  Created by Kenneth Yang on 2/14/25.
//

import Foundation
import GoogleSignIn
import SwiftUI

class GoogleSignInHelper: NSObject, ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var profileImageURL: URL?
    
    private var clientID: String = "623247603793-9nrg4tnrt3vqs0g6t1e51f39juho4amr.apps.googleusercontent.com" // Replace with your client ID
    
    override init() {
        super.init()
        setupGoogleSignIn()
    }
    
    private func setupGoogleSignIn() {
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    // Define a completion handler to return the Google user data
    func signIn(completion: @escaping (GIDGoogleUser?, Error?) -> Void) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            errorMessage = "Unable to find root view controller."
            completion(nil, NSError(domain: "GoogleSignInHelper", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to find root view controller."]))
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                self.errorMessage = "Google Sign-In failed: \(error.localizedDescription)"
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else {
                self.errorMessage = "User data is nil."
                completion(nil, NSError(domain: "GoogleSignInHelper", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is nil."]))
                return
            }
            
            // Handle successful sign-in
            self.isLoggedIn = true
            self.profileImageURL = user.profile?.imageURL(withDimension: 100) // Fetch profile picture URL
            
            // Return the user data via the completion handler
            completion(user, nil)
            
            print("Google Sign-In successful!")
            print("User ID: \(user.userID ?? "N/A")")
            print("Email: \(user.profile?.email ?? "N/A")")
            print("Name: \(user.profile?.name ?? "N/A")")
            print("Profile Picture URL: \(user.profile?.imageURL(withDimension: 100)?.absoluteString ?? "N/A")")
        }
    }
}
