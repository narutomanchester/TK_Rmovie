//
//  Movie.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class Movie {
    static let shared = Movie()
    
    var id : Int!
    var name : String!
    var poster : String!
    var backdrop : String!
    var popularity : Float!
    var year : String!
    var score : Float!
    var overview : String!
    var genre : [Int]!
    var media_type : String!
    var casts : [Actor]!
    
    func convertGenre(genre : Int) -> String {
        var genreName = String()
        switch genre {
        case 28:
            genreName = "Action"
        case 12:
            genreName = "Adventure"
        case 16:
            genreName = "Animation"
        case 35:
            genreName = "Comedy"
        case 80:
            genreName = "Crime"
        case 99:
            genreName = "Documentary"
        case 18:
            genreName = "Drama"
        case 10751:
            genreName = "Family"
        case 14:
            genreName = "Fantasy"
        case 10420:
            genreName = "Music"
        case 9648:
            genreName = "Mystery"
        case 10749:
            genreName = "Ramance"
        case 878:
            genreName = "Science Fiction"
        case 10770:
            genreName = "TV Movie"
        case 53:
            genreName = "Thriller"
        case 10752:
            genreName = "War"
        case 37:
            genreName = "Western"
        default:
            break
        }
        return genreName
    }
}
