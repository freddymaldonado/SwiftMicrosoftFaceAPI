//
//  LargePersonGroupPerson.swift
//
//  Created by Freddy Maldonado on 8/19/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//

import Foundation
import UIKit

class LargePersonGroupPerson: NSObject {
    
    let urlGen = LargePersonGroupPersonURL()

    // Detect faces
    func addFace(face: UIImage, largePersonGroupId: String, personId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.addFaceUrl(largePersonGroupId: largePersonGroupId, personId: personId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
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
    
    // Create
    func create(name: String, largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.createUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let json: [String: AnyObject] = ["name": name as AnyObject]
        
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
    
    // Delete
    func delete(largePersonGroupId: String, personId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.deleteUrl(largePersonGroupId: largePersonGroupId, personId: personId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "DELETE"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
    
    // Delete Face
    func deleteFace(largePersonGroupId: String, personId: String, persistedFaceId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.deleteFaceUrl(largePersonGroupId: largePersonGroupId, personId: personId, persistedFaceId: persistedFaceId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "DELETE"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
    
    // Get
    func get(largePersonGroupId: String, personId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.getUrl(largePersonGroupId: largePersonGroupId, personId: personId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "GET"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
    
    // Get Face
    func getFace(largePersonGroupId: String, personId: String, persistedFaceId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.getFaceUrl(largePersonGroupId: largePersonGroupId, personId: personId, persistedFaceId: persistedFaceId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "GET"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
    
    // List
    func list(largePersonGroupId: String, start: String, top: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.listUrl(largePersonGroupId: largePersonGroupId, start: start, top: top)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "GET"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
    
    // Update
    func update(name: String, largePersonGroupId: String, personId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.updateUrl(largePersonGroupId: largePersonGroupId, personId: personId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let json: [String: AnyObject] = ["name": name as AnyObject]
        
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
                    
                    if statusCode == 202 {
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
    
    // Update Face
    func updateFace(userData: String, largePersonGroupId: String, personId: String, persistedFaceId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.updateFaceUrl(largePersonGroupId: largePersonGroupId, personId: personId, persistedFaceId: persistedFaceId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let json: [String: AnyObject] = ["userData": userData as AnyObject]
        
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
                    
                    if statusCode == 202 {
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
