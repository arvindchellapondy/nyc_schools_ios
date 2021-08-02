//
//  NycSchoolsService.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/30/21.
//

import Foundation
import Alamofire

//service api
class NycSchoolsService{
    
    let BASE_URL = "https://data.cityofnewyork.us/"
    
    // gets school list data
    func getSchoolsData(completion: @escaping ([School]) -> Void) {
        
            let endpoint = "resource/s3k6-pzi2.json"
            
            AF.request(BASE_URL + endpoint, method: .get).responseDecodable(of: [School].self, queue: .main, decoder: JSONDecoder()) { (response) in
                
                switch response.result {
                case let .success(data):
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                    completion([])
                }
            }
        }
    
    //gets sat stats data
    func getSatScoreStats(completion: @escaping([SatStats]) -> Void){
        let endpoint = "resource/f9bf-2cp4.json"
        
        AF.request(BASE_URL + endpoint, method: .get).responseDecodable(of: [SatStats].self, queue: .main, decoder: JSONDecoder()) { (response) in
            
            switch response.result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
}
