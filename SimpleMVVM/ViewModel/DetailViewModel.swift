//
//  DetailViewModel.swift
//  SimpleMVVM
//
//  Created by nanashiki on 2020/05/18.
//  Copyright © 2020 nanashiki. All rights reserved.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    init() {
        print("DetailViewModel init")
    }
    
    deinit {
        print("DetailViewModel deinit")
    }
    
    private var cancellable: AnyCancellable!
    
    // MARK: - Input
    enum Input {
        case onAppear
        case submit
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            prepare()
        case .submit:
            submit()
        }
    }
    
    // MARK: - Output
    @Published var tfValue: String = "" {
        didSet {
            validate()
        }
    }
    @Published private(set) var submitButtonEnable = false
    
    private func prepare() {
//        tfValue = ""
    }
    
    private func submit() {
        cancellable = APIClient()
        .fetch(request: URLRequest(url: URL(string: "https://example.com")!))
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { result in
                // TODO: エラーハンドリング
            },
            receiveValue: { _ in
                
            }
        )
    }
    
    private func validate() {
        submitButtonEnable = tfValue.count >= 9
    }
}
