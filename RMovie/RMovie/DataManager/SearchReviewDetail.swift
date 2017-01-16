//
//  SearchReviewDetail.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


extension SearchManager {
    
    func searchReview(media_type: String, id: Int, completion: @escaping (_ review : [String])-> Void)  {
        var url = String()
        var reviews = [String]()
        if media_type == movieMedia {
            url = ("https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&page=1").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        } else {
            url = ("https://api.themoviedb.org/3/tv/\(id)/reviews?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&page=1").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        
        Alamofire.request(url).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                guard let review = result["content"].string else {
                    return
                }
                reviews.append(review)
            }
            completion(reviews)
        }
        
    }
}
