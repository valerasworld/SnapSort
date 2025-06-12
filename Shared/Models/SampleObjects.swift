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
            title: "Renata",
            stringURL: "https://t.me/renatalitvinova/5500",
            tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"],
            category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 30))!,
            comment: "Wow! reanta is so cool! I love her movies! And the fact that she uses Zemfira's music in her films is amazing!",
            isFavorite: false
        ),
        InfoObject(
            stringURL: "https://www.youtube.com/watch?v=T82izB2XBMA&list=PLY_gFbyglvNgCjCww_cWUl32h_JHTvVxr&index=3",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!,
            isFavorite: false
        ),
        InfoObject(
            stringURL: "https://www.apple.com/iphone/",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!,
            isFavorite: true
        ),
        InfoObject(
            stringURL: "https://music.apple.com/ru/album/no-surprise/1763707129?i=1763707240&l=en-GB",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
            isFavorite: false
        ),
        InfoObject(
            stringURL: "https://vimeo.com/580298409",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!,
            isFavorite: false
        ),
        InfoObject(
            title: "50 Shades of Gray",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!,
            isFavorite: true
        ),
        InfoObject(
            title: "Titanic",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 13))!,
            isFavorite: false
        ),
        InfoObject(
            stringURL: "https://x.com/RandomHeroWX/status/1920174904701260190",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 4))!,
            isFavorite: false
        ),
        InfoObject(
            stringURL: "https://www.instagram.com/flow_projects_de/reel/DJWJ8V6o4Cd/",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
            isFavorite: false
        ),
        InfoObject(
            title: "Antonio Cibus",
            stringURL: "https://httpbin.org/html",
            category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
            isFavorite: false
        ),
        InfoObject(
            title: "Hyperpigmentation",
            category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
            isFavorite: false
        ),
        InfoObject(
            title: "The Devil Wears Prada",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
            isFavorite: false
        ),
        InfoObject(
            title: "The Alchemist",
            category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!,
            isFavorite: false
        ),
        InfoObject(
            title: "The Godfather",
            category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!,
            isFavorite: true
        ),
        InfoObject(
            title: "iPhone 16",
            category: Category(name: "Electronis", colorName: "pink", iconName: "iphone.sizes"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 8))!,
            isFavorite: false
        )
    ]
    
    static var longContents: [InfoObject] = [
        InfoObject(
                title: "Dune",
                stringURL: "https://example.com/dune",
                tags: ["Sci-Fi", "Movie", "Timothée Chalamet"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 1))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://example.com/apple",
                tags: ["Tech", "iOS"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 2))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Godfather",
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 3))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Cafe de Paris",
                stringURL: "https://paris.cafe/menu",
                tags: ["Food", "Fine Dining"],
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 4))!,
                isFavorite: false
            ),
            InfoObject(
                stringURL: "https://youtube.com/watch?v=demo",
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 5))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Zemfira Live",
                tags: ["Concert", "Music", "Zemfira"],
                category: Category(name: "Theater", colorName: "red", iconName: "theatermasks.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 6))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://apple.com/music/album123",
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Hyperpigmentation",
                tags: ["Skincare", "Memes"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 8))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Alchemist",
                tags: ["Book", "Motivation"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 9))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://x.com/meme/post/123",
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 10))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Oppenheimer",
                stringURL: "https://imdb.com/title/oppenheimer",
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 11))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Zelda: Tears of the Kingdom",
                tags: ["Game", "Nintendo"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 12))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Arthouse Project",
                stringURL: "https://vimeo.com/art/film",
                category: Category(name: "Theater", colorName: "red", iconName: "theatermasks.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 13))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Flow Projects",
                stringURL: "https://www.instagram.com/flow_projects_de/reel/",
                tags: ["Performance", "Visual"],
                category: Category(name: "Theater", colorName: "red", iconName: "theatermasks.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 14))!,
                isFavorite: false
            ),
            InfoObject(
                stringURL: "https://twitter.com/project/12234",
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 15))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Devil Wears Prada",
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 16))!,
                isFavorite: true
            ),
            InfoObject(
                title: "OpenAI Website",
                stringURL: "https://openai.com",
                tags: ["Tech", "AI"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 17))!,
                isFavorite: false
            ),
            InfoObject(
                stringURL: "https://vimeo.com/clip123456",
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 18))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Salmon Sushi Guide",
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 19))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://youtube.com/shorts/skit567",
                tags: ["Funny", "Animals"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 20))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Mindfulness 101",
                stringURL: "https://medium.com/article/123",
                tags: ["Self-Help", "Meditation"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 21))!,
                isFavorite: true
            ),
            InfoObject(
                title: "WWDC 2025",
                stringURL: "https://developer.apple.com/wwdc25",
                tags: ["Apple", "Conference"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 22))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Bear – Hulu",
                stringURL: "https://hulu.com/the-bear",
                tags: ["TV Show", "Chef"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 23))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Man with No Name",
                stringURL: "https://flow-projects.org/man-with-no-name",
                tags: ["Theater", "Experimental", "Serebrennikov"],
                category: Category(name: "Theater", colorName: "red", iconName: "theatermasks.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 24))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Coffee Break Memes",
                stringURL: "https://x.com/meme/coffee",
                tags: ["Memes", "Work"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 25))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Menu",
                stringURL: "https://imdb.com/title/the-menu",
                tags: ["Movies", "Food"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 26))!,
                isFavorite: false
            ),
            InfoObject(
                title: "iOS 19 Release Notes",
                stringURL: "https://developer.apple.com/ios-19/",
                tags: ["Tech", "iOS"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 27))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Chef's Table",
                stringURL: "https://netflix.com/chefs-table",
                tags: ["Food", "TV Show"],
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 28))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://x.com/funny-cat",
                tags: ["Animals", "Cats", "LOL"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 29))!,
                isFavorite: false
            ),
            InfoObject(
                title: "War and Peace",
                tags: ["Classic", "Tolstoy"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 30))!,
                isFavorite: false
            ),
            InfoObject(
                title: "iPad Pro M4",
                stringURL: "https://apple.com/ipad-pro",
                tags: ["Gadget", "Tablet"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 1))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://www.buzzfeed.com/quiz/what-bagel",
                tags: ["Quiz", "Fun"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 2))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Noma Restaurant",
                stringURL: "https://noma.dk",
                tags: ["Fine Dining", "Michelin"],
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 3))!,
                isFavorite: true
            ),
            InfoObject(
                title: "TED Talk: Creativity",
                stringURL: "https://ted.com/talks/creativity",
                tags: ["Inspiration", "Talk"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 4))!,
                isFavorite: false
            ),
            InfoObject(
                title: "TikTok Dance Trend",
                stringURL: "https://tiktok.com/@user/trend567",
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 5))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Zaha Hadid Architecture",
                stringURL: "https://zaha-hadid.com/works",
                tags: ["Architecture", "Design"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 6))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Game Boy Emulator",
                stringURL: "https://github.com/gameboy/emulator",
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 7))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Matrix",
                stringURL: "https://imdb.com/title/the-matrix",
                tags: ["Sci-Fi", "Keanu"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 8))!,
                isFavorite: true
            ),
            InfoObject(
                stringURL: "https://youtube.com/shorts/fail321",
                tags: ["Fails", "Funny"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 9))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Little Prince",
                tags: ["Book", "Philosophy", "Children"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 10))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Apple Vision Pro",
                stringURL: "https://apple.com/vision-pro",
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 11))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Sushi Shikon",
                stringURL: "https://sushishikon.com",
                tags: ["Japan", "Omakase"],
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 12))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Levi's Commercial",
                stringURL: "https://youtube.com/watch?v=levis123",
                tags: ["Ad", "Fashion"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 13))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Infinite Jest",
                tags: ["David Foster Wallace", "Dense"],
                category: Category(name: "Books", colorName: "purple", iconName: "book.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 14))!,
                isFavorite: false
            ),
            InfoObject(
                title: "iPhone 17 Rumors",
                stringURL: "https://macrumors.com/iphone-17",
                tags: ["Tech", "Leaks"],
                category: Category(name: "Electronics", colorName: "pink", iconName: "iphone.sizes"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!,
                isFavorite: false
            ),
            InfoObject(
                title: "The Lobster",
                stringURL: "https://imdb.com/title/the-lobster",
                tags: ["Dark Comedy", "Yorgos Lanthimos"],
                category: Category(name: "Movies", colorName: "green", iconName: "popcorn.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 16))!,
                isFavorite: true
            ),
            InfoObject(
                title: "Chateau Marmont Menu",
                stringURL: "https://chateaumarmont.com/menu",
                category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 17))!,
                isFavorite: false
            ),
            InfoObject(
                title: "Balenciaga Ad Spoof",
                stringURL: "https://youtube.com/watch?v=spoof987",
                tags: ["Fashion", "Satire"],
                category: Category(name: "Memes", colorName: "blue", iconName: "face.smiling.fill"),
                dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 18))!,
                isFavorite: false
            )
    ]
    
    static var shortContents: [InfoObject] = [
        InfoObject(
            title: "Renata",
            stringURL: "https://t.me/renatalitvinova/5500",
            tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"],
            category: Category(name: "Restaurants", colorName: "orange", iconName: "fork.knife"),
            dateAdded: Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 30))!,
            comment: "Wow! reanta is so cool! I love her movies! And the fact that she uses Zemfira's music in her films is amazing!",
            isFavorite: false
        )
        ]
}
