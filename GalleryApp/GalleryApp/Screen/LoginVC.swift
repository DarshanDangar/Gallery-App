//
//  LoginVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI

struct LoginVC: View {
    
    @State private var isLogin = false
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        
        VStack {
            
            Image(.imgGallery)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Button(action: {
                authViewModel.signIn() { status in
                    isLogin = status
                }
            }, label: {
                HStack {
                    Image(.imgGoogle)
                        .frame(width: 48, height: 48)
                        .aspectRatio(contentMode: .fill)
                    
                    Text("Sign in with Google")
                        .foregroundStyle(.blue)
                        .fontWeight(.bold)
                }
            })
            .padding(.vertical, 7)
            .padding(.horizontal, 20)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.bgBlue)
                    .frame(maxWidth: .infinity)
                
            }
            .navigationDestination(isPresented: $isLogin) {
                HomeVC()
                    .navigationBarBackButtonHidden()
            }
        }
        
    }
    
}

#Preview {
    LoginVC()
}
