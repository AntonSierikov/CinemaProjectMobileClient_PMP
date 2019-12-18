//
//  File.swift
//  pmp_ui_introduce
//
//  Created by Student on 11/28/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import Foundation

class MovieApiService : BaseApiService {
   
    override init() {
        super.init();
    }
    
    public func loadMovie(movieId: Int, with completionBlock: @escaping ((Movie) -> Void), errorBlock: @escaping ((String) -> Void) ) -> Void {
        let movieUrl = URL(string: "\(self.apiServiceUrl)movie/")!;
        let loadMovieUrl = movieUrl.appendingPathComponent(movieId.description);
        super.loadData(url: loadMovieUrl, with: completionBlock, errorBlock: errorBlock);
    }
    
    public func loadPopularMovies(page: Int, with completionBlock: @escaping ((EntityList<MovieListItem>)-> Void), errorBlock: @escaping ((String) -> Void)) -> Void {
        let moviesTopRatedListUrl = URL(string: "\(self.apiServiceUrl)movie/top_rated")!;
        var components = URLComponents(string: moviesTopRatedListUrl.absoluteString)!;
        components.queryItems = [
            URLQueryItem(name: "page", value: page.description)
        ];
        
        super.loadData(url: components.url!, with: completionBlock, errorBlock: errorBlock);
    }
}
