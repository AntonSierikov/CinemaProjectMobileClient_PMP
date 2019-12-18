//
//  MovieListItem.swift
//  pmp_ui_introduce
//
//  Created by student on 11/29/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation

class MovieListItem : NSObject, Decodable {
    var title: String;
    var voteAverage: Float;
    var releaseDate: String;
    var movieId: Int;
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        title = try values.decode(String.self, forKey: .title);
        voteAverage = try values.decode(Float.self, forKey: .vote_average);
        releaseDate = try values.decode(String.self, forKey: .release_date);
        movieId = try values.decode(Int.self, forKey: .id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case title;
        case id;
        case vote_average;
        case release_date;
    }
}
