//
//  EntityList.swift
//  pmp_ui_introduce
//
//  Created by student on 11/29/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation


class EntityList<T: Decodable> : NSObject, Decodable {
    public var page: Int;
    public var results: [T];
    public var totalResults: Int;
    public var totalPages: Int;
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self);
        page = try values.decode(Int.self, forKey: .page);
        totalResults = try values.decode(Int.self, forKey: .total_results);
        totalPages = try values.decode(Int.self, forKey: .total_pages);
        results = try values.decode([T].self, forKey: .results)
    }
    
    private enum CodingKeys: String, CodingKey {
        case page;
        case total_results;
        case total_pages;
        case results;
    }
}
