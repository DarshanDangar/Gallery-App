//
//  ProfileVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import Kingfisher

struct ProfileVC: View {
    
    // MARK: - Variables
    @Environment(\.dismiss) var dismiss
    @State var isPresentLogin: Bool = false
    @StateObject private var vm = AuthViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image(.imgBack)
                .onTapGesture {
                    dismiss()
                }
            
            HStack {
                
                Spacer()
                
                KFImage(SessionManager.shared.appUser?.profilePicUrl ?? URL(string: "https://i.pinimg.com/564x/28/5b/dc/285bdcec39458d45760d393ca9a59380.jpg"))
                    .resizable()
                    .cornerRadius(24)
                    .frame(width: 150, height: 150)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(lineWidth: 8)
                            .foregroundColor(.bgBlue)
                    }
                
                Spacer()
                
            }
            .padding(.bottom)
            
            Text(SessionManager.shared.appUser?.name ?? "name")
                .font(.title)
            
            Text(SessionManager.shared.appUser?.email ?? "Email")
                .font(.headline)
                .padding(.top, 6)
            
            HStack {
                Spacer()
                
                Button(action: {
                    vm.signOut()
                    isPresentLogin = true
                }, label: {
                    Text("Logout")
                })
                .frame(alignment: .center)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.bgBlue)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 8)
                
                Spacer()
            }
            
            Spacer()
    
        }
        .padding(24)
        
        .navigationDestination(isPresented: $isPresentLogin) {
            LoginVC()
                .navigationBarBackButtonHidden()
        }
        
    }
    
}

#Preview {
    ProfileVC()
}
