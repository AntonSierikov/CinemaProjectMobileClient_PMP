//
//  pmp_ui_introduceTests.swift
//  pmp_ui_introduceTests
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import XCTest
@testable import pmp_ui_introduce

class pmp_ui_introduceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CreateMovie() {
        // arrange
        let testMovieTitle = "Test_Movie";
        let testDesctiption = "Test_Description";
        let testAverage: Float = 56.0;
        let dictionary = [
            "id": 0,
            "title": testMovieTitle,
            "movieDescription": testDesctiption,
            "image": nil,
            "voteAverage": testAverage,
            "voteCount": 8
            ] as [String : Any?];
        
        // act
        let movie = Movie(with: dictionary);
        
        // assert
        XCTAssertEqual(movie.title, testMovieTitle, "movie title should be equal");
        XCTAssertEqual(movie.movieDescription, testDesctiption, "movie description should be equal");
        XCTAssertEqual(movie.voteAverage, testAverage, "movie vote average should be equal");

    }
    
    func test_SaveMovieToFile() {
        // arrange
        let testMovieTitle = "Test_Movie";
        let testDesctiption = "Test_Description";
        let testAverage: Float = 56.0;
        let movieId = 666;
        let dictionary = [
            "id": movieId,
            "title": testMovieTitle,
            "movieDescription": testDesctiption,
            "image": nil,
            "voteAverage": testAverage,
            "voteCount": 8
            ] as [String : Any?];
        
        let movie = Movie(with: dictionary);
        let fileManager = ObjectFileManager();
        
        // act
        fileManager.saveData(object: movie, type: String(describing: type(of: movie)), id: movieId);
        let loadedMovie: Movie = fileManager.load(type: String(describing: type(of: movie)), id: movieId)!;
        
        // assert
        XCTAssertEqual(movie.title, loadedMovie.title, "movie title should be equal");
        XCTAssertEqual(movie.movieDescription, loadedMovie.movieDescription, "movie description should be equal");
        XCTAssertEqual(movie.voteAverage, loadedMovie.voteAverage, "movie vote average should be equal");
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
