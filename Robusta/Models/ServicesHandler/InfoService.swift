//
//  InfoService.swift
//  Robusta
//
//  Created by gamal on 12/19/20.
//

import Foundation
class InfoService {
    typealias responseHandler = (_ repoName : [String] , _ ownerName : [String] , _ avatarImg : [String] , _ datesList : [String])->Void
    typealias  createdDateHandler = (_ datesList : [String])->Void
    class func getInfo(Completion :@escaping responseHandler){
        let url = URL(string: "https://api.github.com/repositories")!
        var namesList : [String] = []
        var repoList : [String] = []
        var urlsList : [String] = []
        var createdDate : [String] = []
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                if let arr = json as? [[String: Any]] {
                    for name in arr {
                        let owener = name["owner"] as! NSDictionary
                        var oName = owener["login"] as! String
                        namesList.append(oName)
                        repoList.append(name["name"] as! String)
                        urlsList.append(owener["avatar_url"] as! String)
                    }
                    getCreatedDate(completion: {dates in
                        createdDate = dates
                        Completion(repoList, namesList, urlsList, createdDate)
                    })
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    class func getCreatedDate(completion :@escaping createdDateHandler){
        let url = URL(string: "https://api.github.com/users/mojombo/received_events")
        var dates = [String]()
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                //print("json is \(json)")
                if let arr = json as? [[String: Any]] {
                    for date in arr {
                        dates.append(date["created_at"] as! String)
                    }
                    completion(dates)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
