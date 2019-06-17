//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/11/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    

    func testFileExistence() {
        //save fiel \
        XCTAssertEqual(FileManager.default.fileExists(atPath:" model.posterPath!") , true)
        
    }


}
