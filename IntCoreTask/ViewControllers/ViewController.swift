//
//  ViewController.swift
//  IntCoreTask
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var overView: UIButton!
    @IBOutlet weak var discussionView: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var mainPic: UIImageView!
    var images:[String] = ["1.jpg","2.jpg","3.png","4.jpeg","5.jpg"]
    var movies=[Movie]()
    let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        let requestManager = AlamoFireManager()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        mainPic.layer.cornerRadius = 15
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 25
        
//        overView.applyGradient(locations: nil)
        discussionView.applyGradient(locations: nil)
        overView.widthAnchor.constraint(equalToConstant: screenWidth/2 - 50).isActive = true
        discussionView.widthAnchor.constraint(equalToConstant: screenWidth/2 - 50).isActive = true
        overView.layer.cornerRadius = 17
        overView.layer.masksToBounds = true
        discussionView.layer.cornerRadius = 17
        discussionView.layer.masksToBounds = true
        
        
        
        if movies.count==0
        {
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success( _):
                    do {let json = try? JSON(data: response.data!)
//                        print(json)
                        if let Arr = json!["results"].arrayObject{
                            let allMovies = Arr as! [[String : AnyObject]]
//                            for object in allMovies{
                            let movie = Movie()
                                movie.name = allMovies[1]["original_title"] as? String
                                let img = allMovies[1]["poster_path"] as? String
                                movie.image = "https://image.tmdb.org/t/p/w342" + img!
                                movie.overView = allMovies[1]["overview"] as? String
                                movie.date = allMovies[1]["release_date"]as? String
                            self.movies.append(movie)
//                        }
                        }
                        for movie in self.movies{
                        print(movie.name!)
                        print(movie.image!)
                        }
                        self.movieImage.sd_setImage(with: URL(string:self.movies[0].image!), placeholderImage: UIImage(named: "placeholder.png"))
                        self.movieName.text = self.movies[0].name
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    

    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellTableViewCell
        
        cell.postImage.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func overviewAction(_ sender: Any) {
    }
    
    @IBAction func discussionAction(_ sender: Any) {
    }
    
    

}

