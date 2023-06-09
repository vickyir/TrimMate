//
//  CustomSheetView.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 01/06/23.
//

import SwiftUI

struct CustomSheetView: View {
    @EnvironmentObject var modalShow: ShowModal
    @State var hairModelData: HairModel
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 35)
                .background(Color.clear)
                .frame(width: 331, height: 598)
                .foregroundColor(myColor.secondary.rawValue)
            
            VStack(spacing: 30){
                
                HStack{
                    Text("\(hairModelData.name)")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(myColor.fourth.rawValue)
                    Spacer()
                    Button(action: {
                     modalShow.toggleBtn()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 21, weight: .bold))
                            .foregroundColor(myColor.fourth.rawValue)
                    })
                  
                }
                .padding(.horizontal, 20)
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 210, height: 230)
                        .foregroundColor(myColor.primary.rawValue)
                    PreviewView(scene: $hairModelData.icon)
                        .frame(width: 210, height: 210)
                }
                ScrollView(.vertical, showsIndicators: false){
                    Text("\(hairModelData.description)")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(myColor.fourth.rawValue)
                        .padding(.horizontal)
                }
                .frame(height: 150)
//                Button(action: {
//                    if hairModelData.isFavorite {
//                        hairModelData.isFavorite = false
//                    }else{
//                        hairModelData.isFavorite = true
//                    }
//                }, label: {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 16)
//                            .frame(width: 281, height: 51)
//                            .foregroundColor(myColor.fourth.rawValue)
//                        HStack{
//                            Text(hairModelData.isFavorite ? "Remove from Favorite" : "Add to Favorite")
//                                .font(.system(size: 16, weight: .medium))
//                                .foregroundColor(myColor.primary.rawValue)
//                            Spacer()
//                            Image(systemName: hairModelData.isFavorite ? "heart.fill" : "heart")
//                                .font(.system(size: 26, weight: .medium))
//                                .foregroundColor(hairModelData.isFavorite ? myColor.third.rawValue : myColor.primary.rawValue)
//                        }
//                        .padding(.horizontal, 20)
//                    }
//                    .frame(width: 281, height: 51)
//
//                })
                
                
            }
           
            
        }
        .frame(width: 331)
        .background(Color.clear)
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecommendatioView()
    }
}

struct BottomSheet: View {

    @EnvironmentObject var isShowing: ShowModal
    @State var hairModel: HairModel
    
    var body: some View {
        
        GeometryReader{
            geo in
            
            if isShowing.isActive{
               CustomSheetView(hairModelData: hairModel)
                    .environmentObject(isShowing)
                .position(x: geo.size.width/2, y: geo.size.height/2)
                .animation(.easeInOut, value: isShowing.isActive)
              
                   
            }
            
        }
        .animation(.easeInOut, value: isShowing.isActive)
    }
}
