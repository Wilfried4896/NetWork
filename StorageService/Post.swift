//
//  Post.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 14.06.2022.
//

import UIKit

public struct PostFeed {
    public var title: String
    
    public init(Title title: String) {
        self.title = title
    }
    
}

public struct Article {
    public var author: String
    public var image: String?
    public var description: String
    public var likes: Int
    public var views: Int
}

public struct PhotoGame {
    public var image: String?
}

public struct Post {
    
    public static let shared = Post()

    private init() {}

    public let data: [Article] = [
        Article(
            author: "Jean-Laurent Cassely",
            image: "Steve-Jobs",
            description: "On a déjà parlé ici du danger qui consiste à justifier l’accueil de réfugiés par la mise en avant d’argument utilitaires: principalement économiques —les migrants sont une force de travail utile– et démographiques– ils combleront les trous de nos pyramides des âges de sociétés vieillissantes. Encore une fois, il ne s’agit pas de tenir le discours inverse, affirmant que l’immigration serait globalement un poids pour les sociétés d’accueil, simplement se cacher derrière un discours utilitariste est ambigu et parfois hors sujet.",
            likes: 234,
            views: 330
        ),

        Article(
            author: "Temujin",
            image: "Kali-Linux",
            description: "В начале июня состоялся релиз дистрибутива для цифровой криминалистики и тестирования систем безопасности Kali Linux 2021.2.",
            likes: 67,
            views: 322
        ),

        Article(
            author: "Destination Africa",
            image: "basilique",
            description: "Also called the Yamoussoukro Basilica, the Basilica of Our Lady of Peace is the largest Catholic religious monument in the world. Every year, thousands of people, natives, foreign pilgrims and tourists come to discover the splendor of this majestic building. However, the construction of the Basilica of Our Lady of Peace is marred by many controversies. Discover in this guide 6 things that you probably did not know about this basilica.",
            likes: 400,
            views: 300
        )
     ]
}

public struct Photo {
    public static let shared = Photo()
    private init() {}

    public let imageData: [PhotoGame] = [
        PhotoGame(image: "2"), PhotoGame(image: "3"),PhotoGame(image:"4"),PhotoGame(image: "5"),PhotoGame(image:"Kali-Linux"),PhotoGame(image: "basilique"),PhotoGame(image: "Steve-Jobs"),
    ]
    
    public static func iamgesGalery() -> [UIImage] {
        var galery = [UIImage]()
        
        let data = ["images.jpeg","images-2.jpeg", "images-3.jpeg", "images-4.jpeg", "images-5.jpeg",
                    "images-6.jpeg", "images-7.jpeg", "images-8.jpeg", "images-9.jpeg", "images-10.jpeg",
                    "images-11.jpeg", "images-12.jpeg", "images-13.jpeg", "images-14.jpeg", "images-15.jpeg",
                    "images-16.jpeg", "images-17.jpeg", "images-18.jpeg", "images-19.jpeg", "images-20.jpeg",
                    "images-21.jpeg",
        ]
        
        for name in data {
            galery.append(UIImage(named: name)!)
        }
        
        return galery
    }
   
}

