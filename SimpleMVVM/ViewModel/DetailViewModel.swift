//
//  DetailViewModel.swift
//  SimpleMVVM
//
//  Created by nanashiki on 2020/05/18.
//  Copyright © 2020 nanashiki. All rights reserved.
//

import Combine

class DetailViewModel: ObservableObject {
    init() {
        print("DetailViewModel init")
    }
    
    deinit {
        print("DetailViewModel deinit")
    }
    
    @Published var tfValue: String = ""
}
