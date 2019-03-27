//
//  FaceURL.swift
//
//  Created by Freddy Maldonado on 8/20/18.
//  Copyright © 2018 Freddy Maldonado Pereyra. All rights reserved.
//

import Foundation

import Foundation

class FaceURL: NSObject {
    
    //Create
    public func detectReturningFaceIdOnly() -> String {
        return "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false"
    }
    
    //Identify
    public func identifyUrl() -> String {
        return "https://\(ApplicationConstants.location).api.cognitive.microsoft.com/face/v1.0/identify"
    }
    
}
