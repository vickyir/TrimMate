//
//  PageIntro.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 29/05/23.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable{
    var id: UUID = .init()
    var introAssetImage: String
    var subIntroAssetImage: String = ""
    var title: String
    var subTitle: String
    var displayAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "or-on-1", subIntroAssetImage: "or-on-1.1", title:"Welcome to TrimMate, your partner for choosing haircut styles.", subTitle:"There will be a face shape matching process, make sure your face is aligned with the available outline."),
    .init(introAssetImage: "or-on-2", subIntroAssetImage: "or-on-2.1", title:"Choose the best hairstyle based on your\nface shape", subTitle:"There will be a list of recommended models that you can choose according to the shape of your face."),
    .init(introAssetImage: "or-on-3", subIntroAssetImage: "or-on-3.1", title: "Start displaying\nhairstyles\nwith Augmented Reality", subTitle:"Visualize existing hairstyles in the real world with augmented reality technology!.", displayAction: true)
]
