//
//  MovieListItem.swift
//  pmp_ui_introduce
//
//  Created by student on 11/29/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation

class MovieListItem : NSObject, NSCoding, Decodable {

    
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
    
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: CodingKeys.title.rawValue);
        coder.encode(self.voteAverage, forKey: CodingKeys.vote_average.rawValue);
        coder.encode(self.releaseDate, forKey: CodingKeys.release_date.rawValue);
        coder.encode(self.movieId, forKey: CodingKeys.id.rawValue);
    }
    
    required init?(coder: NSCoder) {
        self.title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as! String;
        self.voteAverage = coder.decodeFloat(forKey: CodingKeys.vote_average.rawValue);
        self.releaseDate = coder.decodeObject(forKey: CodingKeys.release_date.rawValue) as! String;
        self.movieId = coder.decodeInteger(forKey: CodingKeys.id.rawValue);
    }
    
    private enum CodingKeys: String, CodingKey {
        case title;
        case id;
        case vote_average;
        case release_date;
    }
}
