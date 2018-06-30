//
//  CustomCellTableViewCell.swift
//  IntCoreTask
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CustomCellTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    var flag:Bool = true
    @IBOutlet weak var likeAction: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var subTable: UITableView!
    @IBOutlet weak var heartClicked: UIButton!
    
    let url = "https://jsonplaceholder.typicode.com/comments"
    var comments = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
       subTable.delegate=self
        subTable.dataSource=self
        
        if comments.count==0
        {
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success( _):
                    do {let json = try? JSON(data: response.data!)
                        print(json!)
                        do {let json = try? JSON(data: response.data!)
                            for object in (json?.arrayValue)!{
                                var comm = String()
                                comm = object["body"].stringValue
                                self.comments.append(comm)
                                if self.comments.count>5{
                                    break
                                }
                            }
                    }
                        
                }
                    DispatchQueue.main.async {
                        self.subTable.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomSubCell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath) as! CustomSubCell
        if comments.count>=5 {
        cell.comment.text = self.comments[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func heartAction(_ sender: Any) {
        plusLike()
    }
    
    @IBAction func likesClicked(_ sender: Any) {
        plusLike()
    }
    
    func plusLike(){
        
        if(flag){
        self.likeAction.setTitle("3 Likes", for: .normal)
        heartClicked.setImage(UIImage(named: "like.PNG"), for: .normal)
            flag = false
        }else{
            self.likeAction.setTitle("2 Likes", for: .normal)
            heartClicked.setImage(UIImage(named: "like-outline.png"), for: .normal)
            flag = true
        }
    }
}
