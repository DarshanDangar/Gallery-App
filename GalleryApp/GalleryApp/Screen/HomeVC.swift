//
//  HomeVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import CoreData

struct HomeVC: View {
    
    @State var isPresentProfile: Bool = false
    @State var isDetailScreen: Bool = false
    @State var imageString = ""
    
    @StateObject private var imageViewModel = ImageViewModel()
    
//    @EnvironmentObject var manager: ImageDataManager
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: ImageData.entity(), sortDescriptors: []) private var fetchedImages: FetchedResults<ImageData>
    private let gridItem = [GridItem(.flexible(), spacing: 18),
                            GridItem(.flexible(), spacing: 18)]
    private var reqModel = GalleryRequest()
    
    var body: some View {
        
        VStack {
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("Images")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                    
                    Spacer()
                    
                    Image(.imgProfile)
                        .onTapGesture {
                            isPresentProfile = true
                        }
                }
                
                ScrollView {
                    LazyVGrid(columns: gridItem, content: {
                        ForEach(imageViewModel.images?.hits ?? []) { data in
                            ImageCell(image: data.largeImageURL)
                                .onTapGesture {
                                    imageString = data.largeImageURL ?? ""
                                    isDetailScreen = imageString != ""
                                }
                                .onAppear {
                                    if data == imageViewModel.images?.hits?.last {
                                        reqModel.page += 1
                                        imageViewModel.getImagesApi(request: reqModel) 
                                    }
                                }
                        }
                    })
                }
                
                Spacer()
                
            }
            .padding()
            
            .onAppear {
                getImages()
            }
            .navigationDestination(isPresented: $isPresentProfile, destination: {
                ProfileVC()
                    .navigationBarBackButtonHidden()
            })
            .sheet(isPresented: $isDetailScreen) {
                ImageVC(url: imageString)
            }
        
    }
    
}

#Preview {
    HomeVC()
}

extension HomeVC {
    
    func getImages() {
        imageViewModel.getImagesApi(request: GalleryRequest())
    }
    
}

extension HomeVC {
    
    func addImages() {
//        _ = imageViewModel.images?.hits?.compactMap({ data in
//            let newImages = ImageData(context: viewContext)
//            newImages.largeImageURL = data.largeImageURL
//            newImages.id = data.id?.description
//            newImages.collections = data.collections
//            newImages.comments = data.comments
//            newImages.downloads = data.downloads
//            newImages.imageHeight = data.imageHeight
//            newImages
//            do {
//                try viewContext.save()
                //            toast = Toast(style: .success, message: "Account added successfully!")
//            } catch {
//                // Handle errors gracefully, display error toast
//                print(error.localizedDescription)
//            }
//        })
        
    }
    
    func fetchImage() {
        
    }
    
}
