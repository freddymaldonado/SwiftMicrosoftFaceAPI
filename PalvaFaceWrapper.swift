//
//  Created by Freddy Maldonado on 8/20/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

class PFaceWrapper: NSObject {
    
    let faceApi = Face()
    let largePersonGroupApi = LargePersonGroup()
    let largePersonGroupPersonApi = LargePersonGroupPerson()
    
    struct Result {
        let image: UIImage
        let otherInformation: String
    }
    
    struct FaceData {
        let faceId: String
        let height: Int
        let width: Int
        let top: Int
        let left: Int
    }
    
    struct Candidate{
        let personId: String
        let confidence: Double
    }
    
    struct IdentifyData {
        let faceId: String
        let candidates: [Candidate]
    }
    
    //Face Identify
    public func identify(faceIds: [String], maxNumOfCandidatesReturned: Int, confidenceThreshold: Double, completion: @escaping (_ created: [IdentifyData]) -> Void) {
        let groupId = largePersonGroupApi.getCurrentGroupId()
        
        faceApi.identify(faceIds: faceIds, largePersonGroupId: groupId, maxNumOfCandidatesReturned: maxNumOfCandidatesReturned, confidenceThreshold: confidenceThreshold) { (result) in
            switch result {
            case .Success(let json):
                var identifyResponse = [IdentifyData]()
                let identifiedFaces = json as! JSONArray
                for item in identifiedFaces {
                    var candidateGroup = [Candidate]()
                    let identifyData = item as! JSONDictionary
                    let faceId = identifyData["faceId"] as! String
                    let identifiedCandidates = identifyData["candidates"] as! JSONArray
                    for candidates in identifiedCandidates{
                        let candidateJson = candidates as! JSONDictionary
                        let personId = candidateJson["personId"] as! String
                        let confidence = candidateJson["confidence"] as! Double
                        let candidate = Candidate(personId: personId, confidence: confidence)
                        candidateGroup.append(candidate)
                    }
                    let identifiedData = IdentifyData(faceId: faceId, candidates: candidateGroup)
                    identifyResponse.append(identifiedData)
                }
                completion(identifyResponse)
                break
            case .Failure(let error):
                print("DetectFaces error - ", error!)
                break
            }
        }
    }
    
    //Face Detect
      public func detectFaces(photo: UIImage, completion: @escaping (_ faces: [FaceData]) -> Void) {
        faceApi.detect(face: photo) { (result) in
            switch result {
            case .Success(let json):
                var faces = [FaceData]()
                let detectedFaces = json as! JSONArray
                for item in detectedFaces {
                    let face = item as! JSONDictionary
                    let faceId = face["faceId"] as! String
                    let rectangle = face["faceRectangle"] as! [String: AnyObject]
                    let detectedFace = FaceData(faceId: faceId,
                                            height: rectangle["top"] as! Int,
                                            width: rectangle["width"] as! Int,
                                            top: rectangle["top"] as! Int,
                                            left: rectangle["left"] as! Int)
                    faces.append(detectedFace)
                }
                completion(faces)
                break
            case .Failure(let error):
                print("DetectFaces error - ", error!)
                break
            }
        }
    }
    
    //LargePersonGroup Create
      public func createLargePersonGroup(name: String, completion: @escaping (_ created: Bool) -> Void) {
        
        let groupId = largePersonGroupApi.getCurrentGroupId()
        print("LARGE PERSON GROUP ID: ")
        print(groupId)
        largePersonGroupApi.create(name: name, largePersonGroupId: groupId) { (result) in
            switch result {
            case .Success(let json):
                let jsonResponse = json as! JSONArray
                for item in jsonResponse {
                    print(item)
                }
                completion(true)
            break
            case .Failure(let error):
                print("createLargePersonGroup error - ", error!)
                completion(false)
            }
        }
      }
    
    //LargePersonGroupPerson Create
    public func createLargePersonGroupPerson(personName: String, completion: @escaping (_ personId: String) -> Void) {
        
        let groupId = largePersonGroupApi.getCurrentGroupId()
        
        largePersonGroupPersonApi.create(name: personName, largePersonGroupId: groupId) { (result) in
            switch result {
            case .Success(let json):
                let jsonResponse = json as! JSONDictionary
                let personId = jsonResponse["personId"] as! String
                completion(personId)
                break
            case .Failure(let error):
                print("createLargePersonGroupPerson error - ", error!)
            }
        }
    }
    
    //LargePersonGroupPerson Add Face
    public func addfaceToLargePersonGroupPerson(face: UIImage, personName: String, personId: String, completion: @escaping (_ created: String) -> Void) {
        
        let groupId = largePersonGroupApi.getCurrentGroupId()
        
        largePersonGroupPersonApi.addFace(face: face, largePersonGroupId: groupId, personId: personId) { (result) in
            switch result {
            case .Success(let json):
                let jsonResponse = json as! JSONDictionary
                let persistedFaceId = jsonResponse["persistedFaceId"] as! String
                print(persistedFaceId)
                completion(persistedFaceId)
                break
            case .Failure(let error):
                print("createLargePersonGroupPerson error - ", error!)
            }
        }
    }
    
    //LargePersonGroup Train
    public func LargePersonGroupTrain(completion: @escaping (_ created: Bool) -> Void) {
        let groupId = largePersonGroupApi.getCurrentGroupId()
        
        largePersonGroupApi.train(largePersonGroupId: groupId) { (result) in
            switch result {
            case .Success(let json):
                let jsonResponse = json as! JSONDictionary
                print(jsonResponse)
                completion(true)
                break
            case .Failure(let error):
                print("createLargePersonGroupPerson error - ", error!)
                completion(false)
            }
        }
    }
}
