//
//  DetailView.swift
//  SimpleMVVM
//
//  Created by nanashiki on 2020/05/18.
//  Copyright © 2020 nanashiki. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        Form {
            TextField("hoge", text: $viewModel.tfValue)
            Button(action: {
                self.viewModel.apply(.submit)
            }) {
                Text("Submit")
            }.disabled(!viewModel.submitButtonEnable)
        }
        .onAppear {
            self.viewModel.apply(.onAppear)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel())
    }
}
