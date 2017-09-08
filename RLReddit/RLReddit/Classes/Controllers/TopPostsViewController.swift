//
//  ViewController.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/14/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class TopPostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static let estimatedRowHeight = 100

    fileprivate var listing: PostsListing = PostsListing(entities:[Post](), before:"", after:"")
    private lazy var postsCountToLoad: Int = {
        return Int(self.tableView!.frame.height / 100) * 2; // multiplying posts fitted in page by 2, to preload them
        }()
    private var isLoadingInProgress: Bool = false {
        didSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoadingInProgress
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TopPostsViewController.reloadPosts(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CGFloat(TopPostsViewController.estimatedRowHeight)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if listing.entities.isEmpty {
            loadMorePosts()
        }
    }
    
    func reloadPosts(_ refreshControl: UIRefreshControl) {
        loadMorePosts(reloadList: true, completion: {refreshControl.endRefreshing()});
    }

    fileprivate func loadMorePosts(reloadList: Bool = false, completion: @escaping() -> Void = {}) {
        guard !isLoadingInProgress else {
            return;
        }
        
        isLoadingInProgress = true
        let after = reloadList ? "" : listing.after
        let request = TopPostsRequest(after: after, count: postsCountToLoad, limit: postsCountToLoad)
        RequestManager.sharedInstance.sendRequest(request: request, completionHandler: {[weak self] loadedListing, error in
            if (reloadList)
            {
                self?.listing = PostsListing(entities:[Post](), before:"", after:"")
            }

            if let loadedListing = loadedListing as? PostsListing,
               let listing = self?.listing
            {
                self?.listing = listing + loadedListing
                self?.tableView.reloadData()
                self?.isLoadingInProgress = false
                completion();
            }
        });
    }

}

extension TopPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listing.entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopPostTableViewCell", for: indexPath) as! TopPostTableViewCell
        cell.post = listing.entities[indexPath.row]
        return cell
    }
}

extension TopPostsViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(listing, forKey: "listing")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let listing = coder.decodeObject(forKey: "listing") as? PostsListing {
            self.listing = listing
        }
        super.decodeRestorableState(with: coder)
    }
}

