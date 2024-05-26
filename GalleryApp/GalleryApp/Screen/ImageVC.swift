//
//  ImageVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import Kingfisher

struct ImageVC: View {
    
    // MARK: - Variables
    var url: String?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(.imgClose)
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color.gray)
                .clipShape(Circle())
                .padding()
            }
            
            Spacer()
            
            KFImage(URL(string: url ?? ""))
                .placeholder {
                    Image(.imgPlaceHolder).resizable() }
                .resizable()
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 3))
                        .fill(.bgBlue)
                }
            
            Spacer()
        }
    }
}

#Preview {
    ImageVC()
}
