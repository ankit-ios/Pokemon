//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 21/10/23.
//

import Foundation
import Combine


class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    @Published var cancellables: Set<AnyCancellable> = []

    // path of pokemon api server's certificate
    let certificatePath = Bundle.main.path(forResource: "pokeapi", ofType: "cer")


    func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        let request = apiRequest.buildURLRequest()
        print(request)

        // Configure URLSession with SSL pinning
        let session = configureSession()

        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//MARK: - SSL Pinnning
extension NetworkManager {
    
    private func configureSession() -> URLSession {
        var configuration = URLSessionConfiguration.default

        // Load the server's certificate
        if let certificatePath = certificatePath,
           let serverCertificateData = try? Data(contentsOf: URL(fileURLWithPath: certificatePath)) {
            let pinnedCertificates = [serverCertificateData]

            // Create a policy that validates against the server's certificate
            let policy = SecPolicyCreateSSL(true, "https://pokeapi.co" as CFString)

            // Set the SSL configuration for the session
            configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 30
            configuration.timeoutIntervalForResource = 30
            configuration.httpAdditionalHeaders = ["Accept": "application/json"]
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCredentialStorage = nil
            configuration.httpShouldUsePipelining = false

            // Apply SSL pinning by setting the pinned certificates in the session's delegate
            let delegate = URLSessionPinningDelegate(pinnedCertificates: pinnedCertificates, serverHostname: "pokeapi.co")
            let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)

            return session
        }

        return URLSession(configuration: configuration)
    }
}
