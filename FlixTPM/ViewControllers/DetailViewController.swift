//
//  DetailViewController.swift
//  FlixTPM
//
//  Created by Pranaya Adhikari on 7/30/18.
//  Copyright © 2018 Pranaya Adhikari. All rights reserved.
//

import UIKit
import AlamofireImage


class DetailViewController: UIViewController {
    var movie:[String:Any]?
    var trailerKey:String?
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTrailer()
        
        if let movie = movie{
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURLString+backdropPathString)!
            backdropImageView.af_setImage(withURL:backdropURL)
            
            let posterPathURL = URL(string: baseURLString+posterPathString)!
            posterImageView.af_setImage(withURL:posterPathURL)
            

            
        }
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPosterImage(_:)))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        //tapGestureRecognizer.numberOfTapsRequired = 1
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        posterImageView.isUserInteractionEnabled = true
        
        //posterImageView.addGestureRecognizer(tapGestureRecognizer)
        
        

        // Do any additional setup after loading the view.
    }
    
    func fetchTrailer(){
        // Start the activity indicator
        if let movie = movie{
            let movieId = movie["id"] as! Int
            let baseTrailerUrl = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=f72e93d33e6f6d3be2c2a88feb31613a&language=en-US"
            let url = URL(string: baseTrailerUrl)!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                    // create an OK action
                    //self.showAlert()
                    //self.refreshControl.endRefreshing()
                    //self.activityIndicator.stopAnimating()
                    // optional code for what happens after the alert controller has finished presenting
                    
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let moviesTrailer = dataDictionary["results"] as! [[String:Any]]
                    print(moviesTrailer)
                    let videoTrailerKey = moviesTrailer[0]["key"] as! String
                    self.trailerKey = videoTrailerKey
                }
            }
            task.resume()
            
        }
     
    }
    
    

    @IBAction func didTapPosterImage(_ sender: Any) {
        //let location = sender.location(in: view)
        print("Tapped")
        self.performSegue(withIdentifier: "videoSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

       let videoViewController = segue.destination as! VideoViewController
       videoViewController.trailerKeyForVideo = trailerKey
    
    }
    

}
