//
//  NetworkUtility.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation
import Alamofire

class NetworkUtility {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
