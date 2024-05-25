//
//  ImageCell.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import Kingfisher

struct ImageCell: View {
    
    var image: String? = ""
    
    var body: some View {
        
        KFImage(URL(string: image ?? ""))
            .placeholder {
                Image(.imgPlaceHolder).resizable() }
            .resizable()
            .cancelOnDisappear(true)
            .frame(height: 200)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
    
}

#Preview {
    ImageCell()
}
