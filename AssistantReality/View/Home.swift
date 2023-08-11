//
//  Home.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 29/05/23.
//

import SwiftUI


class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}

enum Destination: Hashable {
    case arPage
}

class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: Destination) -> some View {
        switch destination {
        case .arPage:
            ARMatchingView()
        }
    }
}

struct Home: View {
    @State private var activeIntro: PageIntro =  pageIntros[0]
    @AppStorage("faceshape") var myFaceShape: String = ""
    @State var isOnboardingComplete: Bool = false
    
    var body: some View {
        
        Group {
            
            if myFaceShape != "" {
                //withAnimation{
                ListRecommendatioView()
                //}
                
            }else{
                
                if isOnboardingComplete{
                    ListRecommendatioView()
                }else{
                    GeometryReader{
                        
                        let size = $0.size
                        
                        IntroView(intro: $activeIntro, size: size){
                            Button(action: {
                                isOnboardingComplete.toggle()
                            }, label: {
                                VStack(spacing: 0.0){
                                    Text("START")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 14))
                                        .foregroundColor(myColor.primary.valueRaw)
                                        .frame(width: size.width*0.9)
                                        .padding(.vertical, 10)
                                        .background{
                                            Capsule()
                                                .fill(myColor.fourth.valueRaw)
                                        }
                                        .padding(.top)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            })
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(myColor.primary.valueRaw)
                    
                }
            }
            
            
            /*
             
             if myFaceShape != "" {
             ListRecommendatioView()
             }else{
             
             
             }
             */
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct IntroView<ActionView: View>: View{
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping() -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
    @State private var pageNumber =  1
    @State private var showView: Bool = false
    @State private var hiddenWholeView: Bool = false
    var body: some View{
        NavigationStack{
            VStack{
                GeometryReader{
                    let size = $0.size
                    
                    ZStack{
                        Image(intro.introAssetImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .position(x:size.width/2, y: size.height/2.8)
                        Image(intro.subIntroAssetImage)
                            .resizable()
//                            .scaledToFill()
                            .aspectRatio(contentMode: (pageIntros.firstIndex(of: intro)) == 0 ? .fit : .fit )
//                            .frame(width: size.width, height: size.height)
                        
                    }
                    
                }
                .offset(y :showView ? 0 : -size.height/2)
                .opacity(showView ? 1 : 0)
                
                VStack(alignment: .leading, spacing:0.0){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 13.5)
                            .foregroundColor(Color("third"))
                            .frame(width: 49, height: 23)
                        HStack(spacing: 0.0){
                            Text("\(pageNumber) ")
                                .foregroundColor(Color("primary"))
                                .fontWeight(.bold)
                                .font(.system(size: 12))
                            Text("of \(pageIntros.count)")
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom)
                    Text(intro.title)
                        .font(.system(size: 26.0, weight: .black))
                        .foregroundColor(Color("fourth"))
                        .lineSpacing(10)
                    Text(intro.subTitle)
                        .font(.caption)
                        .foregroundColor(Color("fourth"))
                        .opacity(0.5)
                        .padding(.top)
                        .lineSpacing(5)
                        .tracking(1)
                    
                    if !intro.displayAction{
                        Group{
                            
                            CustomIndicator(totalPage: pageIntros.count, currentPage: pageIntros.firstIndex(of: intro) ?? 0 )
                            
                            
                            Button(action: {
                                changeIntro()
                                self.pageNumber += 1
                            }, label: {
                                Text("NEXT")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 14))
                                    .foregroundColor(myColor.primary.valueRaw)
                                    .frame(width: size.width*0.9)
                                    .padding(.vertical, 10)
                                    .background{
                                        Capsule()
                                            .fill(myColor.fourth.valueRaw)
                                    }
                                
                            })
                            .padding(.top)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    }else{
                        CustomIndicator(totalPage: pageIntros.count, currentPage: pageIntros.firstIndex(of: intro) ?? 0 )
                            .padding(.top)
                        actionView
                            .padding(.top)
                            .offset(y :showView ? 0 : size.height/2)
                            .opacity(showView ? 1 : 0)
                        
                        
                    }
                    
                }
                .frame(width: 350)
                .offset(y :showView ? 0 : size.height/2)
                .opacity(showView ? 1 : 0)
                
            }
            .background(myColor.primary.valueRaw)
            .offset(y: hiddenWholeView ? size.height/2 : 0)
            .opacity(hiddenWholeView ? 0 : 1)
            .overlay(alignment: .topLeading){
                if intro != pageIntros.first{
                    Button{
                        changeIntro(true)
                        self.pageNumber -= 1
                    }label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(myColor.fourth.valueRaw)
                            .contentShape(Rectangle())
                            .frame(width: 40, height: 40)
                    }
                    .padding(10)
                    .offset(y: showView ? 0 : -200)
                    .offset(y: hiddenWholeView ? -200 : 0)
                }
            }
            .onAppear{
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)){
                    self.showView = true
                }
            }
        }
    }
    
    func changeIntro(_ isPrevious : Bool = false){
        
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)){
            self.showView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevious ? pageIntros[index-1] : pageIntros[index+1]
                
            }else{
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count-1]
            }
            
            showView = false
            hiddenWholeView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)){
                self.showView = true
            }
        }
        
        
    }
}

