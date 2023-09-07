//
//  Catalog.swift
//  MV-Project
//
//  Created by Daniel Coria on 07/08/23.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let image: String
}

var characterSelected: Character = .empty

@MainActor
class Store: ObservableObject {
    private var storeHTTPClient: StoreHTTPClient
    
    @Published var products: [Product] = []
    
    init(storeHTTPClient: StoreHTTPClient) {
        self.storeHTTPClient = storeHTTPClient
    }
    
    func loadProducts() async throws {
        products = try await storeHTTPClient.fetchProducts()
    }
    
}

@MainActor
class StoreCharacter: ObservableObject {
    private var storeCharacterHTTPClient: ChaarcterHTTPClient
    
    @Published var characters: [Character] = []
    @Published var comics: [ComicModel] = [ComicModel]()
    
    init(storeCharacterHTTPClient: ChaarcterHTTPClient) {
        self.storeCharacterHTTPClient = storeCharacterHTTPClient
    }
    
    func loadCharacters() async throws {
        characters = try await storeCharacterHTTPClient.fetchCharacters(type: .characters).data.results
    }
    
    func fetchComic(character: Character) async throws {
        comics = try await storeCharacterHTTPClient.fetchComic(type: .comics, characterID: character.id.toString()).data.results
        print()
    }
    
}


struct DataResultCharacters: Decodable {
    let data: Results
}

struct Results: Decodable {
    let results: [Character]
}

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ImageURL
    
    static let empty = Character(id: 0, name: "", description: "", thumbnail: ImageURL(path: "", extension: ""))
}

struct ImageURL: Decodable {
    let path: String
    let `extension`: String
}

struct ComicItem: Hashable, Decodable {
    let resourceURI: String
    let name: String
}


struct DataResultComics: Decodable {
    let data: ResultComics
}

struct ResultComics: Decodable {
    let results: [ComicModel]
}

struct ComicModel:Identifiable, Decodable {
    let id: Int
    let title: String
    let thumbnail: ImageURL
}
