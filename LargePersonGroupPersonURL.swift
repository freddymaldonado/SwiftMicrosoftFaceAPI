//
//  LargePersonGroupPersonURL.swift
//
//  Created by Freddy Maldonado on 8/19/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//

import Foundation

class LargePersonGroupPersonURL: NSObject {
    
    //Add Face With Target
    public func addFaceWithTargetUrl(largePersonGroupId: String, personId: String, userData: String, targetFace: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)/persistedfaces[?userData=\(userData)][&targetFace=\(targetFace)]"
    }
    
    //Add Face
    public func addFaceUrl(largePersonGroupId: String, personId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)/persistedfaces"
    }
    
    //Create
    func createUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons"
    }
    
    //Delete
    func deleteUrl(largePersonGroupId: String, personId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)"
    }
    
    //Delete Face
    func deleteFaceUrl(largePersonGroupId: String, personId: String, persistedFaceId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)/persistedfaces/\(persistedFaceId)"
    }
    
    //Get
    public func getUrl(largePersonGroupId: String, personId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)"
    }
    
    //Get Face
    public func getFaceUrl(largePersonGroupId: String, personId: String, persistedFaceId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)/persistedfaces/\(persistedFaceId)"
    }
    
    //List
    func listUrl(largePersonGroupId: String, start: String, top: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons[?start=\(start)][&top=\(top)]"
    }
    
    //Update
    public func updateUrl(largePersonGroupId: String, personId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)"
    }
    
    //Update Face
    public func updateFaceUrl(largePersonGroupId: String, personId: String, persistedFaceId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/persons/\(personId)/persistedfaces/\(persistedFaceId)"
    }
    
   
}
