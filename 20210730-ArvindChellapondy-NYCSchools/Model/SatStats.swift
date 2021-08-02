//
//  SatStats.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 8/1/21.
//

import Foundation

//sat stats struct
struct SatStats : Decodable{
    
    let dbn: String
    let schoolName : String
    let numberOfTestTakers : String
    let avgCriticalReadingScore : String
    let avgMathScore : String
    let avgWritingScore : String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numberOfTestTakers = "num_of_sat_test_takers"
        case avgCriticalReadingScore = "sat_critical_reading_avg_score"
        case avgMathScore = "sat_math_avg_score"
        case avgWritingScore = "sat_writing_avg_score"
    }
}
