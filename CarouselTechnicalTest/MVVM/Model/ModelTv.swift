//
//  ModelTv.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 19/04/24.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let items: [Tv]?
}

// MARK: - Tv
struct Tv: Decodable {
    let firebasescreen, firebaseTipo, tituloselcolor, tipo: String?
    let imagetv: String?
    let itemPrivate: String?
    let programa: String?
    let imagen: String?
    let firebaseScreen, titulounselcolor: String?

    enum CodingKeys: String, CodingKey {
        case firebasescreen
        case firebaseTipo = "firebase_tipo"
        case tituloselcolor, tipo, imagetv
        case itemPrivate = "private"
        case programa, imagen
        case firebaseScreen = "firebase_screen"
        case titulounselcolor
    }
}
// MARK: - ResponseUrlTv

struct ResponseUrlTv: Decodable {
    let data: [TvUrl]?
}
// MARK: - TvUrl
struct TvUrl: Decodable {
    let url: String?
    let title: String?
}
