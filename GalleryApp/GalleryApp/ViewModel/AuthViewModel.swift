//
//  AuthViewModel.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import GoogleSignIn

class AuthViewModel: ObservableObject {
    
    @Published var user: AuthModel?
    
    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user,error in
            print("user", user)
            print("error", error)
            if let user {
                print("User found", user)
            }
        }
    }
    
    func signIn(completion: @escaping (_ status: Bool) -> Void) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.getTopViewController() ?? UIViewController()) { userData, error in
            if let error {
                completion(false)
            } else {
                var user = User()
                user.userId = userData?.user.userID
                user.email = userData?.user.profile?.email
                user.name = userData?.user.profile?.name
                user.givenName = userData?.user.profile?.givenName
                user.profilePicUrl = userData?.user.profile?.imageURL(withDimension: 320)
                SessionManager.shared.appUser = user
                completion(true)
            }
        }
        
    }
    
    func signOut() {
        
        GIDSignIn.sharedInstance.signOut()
        
    }
    
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}
