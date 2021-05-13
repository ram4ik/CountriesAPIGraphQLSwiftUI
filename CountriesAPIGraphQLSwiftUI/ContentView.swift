//
//  ContentView.swift
//  CountriesAPIGraphQLSwiftUI
//
//  Created by ramil on 13.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries: [GetAllCountriesQuery.Data.Country] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List(countries, id: \.code) { country in
                    NavigationLink(destination: CountryDetailView(country: country)) {
                        HStack {
                            Text(country.emoji)
                            Spacer()
                            VStack {
                                Text(country.name)
                                if let capital = country.capital {
                                    Text(capital)
                                }
                            }
                            Spacer()
                            Text(country.code)
                        }
                    }
                }.listStyle(PlainListStyle())
            }
            .onAppear() {
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()) { result in
                    switch result {
                    case .success(let graphQLResult):
                        if let countries = graphQLResult.data?.countries {
                            DispatchQueue.main.async {
                                self.countries = countries
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .navigationTitle("Countries")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
