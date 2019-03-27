//
//  Face.swift
//
//  Created by Freddy Maldonado on 8/20/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//


import UIKit


class LargePersonGroup: NSObject {
    
    func getCurrentGroupId() -> String{
        //Must be dynamic in production
        return "group1idreuhj0fxoslzy762wtwtlyoj5cun57a4qpzwjzc3"
    }
    
    let urlGen = LargePersonGroupURL()
    
    // Create
    func create(name: String, largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.createUrl(largePersonGroupId: largePersonGroupId)
        print("URL STR:")
        print(url)
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        print("PASO?")
        
        request.httpMethod = "PUT"
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
                print("STATUS CODE")
                print(statusCode)
                if statusCode == 200 {
                    completion(FaceAPIResult.Success((json as JSON)))
                }
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String: AnyObject]
                    
                    if statusCode == 200 {
                        completion(FaceAPIResult.Success((json as JSON)))
                    }else {
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
    func delete(largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.deleteUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
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
    func get(largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.getUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
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
    
    // Get Training Status
    func getTrainingStatus(largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.getTrainingStatusUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
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
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
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
    
    // Train
    func train(largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.trainUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        
        request.httpMethod = "POST"
        request.setValue(ApplicationConstants.ocpApimSubscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print("TRAIN STATUS CODE")
            print(statusCode)
            if(statusCode == 202){
                print("Trained Succes")
            }
            if let nsError = error {
                completion(.Failure(ErrorApi.UnexpectedError(nsError: nsError as NSError as NSError)))
            }
            else {
                
                do {
                    
                    let json =  try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String: AnyObject]
                    
                    print("TRAIN STATUS CODE")
                    print(statusCode)
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
    
    // Update
    func update(name: String, largePersonGroupId: String, completion: @escaping (_ result: FaceAPIResult<JSON, ErrorApi>) -> Void) {
        
        let url = urlGen.updateUrl(largePersonGroupId: largePersonGroupId)
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
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
    
    
    
    //Helpers
    
    func generateGroupName(number: String) -> String {
        return "palvagroup" + number + "id"
    }
    
    func generateLargePersonGroupId(groupName: String) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 40 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        let groupIdGen: String = groupName + randomString
        
        return groupIdGen
        
    }
    
    func LargePersonGroupId(withNumberIdentifier: String) -> String {
        let groupName = generateGroupName(number: withNumberIdentifier)
        let groupId = generateLargePersonGroupId(groupName: groupName)
        storeGroupId(id: groupId)
        return groupId
    }
    
    func storeGroupId(id: String){
        UserDefaults.standard.set(id, forKey: "currentGroupId")
    }
    
    func retrieveGroupId() -> String!{
        if UserDefaults.standard.string(forKey: "currentGroupId") != nil{
            return UserDefaults.standard.string(forKey: "currentGroupId")!
        }else{
            return nil
        }
    }
    
   
}
