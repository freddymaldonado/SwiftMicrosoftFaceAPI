//
//  Face.swift
//
//  Created by Freddy Maldonado on 8/20/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//

import UIKit
import Foundation

enum FaceAPIResult<T, Error: Swift.Error> {
    case Success(T)
    case Failure(Error?)
}

class Face: NSObject {
    
    let urlGen = FaceURL()

     // Detect
     func detect(face: UIImage, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.detectReturningFaceIdOnly()
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let pngRepresentation = UIImagePNGRepresentation(face)
        
        let task = URLSession.shared.uploadTask(with: request as URLRequest, from: pngRepresentation) { (data, response, error) in
            
            if let nsError = error {
                completion(.Failure(ErrorApi.UnexpectedError(nsError: nsError as NSError)))
            }
            else {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    
                    if statusCode == 200 {
                        completion(FaceAPIResult.Success((json as JSON)))
                    }
                    else {
                        completion(.Failure(ErrorApi.ServiceError(json: json as! [String : AnyObject])))
                    }
                }
                catch {
                    completion(.Failure(ErrorApi.JSonSerializationError))
                }
            }
        }
        task.resume()
    }
    
    // Identify
    func identify(faceIds: [String], largePersonGroupId: String, maxNumOfCandidatesReturned: Int, confidenceThreshold: Double, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.identifyUrl()
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let json: [String: AnyObject] = ["faceIds": faceIds as AnyObject, "personGroupId": largePersonGroupId as AnyObject, "maxNumOfCandidatesReturned": maxNumOfCandidatesReturned as AnyObject, "confidenceThreshold": confidenceThreshold as AnyObject]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let nsError = error {
                completion(.Failure(ErrorApi.UnexpectedError(nsError: nsError as NSError as NSError)))
            }
            else {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String: AnyObject]
                    
                    if statusCode == 200 {
                        completion(FaceAPIResult.Success((json as JSON)))
                    }
                    else {
                        completion(.Failure(ErrorApi.ServiceError(json: json )))
                    }
                }
                catch {
                    completion(.Failure(ErrorApi.JSonSerializationError))
                }
            }
        }
        task.resume()
    }
    
    
}
