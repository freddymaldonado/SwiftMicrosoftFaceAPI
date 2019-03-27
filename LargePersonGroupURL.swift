//
//  LargePersonGroupURL.swift
//
//  Created by Freddy Maldonado on 8/19/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//

import Foundation

class LargePersonGroupURL: NSObject {
    
    //Create
    public func createUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)"
    }
    
    //Delete
    func deleteUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)"
    }
    
    //Get
    func getUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)"
    }
    
    //Get Training Status
    func getTrainingStatusUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)"
    }
    
    //List
    func listUrl(largePersonGroupId: String, start: String, top: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups[?start=\(start)][&top=\(top)]"
    }
    
    //Train
    func trainUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)/train"
    }
    
    //Update
    func updateUrl(largePersonGroupId: String) -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/largepersongroups/\(largePersonGroupId)"
    }
}
