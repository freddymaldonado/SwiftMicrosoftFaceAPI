//
//  Created by Freddy Maldonado on 8/20/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

struct ApplicationConstants {
    
    // Graph information
    static let clientId = "ENTER_CLIENT_ID"
    static let scopes   = ["User.ReadBasic.All",
                           "offline_access"]
    
    // Cognitive services information
    static let ocpApimSubscriptionKey = ""
    
    //API Location
    static let location = "westcentralus"
}


enum ErrorApi: Swift.Error {
    case UnexpectedError(nsError: NSError?)
    case ServiceError(json: [String: AnyObject])
    case JSonSerializationError
}

typealias JSON = AnyObject
typealias JSONDictionary = [String: JSON]
typealias JSONArray = [JSON]

