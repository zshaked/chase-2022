//
//  HighSchool.swift
//  List App API TableView
//
//  Created by 123456 on 3/21/22.
//

import Foundation

protocol BaseURL: Codable {
    static var baseURL:URL? {get}
}

struct HighSchool: Hashable,Codable,Identifiable, BaseURL{
    static var baseURL = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
    static let highSchools:[HighSchool] = []
    
    var id:String = ""
    let name:String
    var sat:SAT = SAT(totalTakers: "0", math:"0", reading: "0", writing: "0")
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
    }
}
