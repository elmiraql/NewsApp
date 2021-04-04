//
//  NewsTableViewController.swift
//  HackerNews
//
//  Created by Elmira on 04.04.21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news: [News] = []
    let netWorkViewController = NetWorkViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        netWorkViewController.delegate = self
        netWorkViewController.fetchData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(news[indexPath.row].points) \(news[indexPath.row].title)"
        cell.textLabel?.font = UIFont(name: "Courier", size: 20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToWeb", sender: self)
    }
  
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWeb" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as? WebViewController
                destinationVC?.url = news[indexPath.row].url ?? ""
            }
        }
    }
}

extension NewsTableViewController: NetWorkViewControllerDelegate {
    func didFetchdata(_ netWorkViewController: NetWorkViewController, data: NewsModel) {
        DispatchQueue.main.async {
            self.news = data.hits
            self.tableView.reloadData()
        }
    }
}
