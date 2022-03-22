//
//  SchoolNetworkManager.swift
//  List App API TableView
//
//  Created by 123456 on 3/21/22.
//

import UIKit

struct SchoolNetworkManager {
    
    private let client: APIClient
    
    static let schoolCache = NSCache<AnyObject, AnyObject>()
    
    init(client: APIClient = APIClient()) {
        self.client = client
    }
    
    func fetchSchools(result: @escaping ((Result<[HighSchool], Error>) -> Void)){
       client.loadSchools(result: result)
    }
    
    func fetchSAT(schoolID: String ,result: @escaping ((Result<[SAT], Error>) -> Void)){
       client.loadSchoolSAT(schoolID: schoolID, result: result)
    }
    
    func cancelTask(){
        client.cancelDataTask()
    }

    func checkForInternet(){
    }
    
}
