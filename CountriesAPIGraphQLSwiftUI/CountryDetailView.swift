//
//  CountryDetailView.swift
//  CountriesAPIGraphQLSwiftUI
//
//  Created by ramil on 13.05.2021.
//

import SwiftUI

struct CountryDetailView: View {
    let country: GetAllCountriesQuery.Data.Country
    @State private var countryInfo: GetCountryInfoQuery.Data.Country?
    
    var body: some View {
        VStack {
            Text(countryInfo?.name ?? "n/a")
                .bold()
                .font(.title)
            Text("(\(countryInfo?.native ?? "n/a"))")
            Text(countryInfo?.capital ?? "n/a")
                .padding()
            List(countryInfo?.languages ?? [], id: \.name) { language in
                Text("\(language.name ?? ""), (\(language.native ?? ""))")
            }
            
            Text("\(countryInfo?.continent.name ?? "n/a"), \(countryInfo?.continent.code ?? "n/a")")
                .foregroundColor(.secondary)
            Text("Currency: \(countryInfo?.currency ?? "n/a")")
            Text("Phone: \(countryInfo?.phone ?? "n/a")")
            
            List(countryInfo?.states ?? [], id: \.name) { state in
                Text(state.name)
            }
        }.onAppear() {
            Network.shared.apollo.fetch(query: GetCountryInfoQuery(code: country.code)) { result in
                switch result {
                case .success(let graphQLResult):
                    DispatchQueue.main.async {
                        self.countryInfo = graphQLResult.data?.country
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: GetAllCountriesQuery.Data.Country(code: "EE", name: "Estonia", capital: "Tallinn", emoji: "est"))
    }
}
