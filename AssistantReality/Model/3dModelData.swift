//
//  3dModelData.swift
//  AssistantReality
//
//  Created by Vicky Irwanto on 02/06/23.
//

import SwiftUI
import SceneKit


struct HairModel: Identifiable, Hashable{
    var id: UUID = .init()
    var name: String
    var icon: SCNScene?
    var iconName: String
    var isFavorite: Bool = false
    var description: String
}


var HairModels : [HairModel] = [
    .init(name: "Yari", icon: .init(named: "test2.usdz"), iconName: "test2", isFavorite: true, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    .init(name: "Vicky", icon: .init(named: "3dModelB.usdz"), iconName: "3dModelB", isFavorite: true, description: "Ini adalah deskripsi singkat2"),
    .init(name: "Dimas", icon: .init(named: "3dModelC.usdz"), iconName: "3dModelC", isFavorite: false, description: "Ini adalah deskripsi singkat3"),
    .init(name: "Irvan", icon: .init(named: "3dModelD.usdz"), iconName: "3dModelD", isFavorite: false, description: "Ini adalah deskripsi singkat4"),
    .init(name: "Aang", icon: .init(named: "Yari.usdz"), iconName: "Yari", isFavorite: false, description: "Ini adalah deskripsi singkat5")
]
