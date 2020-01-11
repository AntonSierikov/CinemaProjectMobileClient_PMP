//
//  EntityList.swift
//  pmp_ui_introduce
//
//  Created by student on 11/29/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation


class EntityList<T: Decodable> : NSObject, NSCoding, EntityBase, Decodable {
 
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
    
    required init?(coder: NSCoder) {
        self.page = coder.decodeInteger(forKey: Keys.page.rawValue);
        self.results = coder.decodeObject(forKey: Keys.results.rawValue) as! [T];
        self.totalResults = coder.decodeInteger(forKey: Keys.total_results.rawValue);
        self.totalPages = coder.decodeInteger(forKey: Keys.total_pages.rawValue);
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.page, forKey: Keys.page.rawValue);
        coder.encode(self.results, forKey: Keys.results.rawValue);
        coder.encode(self.totalResults, forKey: Keys.total_results.rawValue);
        coder.encode(self.totalPages, forKey: Keys.total_pages.rawValue);
    }
    
    private enum CodingKeys: String, CodingKey {
        case page;
        case total_results;
        case total_pages;
        case results;
    }
    
    private enum Keys: String {
        case page;
        case total_results;
        case total_pages;
        case results;
    }
    
    var entityId: Int {
        get {
            return self.page;
        }
    }
}
