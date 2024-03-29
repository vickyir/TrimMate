//
//  ListRecommendatioView.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 01/06/23.
//

import SwiftUI

struct ListRecommendatioView: View {
    @EnvironmentObject var router: Router
    
    @StateObject var modalBtnShow = ShowModal()
    @State private var DataHairModel: [HairModel] = HairModels
    @AppStorage("faceshape") var myFaceShape: String = ""
    @State var isFavoriteEmpty = 0
    @State private var shownSheet = false
    @State private var sheetHairModel: Int = 0
    @State var shownARMatching = false
    let columns = [
        GridItem(.flexible(),spacing:10),
        GridItem(.flexible(),spacing:10),
    ]
    
    var body: some View {
        return Group{
//            if myFaceShape == "" {
//                ARMatchingView()
//                // push nabi
//            }else{
//                NavigationView{
                    ZStack{
                        VStack(alignment: .leading, spacing: 0.0){
                            ZStack(alignment: .leading){
                                Image("home-bg")
                                VStack(alignment: .leading){
                                    Text("List of Recommendation")
                                        .font(.system(size: 21, weight: .bold))
                                        .foregroundColor(myColor.fourth.valueRaw)
                                    Text("\(myFaceShape.capitalized) Face Shape")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(myColor.fourth.valueRaw)
                                        .opacity(0.6)
                                        .tracking(1.2)
                                    HStack{
                                        Image(systemName: "paperclip")
                                            .frame(width: 19, height: 19)
                                            .foregroundColor(myColor.fourth.valueRaw)
                                        Text("Favorites")
                                            .font(.system(size: 21, weight: .bold))
                                            .foregroundColor(myColor.fourth.valueRaw)
                                            .tracking(0.81)
                                    }
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(maxWidth: .infinity, maxHeight: 194)
                                            .foregroundColor(myColor.secondary.valueRaw)
                                        if isFavoriteEmpty == 0{
                                            VStack{
                                                Text("Empty !")
                                                    .font(.system(size: 32, weight: .bold))
                                                    .foregroundColor(myColor.fourth.valueRaw)
                                            }
                                            
                                        }
                                        ScrollView(.horizontal, showsIndicators: false){
                                            HStack{
                                                ForEach(Array(DataHairModel.enumerated().reversed()), id: \.element.id) { index, model in
                                                    if model.isFavorite && model.faceType == myFaceShape{
                                                        
                                                        ZStack {
                                                            RoundedRectangle(cornerRadius: 15)
                                                                .frame(width: 150, height: 150)
                                                                .foregroundColor(myColor.primary.valueRaw)
                                                            
                                                            VStack(spacing: 0.0) {
                                                                
                                                            
                                                                Button(action: {
                                                                    
                                                                    modalBtnShow.dataHairModel = DataHairModel[index]
                                                                    modalBtnShow.toggleBtn()
                                                                    
                                                                }, label: {
                                                                    PreviewView(scene: $DataHairModel[index].icon)
                                                                        .frame(width: 125, height: 125)
                                                                    
                                                                })
                                                               
                                                                
                                                                Text("\(model.name)")
                                                                    .font(.system(size: 11, weight: .regular))
                                                                    .foregroundColor(myColor.fourth.valueRaw)
                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                        .onAppear{
                                                            isFavoriteEmpty = DataHairModel.filter { $0.isFavorite }.count
                                                        }
                                                        .onChange(of: DataHairModel) { newValue in
                                                          
                                                            isFavoriteEmpty = DataHairModel.filter { $0.isFavorite }.count
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        .padding(.leading, 10)
                                    }
                                    
                                }
                                .padding(.horizontal, 31)
                                
                            }
                            
                            Text("All")
                                .font(.system(size: 21, weight: .bold))
                                .foregroundColor(myColor.fourth.valueRaw)
                                .tracking(0.81)
                                .padding(.horizontal, 31)
                            ScrollView(.vertical, showsIndicators: false){
                                LazyVGrid(columns: columns, spacing: 12){
                                    ForEach(Array(DataHairModel.enumerated()), id: \.element.id) {  index, model in
                                        
                                        if model.faceType == myFaceShape{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .frame(width: 160, height: 155)
                                                    .foregroundColor(myColor.secondary.valueRaw)
                                                
                                                VStack(spacing: 0.0) {
                                                  
                                                    
                                                    Button(action: {
                                                        
                                                        modalBtnShow.dataHairModel = DataHairModel[index]
                                                        modalBtnShow.toggleBtn()
                                                        
                                                    }, label: {
                                                        PreviewView(scene: $DataHairModel[index].icon)
                                                            .frame(width: 125, height: 125)
                                                        
                                                    })
                                                   
                                                    
                                                    Text("\(model.name)")
                                                        .font(.system(size: 11, weight: .regular))
                                                        .foregroundColor(myColor.fourth.valueRaw)
                                                }
                                                
                                            }
                                            
                                            .overlay(alignment: .topTrailing){
                                                Button(action: {
                                                    if model.isFavorite{
                                                        self.isFavoriteEmpty -= 1
                                                    }else{
                                                        
                                                        self.isFavoriteEmpty += 1
                                                        
                                                    }
                                                    self.DataHairModel[index].isFavorite.toggle()
                                                    
                                                    
                                                }, label: {
                                                    Image(systemName: model.isFavorite ? "heart.fill" : "heart")
                                                        .foregroundColor(model.isFavorite ? myColor.third.valueRaw : myColor.fourth.valueRaw)
                                                        .padding(.top, 10)
                                                        .padding(.trailing, 10)
                                                })
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(myColor.primary.valueRaw)
                        .overlay(alignment: .bottom){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(maxWidth: .infinity, maxHeight: 73)
                                    .foregroundColor(myColor.fourth.valueRaw)
                                    .opacity(0.8)
                                
                                HStack(spacing: 25){
                                    
                                    NavigationLink(value: Destination.arPage) {
                                        
                                        
                                        ZStack{
                                            Circle()
                                                .frame(width: 54, height: 54)
                                                .foregroundColor(myColor.fourth.valueRaw)
                                            Circle()
                                                .frame(width: 46, height: 46)
                                                .foregroundColor(myColor.primary.valueRaw)
                                            
                                            Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                                .foregroundColor(myColor.fourth.valueRaw)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    NavigationLink{
                                        DetailRecommendationView(hairModel: DataHairModel)
                                        //                                TextArTestView()
                                    }label:{
                                        ZStack{
                                            Circle()
                                                .frame(width: 54, height: 54)
                                                .foregroundColor(myColor.fourth.valueRaw)
                                            Circle()
                                                .frame(width: 46, height: 46)
                                                .foregroundColor(myColor.primary.valueRaw)
                                            Image(systemName: "person.and.background.dotted")
                                                .foregroundColor(myColor.fourth.valueRaw)
                                            
                                        }
                                    }
                                    
                                }
                                .padding(.bottom, 15)
                                
                                
                            }
                
                            
                            
                        }
                        .edgesIgnoringSafeArea(.bottom)
                        
                        
                        BottomSheet(hairModel: DataHairModel[sheetHairModel])
                            .environmentObject(modalBtnShow)
                        
                    }
                    .onAppear {
                        // check
                        if myFaceShape == "" {
                            router.path.append(Destination.arPage)
                        }
                    }
//                }
//            }
        }


        
   
        
        
    }
}


struct ListRecommendatioView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecommendatioView()
    }
}


