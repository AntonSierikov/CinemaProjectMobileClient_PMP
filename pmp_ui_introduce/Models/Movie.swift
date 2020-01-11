//
//  Product.swift
//  pmp_ui_introduce
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class Movie: NSObject, NSCoding, Decodable, EntityBase {
    var id: Int;
    var title: String;
    var movieDescription: String;
    var image: UIImage?;
    var voteAverage: Float;
    var voteCount: Int;
    
    required init(with dictionary: [String: Any?]) {
        self.id = dictionary["id"] as! Int;
        self.title = dictionary["title"] as! String;
        self.movieDescription = ""; //dictionary["movieDescription"] as! String;
        self.image = dictionary["image"] as? UIImage;
        self.voteAverage = dictionary["voteAverage"] as! Float;
        self.voteCount = dictionary["voteCount"] as! Int;
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        id = try values.decode(Int.self, forKey: .id);
        title = try values.decode(String.self, forKey: .title);
        movieDescription = try values.decode(String.self, forKey: .overview);
        voteAverage = try values.decode(Float.self, forKey: .vote_average);
        voteCount = try values.decode(Int.self, forKey: .vote_count);
        super.init();
        image = getImage(path: try values.decode(String.self, forKey: .poster_path));
    }
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: Keys.movieId.rawValue);
        self.title = aDecoder.decodeObject(forKey: Keys.title.rawValue) as! String;
        self.movieDescription = aDecoder.decodeObject(forKey: Keys.movieDescription.rawValue) as! String;
        let imageBase64String = aDecoder.decodeObject(forKey: Keys.posterPath.rawValue) as? String;
        if (imageBase64String != nil) {
            let data = Data(base64Encoded: imageBase64String!, options: .ignoreUnknownCharacters);
            self.image = UIImage(data: data!);
        }
        self.voteAverage = aDecoder.decodeFloat(forKey: Keys.voteAverage.rawValue);
        self.voteCount = aDecoder.decodeInteger(forKey: Keys.voteCount.rawValue);
    }
    
    var entityId: Int {
        get {
            return self.id;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.movieId.rawValue);
        aCoder.encode(title, forKey: Keys.title.rawValue)
        aCoder.encode(movieDescription, forKey: Keys.movieDescription.rawValue)
        let pngRepr64String = image?.pngData()?.base64EncodedString();
        aCoder.encode(pngRepr64String, forKey: Keys.posterPath.rawValue);
        aCoder.encode(voteAverage, forKey: Keys.voteAverage.rawValue)
        aCoder.encode(voteCount, forKey: Keys.voteCount.rawValue)
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
        case id;
        case title;
        case overview;
        case poster_path;
        case vote_average;
        case vote_count;
    }
    
    private enum Keys: String {
        case movieId;
        case title;
        case movieDescription;
        case posterPath;
        case voteAverage;
        case voteCount;
    }
}
