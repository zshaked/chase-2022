//
//  SAT.swift
//  List App With API
//
//  Created by 123456 on 11/8/21.
//

import Foundation

struct SAT: Codable, Hashable, BaseURL{
    static let baseURL = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
    static let sats:[SAT] = [
       SAT(totalTakers: "120", math: "1400", reading: "1400", writing: "1400"),
       SAT(totalTakers: "112", math: "1420", reading: "1500", writing: "1350")
    ]
    var id:String = ""
    var totalTakers: String
    var math:String
    var reading: String
    var writing: String
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case totalTakers = "num_of_sat_test_takers"
        case reading = "sat_critical_reading_avg_score"
        case math =   "sat_math_avg_score"
        case writing = "sat_writing_avg_score"
    }
}

