//
//  Apollo.swift
//  CountriesAPIGraphQLSwiftUI
//
//  Created by ramil on 13.05.2021.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    
    private init() {}
    
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
}
