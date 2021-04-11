//
//  NetWorkViewController.swift
//  HackerNews
//
//  Created by Elmira on 04.04.21.
//

import UIKit

protocol NetWorkViewControllerDelegate {
    func didFetchdata(_ netWorkViewController: NetWorkViewController, data: [News])
}


class NetWorkViewController: UIViewController {
    
    var delegate: NetWorkViewControllerDelegate?
    
    let urls: [String] = [
        "https://hn.algolia.com/api/v1/search?tags=front_page&page=0",
        "https://hn.algolia.com/api/v1/search?tags=front_page&page=1"
    ]
    var news: [News] = []
        
    func fetchData()  {
        for link in urls {
            if let url = URL(string: link) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        return
                    }
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedData = try decoder.decode(NewsModel.self, from: safeData)
                            for el in decodedData.hits {
                                self.news.append(el)
                            }
                            self.delegate?.didFetchdata(self, data: self.news)
                        } catch {
                            print(error)
                        }
                    }
                }
                task.resume()
            }
        }
       
    }
}
