//
//  SampleObjects.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 01/06/25.
//

import Foundation

struct SampleObjects {
    static var contents: [InfoObject] = [
        InfoObject(
            stringURL: "https://t.me/renatalitvinova/5500",
            tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"],
            category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 30))!
        ),
        InfoObject(
            stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!
        ),
        InfoObject(
            stringURL: "https://www.apple.com/iphone/",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!
        ),
        InfoObject(
            stringURL: "https://music.apple.com/ru/album/no-surprise/1763707129?i=1763707240&l=en-GB",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            stringURL: "https://vimeo.com/580298409",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!
        ),
        InfoObject(
            title: "50 Shades of Gray",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Titanic",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 13))!
        ),
        InfoObject(
            stringURL: "https://x.com/RandomHeroWX/status/1920174904701260190",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 4))!
        ),
        InfoObject(
            stringURL: "https://www.instagram.com/flow_projects_de/reel/DJWJ8V6o4Cd/",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "Antonio Cibus",
            category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "Hyperpigmentation",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "The Devil Wears Prada",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "The Alchemist",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "The Godfather",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "iPhone 16",
            category: Category(name: "Electronis", colorName: "pink", iconName: "iphone.sizes"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 8))!
        )
    ]
}
