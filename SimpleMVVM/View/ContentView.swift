//
//  ContentView.swift
//  SimpleMVVM
//
//  Created by nanashiki on 2020/05/18.
//  Copyright © 2020 nanashiki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailView(viewModel: DetailViewModel())) {
                Text("Detail")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
