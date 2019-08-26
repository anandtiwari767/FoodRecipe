//
//  ViewController.swift
//  Tableview
//
//  Created by CTS-MACMINI-1 on 22/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct food : Codable{
    var count:Int?
    var recipes:[Recipes]?
}

struct Recipes :Codable{
    var publisher:String?
    var f2f_url:String?
    var title:String?
    var source_url:String?
    var recipe_id:String?
    var image_url:String?
    var social_rank:Int?
    var publisher_url:String?
}


class ViewController: UIViewController {
  
    @IBOutlet var searchBar: UISearchBar!
    var list=food()
    var til = [String]()
    var rid=[String]()
    var images=[String]()
    var i=0
    var searchArr : [String]=[]
    var searching = false
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func callApi(){
        Alamofire.request("https://www.food2fork.com/api/search?key=bb1d78b48fce5718c685f987841034be", method: .get ).responseJSON{
            response in
            if response.result.isSuccess{
                let data:JSON = JSON(response.result.value!)
                let temp = data["count"].int
                while(self.i < temp!){
                    
                    self.til.append(data["recipes"][self.i]["title"].string!)
                    self.images.append(data["recipes"][self.i]["image_url"].string!)
                    self.rid.append(data["recipes"][self.i]["recipe_id"].string!)
                    
                    self.i+=1
                }
               
                DispatchQueue.main.async {
                                            self.tableview.reloadData()
                                        }
                
                
            }else {
                print("we are having some problem")
            }
        }
    }
    
    
    
    
    //API call with out cocoa pods
    
//    func callApi(){
//        let url = URL(string: "https://www.food2fork.com/api/search?key=bb1d78b48fce5718c685f987841034be")!
//        var request=URLRequest(url: url)
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//        session.dataTask(with: request){(data,response,error) in
//            if let data = data {
//                do{
//                    let json = try? JSONDecoder().decode(food.self, from: data)
//
//                    while(self.i<(json?.count)!){
//
//                       self.til.append((json?.recipes![self.i].title)!)
//                        self.images.append((json?.recipes![self.i].image_url)!)
//                        self.rid.append((json?.recipes![self.i].recipe_id)!)
//
////                        print(self.til)
//                        self.i+=1
//                    }
//
//                    DispatchQueue.main.async {
//                        self.tableview.reloadData()
//                    }
//                }
//                }
//}.resume()
//    }
    
}

    extension ViewController :UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if(searching){
            return searchArr.count
        }
        else{
        return til.count
        }}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor=UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        if (searching){
        cell?.lbl.text=searchArr[indexPath.section]
        }else{
//            print("In the else block")
        cell?.lbl.text=til[indexPath.section]
//            print(til)
   
        if let imageUrl = URL(string: images[indexPath.section]){
           
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageUrl)
                
                
                    let imag = UIImage(data: data!)
                   
                    DispatchQueue.main.async {
                        
                    cell?.img.image=imag
                    }
            }
            }}
           
//        cell?.img.image=UIImage(named: cards[indexPath.section] )
        
        return cell!
        
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc=storyboard?.instantiateViewController(withIdentifier: "secondStory" ) as?SecomdViewController
        
//        vc?.image = UIImage(named: cards[indexPath.section] )!
       
        
        vc?.name = til[indexPath.section]
        
        if let imageUrl = URL(string: images[indexPath.section]){
            
          
                
                let data = try? Data(contentsOf: imageUrl)
                
                
                let imag = UIImage(data: data!)
//                print(indexPath.section)
            
                    
                    vc?.image=imag!
            
            }
        vc?.ridi=rid[indexPath.section]
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationItem.title = "recipes"
      
    }
}
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArr = til.filter({$0.prefix(searchText.count) == searchText});
        print("this is serach array")
        searching = true
      tableview.reloadData()
    }
}










