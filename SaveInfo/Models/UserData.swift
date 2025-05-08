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
        InfoObject(title: "Harry Potter", author: "J.K. Rowling", stringURL: "https://www.apple.com/iphone/", category: .books),
        InfoObject(title: "Harry Potter", author: "J.K. Rowling", stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3", category: .books),
        InfoObject(title: "Harry Potter", author: "J.K. Rowling", stringURL: "https://music.apple.com/ru/album/no-surprise/1763707129?i=1763707240&l=en-GB", category: .books),
        InfoObject(title: "Harry Potter", author: "J.K. Rowling", stringURL: "https://vimeo.com/580298409", category: .books),
        
        InfoObject(title: "50 Shades of Gray", author: "E.L. James", category: .books),
        InfoObject(title: "Titanic", author: "James Cameron", category: .movies),
        InfoObject(title: "Antonio Cibus", category: .restaurants),
        InfoObject(title: "Hyperpigmentation", category: .memes),
        InfoObject(title: "The Devil Wears Prada", category: .movies),
        InfoObject(title: "The Alchemist", author: "Paulo Coelho", category: .books),
        InfoObject(title: "The Godfather", author: "Mario Puzo", category: .movies),
        InfoObject(title: "Harry Potter", author: "J.K. Rowling", stringURL: "https://www.apple.com/iphone/", category: .books),
        InfoObject(title: "iPhone 16", category: .electronics),
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
