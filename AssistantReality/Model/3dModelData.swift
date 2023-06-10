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
    .init(name: "Buzz Cut", icon: .init(named: "OvalBuzzCut.usdz"), iconName: "OvalBuzzCut", isFavorite: true, description: "Buzz Cut is suitable for customers who want to look elegant, neat, and like to exercise. This haircut is suitable for all hair types. This haircut doesn't require too long top hair. You can tell the barber to cut it evenly short using the clippers on the top, sides and back. On the front hairline is made more assertive. And for the sides and back you can ask for a Fade/Taper cut."),
    .init(name: "Curtain", icon: .init(named: "OvalCurtain.usdz"), iconName: "OvalCurtain", isFavorite: true, description: "Curtain is suitable for customers who want a modern, youthful look. This haircut is suitable for customers who have straight or wavy hair types. This haircut usually has a slightly longer top hair length. You can tell the barber to adjust the top of your hair so that it can be divided into two equal parts, then comb one part to the left and one part to the right. And you can have the sides and back of your hair cut Natural/Fade/Taper."),
    .init(name: "Faux Hawk", icon: .init(named: "OvalFauxHawk.usdz"), iconName: "OvalFauxHawk", isFavorite: false, description: "Faux Hawk, also known as a 'fohawk,' is a trendy and versatile men's haircut that resembles a mohawk but with a less extreme and more wearable look. This haircut is suitable for all hair types. To get this haircut, you can tell the barber to cut the top of your hair according to the height of the topknot you want, then give it a texture and comb it upwards. And for the sides and back you can ask for Fade/Taper/Natural cuts."),
    .init(name: "Flat Top", icon: .init(named: "OvalFlatTop.usdz"), iconName: "OvalFlatTop", isFavorite: false, description: "Spiky is suitable for customers who want to be seen. This haircut is suitable for customers with all types of hair types. You can tell the barber to cut the top of your hair with a clipper, and make the top of your hair look like a flat surface, but for long hair you need hair products to maintain the shape of the hair. And for the side you can ask for a Fade/Taper/Natural cut."),
    .init(name: "Pompadour", icon: .init(named: "OvalPompadour.usdz"), iconName: "OvalPompadour", isFavorite: false, description: "Pompadour is haircut that is suitable for young customers with a contemporary style. This style also looks very elegant, so it is suitable for formal and non-formal events. This cut is only suitable for wavy and straight hair types. You can tell the barber not to cut the front bangs too short, so you can style your brush left and right as you wish. You can also ask the barber to trim the sides and back in a taper, fade, or natural style, according to your preference. However, this style may not suit someone with a wide forehead shape, as the pompadour usually accentuates the top of the head. With the pompadour, you will get a trendy and elegant look. This style gives off a classy feel and can elevate your overall look. Make sure to choose a cut that suits your hair texture and takes your face shape into account for optimal results."),
    .init(name: "Two Block", icon: .init(named: "OvalTwobBlock.usdz"), iconName: "OvalTwobBlock", isFavorite: false, description: "Two Block is the perfect style for customers who like simplicity and an up-to-date look. This style is perfect for a variety of formal and non-formal activities. This cut is only suitable for straight and wavy hair types. You can tell the barber to cut the sides and back of your hair short, while leaving the top long. This gives the impression of thinner hair. Shave the sides and back in the Morrisey style of 2 fingers or slightly shorter. This style is perfect for those of you who have thick hair. With this Two Block piece, you will get a simple yet modern look. This style gives a neat and well-maintained impression with a bit of a stylish touch, according to your preference for simplicity and a contemporary look.")
]
