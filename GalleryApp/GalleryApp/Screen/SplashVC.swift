//
//  SplashVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import GoogleSignIn

struct SplashVC: View {
    
    @State var isPresentLogin: Bool = false
    @State var isPresentHome: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            Image(.imgGallery)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            if let error = error {
                                print("error: \(error.localizedDescription)")
                            }
                            isPresentLogin = user == nil
                            isPresentHome = user != nil
                        }
                    }
                }
                .navigationDestination(isPresented: $isPresentHome) {
                    HomeVC()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $isPresentLogin) {
                    LoginVC()
                        .navigationBarBackButtonHidden()
                }
        }
        
    }
    
}

#Preview {
    SplashVC()
}
