//
//  NowPlayingViewController.swift
//  FlixTPM
//
//  Created by Pranaya Adhikari on 7/24/18.
//  Copyright © 2018 Pranaya Adhikari. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
    
    var movies:[Movie] = []
   
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        activityIndicator.startAnimating()
        fetchNowPlayingMovies()
        
        
        // Do any additional setup after loading the view.
    }
    
    func fetchNowPlayingMovies(){
        // Start the activity indicator
        self.activityIndicator.startAnimating()

//        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            // This will run when the network request returns
//            if let error = error {
//                print(error.localizedDescription)
//                // create an OK action
//                self.showAlert()
//                self.refreshControl.endRefreshing()
//                self.activityIndicator.stopAnimating()
//                self.fetchNowPlayingMovies()
//                    // optional code for what happens after the alert controller has finished presenting
//
//            } else if let data = data {
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let movies = dataDictionary["results"] as! [[String:Any]]
//                self.movies = movies
//                self.tableView.reloadData()
//                self.refreshControl.endRefreshing()
//                // Start the activity indicator
//                self.activityIndicator.stopAnimating()
//            }
//        }
//        task.resume()
        MovieApiManager().popularMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl){
        fetchNowPlayingMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
//        let movie = movies[indexPath.row]
//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//
//
//        let placeholderImage = UIImage(named: "placeholder")!
//
//        let posterPathString = movie["poster_path"] as! String
//        let baseURLString = "https://image.tmdb.org/t/p/w500"
//        let posterURL = URL(string: baseURLString+posterPathString)!
//
//
//        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
//            size: cell.posterImageView.frame.size,
//            radius: 20.0
//        )
//
//        cell.posterImageView.af_setImage(
//            withURL: posterURL,
//            placeholderImage: placeholderImage,
//            filter: filter,
//            imageTransition: .crossDissolve(0.2)
//        )
//        // No color when the user selects cell
//        //cell.selectionStyle = .none
//
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.lightGray
//        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Can not Get Movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }

    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies[(indexPath?.row)!]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
    }
 

}
