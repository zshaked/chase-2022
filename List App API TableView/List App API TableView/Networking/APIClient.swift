//
//  ModelData.swift
//  List App API TableView
//
//  Created by 123456 on 3/21/22.
//

import SwiftUI

final class APIClient{
    @Published var highSchools: [HighSchool] = .init()

    
    enum HTTPError: LocalizedError {
        case statusCode
    }
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
     private let session: URLSession
     
    var dataTask:URLSessionDataTask?
    
     func loadSchools(result: @escaping ((Result<[HighSchool], Error>) -> Void)) -> URLSessionDataTask{
        guard let url = HighSchool.baseURL else{
            fatalError("invalid base url")
        }
         
         var request: URLRequest = URLRequest(url: url,
                                              cachePolicy: .reloadIgnoringLocalCacheData,
                                              timeoutInterval: 10)
         request.httpMethod = "GET"
    
         dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
             guard let data = data else {
                 if let error: Error = error {
                     result(.failure(error))
                 }
                 return
             }
             
             do {
                 let decodedData = try JSONDecoder().decode([HighSchool].self, from: data)
                 result(.success(decodedData))
                 
             } catch let error {
                 result(.failure(error))
             }
         }
         
         dataTask?.resume()
         
         return dataTask!
    }
    
    func loadSchoolSAT(schoolID: String, result: @escaping ((Result<[SAT], Error>) -> Void)) -> URLSessionDataTask{
        guard let baseURL = SAT.baseURL, var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else{
            fatalError("invalid url")
        }
        
        components.queryItems = [URLQueryItem(name: "dbn", value: schoolID)]
        
        guard let url:URL = components.url else{
            fatalError("invalid compenents")
        }
        
        var request: URLRequest = URLRequest(url: url,
                                             cachePolicy: .reloadIgnoringLocalCacheData,
                                             timeoutInterval: 10)
        request.httpMethod = "GET"
   
        dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                if let error: Error = error {
                    result(.failure(error))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([SAT].self, from: data)
                result(.success(decodedData))
                
            } catch let error {
                result(.failure(error))
            }
        }
        
        dataTask?.resume()
        
        return dataTask!
   }
    
    func loadSAT(schoolID:String) async -> SAT{
        guard let baseURL = SAT.baseURL, var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else{
            fatalError("invalid url")
        }
        
        components.queryItems = [URLQueryItem(name: "dbn", value: schoolID)]
        
        guard let url:URL = components.url else{
            fatalError("invalid compenents")
        }
        
        
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let sat = try decoder.decode([SAT].self, from: data)
            guard let sat = sat.first else{
                return SAT(totalTakers: "0", math: "0", reading: "0", writing: "0")

            }
            return sat
        }
        catch{
            fatalError("failed to decode data: \(error), url: \(url.absoluteString)")
        }
    }
    
    func load<T: BaseURL>() async throws->T{
        guard let url = T.baseURL else{
            fatalError("invalid base url")
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        catch{
            fatalError("failed to decode data")
        }
    }
    
    func cancelDataTask(){
        dataTask?.cancel()
        dataTask = nil
    }
    
}

/*
 Improvements
 1) Fail gracefully
 2) Paging during scrolling
 3) Cacheing
 4) Search Functionality
 */

