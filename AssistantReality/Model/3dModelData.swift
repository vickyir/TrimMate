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
    var isFavorite: Bool = false
    var description: String
}


var HairModels : [HairModel] = [
    .init(name: "Yari", icon: .init(named: "Yari.usdz"), isFavorite: true, description: "Ini adalah deskripsi singkat"),
    .init(name: "Vicky", icon: .init(named: "Yari.usdz"), isFavorite: true, description: "Ini adalah deskripsi singkat2"),
    .init(name: "Dimas", icon: .init(named: "Yari.usdz"), isFavorite: false, description: "Ini adalah deskripsi singkat3"),
    .init(name: "Irvan", icon: .init(named: "Yari.usdz"), isFavorite: false, description: "Ini adalah deskripsi singkat4"),
    .init(name: "Aang", icon: .init(named: "Yari.usdz"), isFavorite: false, description: "Ini adalah deskripsi singkat5")
]
