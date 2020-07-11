//
//  CurrencyService.swift
//  QuickSwap
//
//  Created by Piotr Szadkowski on 10/07/2020.
//

import Foundation
import Combine

protocol CurrencyProvider: class {
    func fetchCurrencies(for base: String) -> Future<CurrencyConversion, CurrencyServiceError>
}

enum CurrencyServiceError: Error {
    case invalidBase
    case urlError
    case deallocated
    case conversionError
    case decodingError
    
    init(urlError: URLError) {
        print(urlError)
        self = .urlError
    }
}

final class CurrencyService: CurrencyProvider {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCurrencies(for base: String) -> Future<CurrencyConversion, CurrencyServiceError> {
        return .init { [weak self] promise in
            guard let self = self else {
                promise(.failure(.deallocated))
                return
            }
            
            guard let url = self.components(for: base).url else {
                promise(.failure(.invalidBase))
                return
            }
            
            self.session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    promise(.failure(.urlError))
                    return
                }
                
                guard let data = data else {
                    promise(.failure(.conversionError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.exchangeratesApiDateFormat)
                    let currency = try decoder.decode(CurrencyConversion.self, from: data)
                    promise(.success(currency))
                } catch {
                    promise(.failure(.decodingError))
                }
                
            }.resume()
            
        }
    }
    
    private func components(for base: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.exchangeratesapi.io"
        components.path = "/latest"
        components.queryItems = [URLQueryItem(name: "base", value: base)]
        return components
    }
    
    private func currencyDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.exchangeratesApiDateFormat)
        return decoder
    }
    
}

extension DateFormatter {
    static let exchangeratesApiDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
