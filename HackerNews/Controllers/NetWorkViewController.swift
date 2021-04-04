//
//  NetWorkViewController.swift
//  HackerNews
//
//  Created by Elmira on 04.04.21.
//

import UIKit

protocol NetWorkViewControllerDelegate {
    func didFetchdata(_ netWorkViewController: NetWorkViewController, data: NewsModel)
}


class NetWorkViewController: UIViewController {
    
    var delegate: NetWorkViewControllerDelegate?
    
    let baseUrl = "http://hn.algolia.com/api/v1/search?tags=front_page"
    
    func fetchData()  {
        if let url = URL(string: baseUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(NewsModel.self, from: safeData)
                        self.delegate?.didFetchdata(self, data: decodedData)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
