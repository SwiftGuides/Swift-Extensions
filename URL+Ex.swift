//
//  URL+Ex.swift
//
//  Created by Augus on 12/17/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

let EMPTY_URL = URL(string: "https://")!

extension URL {

    func httpsURL() -> URL {

        guard scheme != "https" else {
            return self
        }

        let str = absoluteString.replacingOccurrences(of: "http://", with: "https://")

        return URL(string: str)!
    }
}

extension String {

    func toURL(forceToHttps: Bool = false) -> URL? {
        if forceToHttps {
            return URL(string: self)?.httpsURL()
        } else {
            return URL(string: self)
        }
    }

    func toNoneNilURL(forceToHttps: Bool = false) -> URL {
        return toURL(forceToHttps: forceToHttps) ?? URL(string: "https://")!
    }

    func httpsURL() -> URL? {

        guard let url = URL(string: self) else { return nil }
        
        return url.httpsURL()
    }
}

extension URL {

    var queryPairs: [String : String] {
        var results = [String: String]()
        let pairs = self.query?.components(separatedBy: "&") ?? []

        for pair in pairs {
            let kv = pair.components(separatedBy: "=")
            if kv.count > 1 {
                results.updateValue(kv[1], forKey: kv[0])
            }
        }
        return results
    }
}

extension URL {
    
    func append(_ queryItem: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string:  absoluteString) else { return absoluteURL }
        
        // create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // create query item if value is not nil
        guard let value = value else { return absoluteURL }
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        // append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // append updated query items array in the url component object
        urlComponents.queryItems = queryItems// queryItems?.append(item)
        
        // returns the url from new url components
        return urlComponents.url!
    }
    
    func append(_ params: [String: String?]) -> URL {
        var url = self
        params.forEach() {
            url = url.append($0.key, value: $0.value)
        }
        return url
    }
}

extension URL {

    var lastPathComponentWithoutPathExtension: String {
        let ex = pathExtension
        return lastPathComponent.replacingOccurrences(of: ".\(ex)", with: "")
    }
}
