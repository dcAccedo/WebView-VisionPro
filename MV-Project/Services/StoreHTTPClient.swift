//
//  BasicServices.swift
//  BasicProject
//
//  Created by DC on 22/04/20.
//  Copyright © 2020 DC. All rights reserved.
//

import Foundation
import Combine

protocol StoreHTTPClient {
    
    func fetchProducts() async throws -> [Product]
}

protocol ChaarcterHTTPClient {
    
    func fetchCharacters(type: Constants.urlWS) async throws -> DataResultCharacters
    func fetchComic(type: Constants.urlWS, characterID: String) async throws -> DataResultComics
}


final class DefaultStoreHTTPClient: StoreHTTPClient {
        
    private let session: HTTPSession = DefaultHTTPSession()
    private var cancellable: AnyCancellable?
    
    func fetchProducts() async throws -> [Product] {
        let request = HTTPRequestBuilder(baseURL: URL(string: "https://fakestoreapi.com")!)
            .set(path: "/products")
            .build()
        
        return try await session.data(request: request, mapper: ProductsMapper())
    }
    
    // MARK: Private
    
    private func makeBaseBuilder(url: URL) -> HTTPRequestBuilder {
        HTTPRequestBuilder(baseURL: url)
    }
}

final class ProductsMapper: HTTPResponseMapper {
    
    typealias Output = [Product]
    
    func map(data: Data, response: HTTPURLResponse) throws -> [Product] {
        switch response.statusCode {
        case 200:
            return try data.decode()
        default:
            throw HTTPError.cannotDecodeRawData
        }
    }
}


final class DefaultCharactersHTTPClient: ChaarcterHTTPClient {
    
    let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" ) + "." + (Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")
    let publicKey: String = "2e5f545f4797c360a84dc51fc1e61802"
    let privateKey: String = "f7f81fd59361eb843bdb01a9eb36c2191beb7563"
    let ts: String = "1"
    
    private let session: HTTPSession = DefaultHTTPSession()
    private var cancellable: AnyCancellable?
    
    func fetchCharacters(type: Constants.urlWS) async throws -> DataResultCharacters {
        let hash = "\(ts)\(privateKey)\(publicKey)"
        
        var path = ""
        
        switch type {
        case .characters:
            path = Constants.urlWS.characters.rawValue
        case .comics:
            let comicsURL = String(format: Constants.urlWS.comics.rawValue, 0)
            path = comicsURL
        default:
            break
        }
        
        
        let request = HTTPRequestBuilder(baseURL: URL(string: Constants.urlWS.main.rawValue)!)
            .set(path: path)
            .addParameter(name: "ts", value: "1")
            .addParameter(name: "apikey", value: publicKey)
            .addParameter(name: "hash", value: hash.hashed(.md5)!)
            .addParameter(name: "limit", value: "30")
            .build()
        
        return try await session.data(request: request, mapper: CharactersMapper())
    }
    
    func fetchComic(type: Constants.urlWS, characterID: String) async throws -> DataResultComics {
        let hash = "\(ts)\(privateKey)\(publicKey)"
        
        var path = ""
        
        switch type {
        case .characters:
            path = Constants.urlWS.characters.rawValue
        case .comics:
            let comicsURL = String(format: Constants.urlWS.comics.rawValue, characterID)
            path = comicsURL
        default:
            break
        }
        
        
        let request = HTTPRequestBuilder(baseURL: URL(string: Constants.urlWS.main.rawValue)!)
            .set(path: path)
            .addParameter(name: "ts", value: "1")
            .addParameter(name: "apikey", value: publicKey)
            .addParameter(name: "hash", value: hash.hashed(.md5)!)
            .addParameter(name: "limit", value: "20")
            .build()
        
        return try await session.data(request: request, mapper: ComicMapper())
    }
    
    // MARK: Private
    
    private func makeBaseBuilder(url: URL) -> HTTPRequestBuilder {
        HTTPRequestBuilder(baseURL: url)
    }
}
                                      
final class CharactersMapper: HTTPResponseMapper {
    
    typealias Output = DataResultCharacters
    
    func map(data: Data, response: HTTPURLResponse) throws -> DataResultCharacters {
        switch response.statusCode {
        case 200:
            return try data.decode()
        default:
            throw HTTPError.cannotDecodeRawData
        }
    }
}

final class ComicMapper: HTTPResponseMapper {
    
    typealias Output = DataResultComics
    
    func map(data: Data, response: HTTPURLResponse) throws -> DataResultComics {
        switch response.statusCode {
        case 200:
            return try data.decode()
        default:
            throw HTTPError.cannotDecodeRawData
        }
    }
}
