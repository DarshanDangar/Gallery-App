//
//  HomeVC.swift
//  GalleryApp
//
//  Created by Darshan Dangar on 25/05/24.
//

import SwiftUI
import CoreData

struct HomeVC: View {
    
    // MARK: - Variables
    @State var isPresentProfile: Bool = false
    @State var isDetailScreen: Bool = false
    @State var imageString = ""
    
    @StateObject private var imageViewModel = ImageViewModel()
    
    @EnvironmentObject var manager: ImageDataManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: ImageData.entity(), sortDescriptors: []) private var fetchedImages: FetchedResults<ImageData>
    private let gridItem = [GridItem(.flexible(), spacing: 18),
                            GridItem(.flexible(), spacing: 18)]
    private var reqModel = GalleryRequest()
    
    @State var offlineImages: [Hit] = []
    
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
                        ForEach(imageViewModel.images?.hits ?? offlineImages) { data in
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
                addImages()
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

// MARK: - get Images
extension HomeVC {
    
    func getImages() {
        // network is not connected then use offline images
        if !Reachability.isConnectedToNetwork(), !SessionManager.shared.images.isEmpty {
            offlineImages = SessionManager.shared.images
        } else {
            imageViewModel.getImagesApi(request: GalleryRequest())
        }
    }
    
}

// MARK: - add Images in Coredata
extension HomeVC {
    
    func addImages() {
        _ = imageViewModel.images?.hits?.compactMap({ data in
            let newImages = ImageData(context: viewContext)
            newImages.largeImageURL = data.largeImageURL
            do {
                try viewContext.save()
            } catch {
                // Handle errors gracefully, display error toast
                print(error.localizedDescription)
            }
        })
        
    }
    
    func fetchImage() {
        
    }
    
}
