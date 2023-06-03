//
//  DetailRecommendationView.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 02/06/23.
//

import SwiftUI

struct DetailRecommendationView: View {
    @StateObject var modalBtnShow = ShowModal()
    @State var hairModel: HairModel
    let size = UIScreen.main.bounds.size
    var body: some View {
        ZStack{
            ARViewController()
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing){
                    Button(action:{
                        modalBtnShow.toggleBtn()
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 25))
                            .foregroundColor(myColor.fourth.rawValue)
                    })
                    .padding(.trailing, 20)
                }
            BottomSheet(hairModel: hairModel)
                .environmentObject(modalBtnShow)
        }
    }
}

struct DetailRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecommendatioView()
    }
}
