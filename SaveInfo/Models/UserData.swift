//
//  UserData.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

@Observable
class UserData {
    var objects: [InfoObject] = [
        
        InfoObject(
//            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://t.me/renatalitvinova/5500",
            category: .restaurants,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 1))!
        ),
        InfoObject(
            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3",
            category: .movies,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
//            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://www.apple.com/iphone/",
            category: .books,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 15))!
        ),
        InfoObject(
            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://music.apple.com/ru/album/no-surprise/1763707129?i=1763707240&l=en-GB",
            category: .memes,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://vimeo.com/580298409",
            category: .books,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        
        InfoObject(
            title: "50 Shades of Gray",
            author: "E.L. James",
            category: .books,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Titanic",
            author: "James Cameron",
            stringURL: "https://sdsdb.fsdgj",
            category: .movies,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Tweet",
            author: "Cardinals chill",
            stringURL: "https://x.com/RandomHeroWX/status/1920174904701260190",
            category: .memes,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Insta reel",
            stringURL: "https://www.instagram.com/flow_projects_de/reel/DJWJ8V6o4Cd/",
            category: .movies,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Antonio Cibus",
            category: .restaurants,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "Hyperpigmentation",
            category: .memes,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "The Devil Wears Prada",
            category: .movies,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!
        ),
        InfoObject(
            title: "The Alchemist",
            author: "Paulo Coelho",
            category: .books,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "The Godfather",
            author: "Mario Puzo",
            category: .movies,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "Harry Potter",
            author: "J.K. Rowling",
            stringURL: "https://www.apple.com/iphone/",
            category: .books,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!
        ),
        InfoObject(
            title: "LinkedIn Page",
            stringURL:"https://www.linkedin.com/",
            category: .electronics,
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 8))!
        ),
    ]
    
    func findUniqueCategories() -> [Category] {
        var categories: [Category] = []
        categories = Array(Set(objects.map { $0.category }))
        return categories.sorted { $0.rawValue < $1.rawValue }
    }
    
    func filterByCategory(category: Category?) -> [InfoObject] {
        guard category != nil else {
            return objects
        }
        let filteredObjects: [InfoObject] = objects.filter({ $0.category == category })
        
        return filteredObjects
    }
}
