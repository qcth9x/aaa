//
//  APIHandler.swift
//  LawJerry
//
//  Created by Lê Đình Linh on 25/09/2023.
//

import Foundation
import Alamofire

class APIHandler {
    let postMessageUserURL = "https://llm.hpda.vn/query"
    let getMessageBOTURL = "https://llm.hpda.vn/answer"
    
    func postMessageUser(newPost: [String:String], completion: @escaping (Bool) -> ()) {
        AF.request(postMessageUserURL,
                   method: .post,
                   parameters: newPost,
                   encoding: URLEncoding.default).validate() 
            .responseDecodable(of: LawJerryResponseModel.self) { response in
                debugPrint(response.result)
            
        }
        
    }
    
    func getMessageBOT(completion: @escaping (String?) -> ()) {
        AF.request(postMessageUserURL).responseDecodable { (response: DataResponse<LawJerryResponseModel?, AFError>) in
            switch response.result {
            case .success(let model):
                if let answer = model?.answer {
                    completion(answer)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
