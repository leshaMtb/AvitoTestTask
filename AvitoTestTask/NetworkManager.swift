//
//  ViewModel.swift
//  AvitoTestTask
//
//  Created by Apple on 03.09.2021.
//

import Foundation

protocol NetworkOutput {
    func getJson()
    var welcome: Welcome? { get set }
    var reload: () -> ()  { get set }
    var errorMessage: (_ message : String) -> ()  { get set }
}

class NetworkManager: NetworkOutput {

    var reload = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    let session = URLSession.shared
    var welcome: Welcome? {
        //update UI when data set
        didSet {
            reload()
        }
    }
    //for save date of request
    var dateOfGetJsonSince1970: Double? {
        get {
            return UserDefaults.standard.double(forKey: "123")
        }
        set {
            let defaults = UserDefaults.standard
            if let new = newValue {
                defaults.set(new, forKey: "123")
            } else {
                defaults.removeObject(forKey: "123")
            }
        }
    }

    func getJson() {

        guard  let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            return
        }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        //if the request was more than an hour ago, then clear the cache
        if NSDate().timeIntervalSince1970 - dateOfGetJsonSince1970! > 3600 {
            session.configuration.urlCache?.removeAllCachedResponses()
        }

        if let cacheResponse = session.configuration.urlCache?.cachedResponse(for: request) {
            do {
                self.welcome = try JSONDecoder().decode(Welcome.self, from: cacheResponse.data)
                print("from cache")
                return
            } catch {
                print(error)
                return
            }
        } else {
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard error == nil else {
                    self?.errorMessage(error.debugDescription)
                    return }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self?.welcome = try decoder.decode(Welcome.self, from: data)
                    self?.dateOfGetJsonSince1970 = NSDate().timeIntervalSince1970
                    print("from server")
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

