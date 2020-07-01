//
//  APIClient.swift
//  SimpleMVVM
//
//  Created by nanashiki on 2020/07/01.
//  Copyright © 2020 nanashiki. All rights reserved.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode(_ code: Int)
    case unknown
}

struct APIClient {
    let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    
    func fetch(request: URLRequest) -> AnyPublisher<Data, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap({ (output) -> (data: Data, response: URLResponse) in
                guard let response = output.response as? HTTPURLResponse else {
                    throw HTTPError.unknown
                }
                guard (200..<300).contains(response.statusCode) else {
                    self.logError(request: request, statusCode: response.statusCode)
                    throw HTTPError.statusCode(response.statusCode)
                }
                return output
            })
            .map { $0.data }
            .handleEvents(
                receiveOutput: {
                    self.log(request: request, response: String(data: $0, encoding: .utf8) ?? "")
                }
            )
            .eraseToAnyPublisher()
    }

    private func log(request: URLRequest, response: Any) {
        #if DEBUG
        print("")
        print("200 \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        print("  requestHeader: \(request.allHTTPHeaderFields ?? [:])")
        if let httpBody = request.httpBody {
            print("  requestBody: \(String(data: httpBody, encoding: .utf8) ?? "")")
        }
        print("  response: \(response)")
        print("")
        #endif
    }

    private func logError(request: URLRequest, statusCode: Int) {
        #if DEBUG
        print("")
        print("\(statusCode) \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        print("  requestHeader: \(request.allHTTPHeaderFields ?? [:])")
        if let httpBody = request.httpBody {
            print("  requestBody: \(String(data: httpBody, encoding: .utf8) ?? "")")
        }
        print("")
        #endif
    }
}
