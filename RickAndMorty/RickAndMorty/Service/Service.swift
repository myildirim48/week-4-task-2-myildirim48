//
//  Service.swift
//  RickAndMorty
//
//  Created by YILDIRIM on 28.12.2022.
//

import Foundation
class Service {
    static let shared = Service()

    func fetchEpisodes(page:Int,completion: @escaping(Episodes?,Error?) -> ()){
        let urlString = "https://rickandmortyapi.com/api/episode?page=\(page)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    func fetchCharacter(page:Int,completion: @escaping(Characters?,Error?) -> ()) {
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
        fetchGeneric(urlString: urlString, completion: completion)
    }
    
    
    func fetchGeneric<T:Decodable>(urlString:String, completion: @escaping (T?,Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(nil,err)
                print("Error while fetching data at Service",err)
            }
            do{
                let objects = try JSONDecoder().decode(T.self, from: data!)
                //Success
                completion(objects,nil)
            }catch{
                completion(nil,err)
                print("Error while fetching data at Service Catch")
            }
      }.resume()
    }
}