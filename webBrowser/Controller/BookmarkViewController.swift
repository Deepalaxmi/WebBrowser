//
//  BookmarkViewController.swift
//  webBrowser
//
//  Created by Khangembam Deepalaxmi Devi on 13/11/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//
// Screen 2: All Bookmarks
import UIKit

//Protocol to communicate back from All bookmark screen 2 to web browser screen 1
protocol BookmarkViewControllerDelegate: AnyObject {
    func didSelect(selectedWebpage: WebPage)
}

class BookmarkViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var bookmarkDataSourceArray: [WebPage] = []
    
    weak var delegate: BookmarkViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetUp()
    }
    
    func initialSetUp(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName:"BookmarkTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "BookmarkTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.title = "All Bookmarks"
    }

}

extension BookmarkViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkDataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell {
            cell.mainLabel.text = bookmarkDataSourceArray[indexPath.row].title
            return cell
        }
        return UITableViewCell()
    }
    
}

extension BookmarkViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(selectedWebpage: bookmarkDataSourceArray[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
