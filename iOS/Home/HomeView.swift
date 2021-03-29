//
//  ContentView.swift
//  Shared
//
//  Created by Marcos Vinicius da Cunha Brito on 24/03/21.
//

import SwiftUI

struct ProductCell: View {
    let product: Product

    var body: some View {
        Text(product.name)
            .padding()
    }
}

struct HomeView: View {
    let products: [Product] = []

    var body: some View {
        NavigationView(content: {
            VStack(alignment: .center, spacing: nil, content: {
                ForEach(products, id: \.id) { product in
                    ProductCell(product: product)
                }
            })
            .navigationBarTitle("Products", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                // TODO: Chart
            }, label: {
                Text("Chart")
            }))
        })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
