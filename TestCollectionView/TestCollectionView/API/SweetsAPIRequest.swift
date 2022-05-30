//
//  SweetsAPIRequest.swift
//  TestCollectionView
//
//  Created by なぐも on 2022/05/30.
//

import Foundation
import APIKit

struct FetchSweetsAPI{    
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2/")!
    }
}
