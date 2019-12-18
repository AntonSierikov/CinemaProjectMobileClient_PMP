//
//  Product.swift
//  pmp_ui_introduce
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class Movie: NSObject, Decodable {
    var title: String;
    var movieDescription: String;
    var image: UIImage?;
    var voteAverage: Float;
    var voteCount: Int;
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        title = try values.decode(String.self, forKey: .title);
        movieDescription = try values.decode(String.self, forKey: .overview);
        voteAverage = try values.decode(Float.self, forKey: .vote_average);
        voteCount = try values.decode(Int.self, forKey: .vote_count);
        super.init();
        image = getImage(path: try values.decode(String.self, forKey: .poster_path));

    }
    
    func getImage(path: String) -> UIImage? {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + path);
        var image: UIImage? = nil;
        
        if let data = try? Data(contentsOf: url!) {
            image = UIImage(data: data);
        }
        
        return image;
    }
    
    private enum CodingKeys: String, CodingKey {
        case title;
        case overview;
        case poster_path;
        case vote_average;
        case vote_count;
    }
}
