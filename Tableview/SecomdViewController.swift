//
//  SecomdViewController.swift
//  Tableview
//
//  Created by CTS-MACMINI-1 on 22/08/19.
//  Copyright © 2019 Cogitate Technology Solutions. All rights reserved.
//

import UIKit
struct obj: Codable{
    var recipe:data
}
struct data :  Codable{
    var publisher:String?
    var f2f_url:String?
    var ingredients:[String]=[]
    var source_url:String?
    var recipe_id:String?
    var image_url:String?
    var social_rank:Float?
    var publisher_url:String?
    var title:String?
}


class SecomdViewController: UIViewController {
    var igri:[String]=[]
    var socialRank=0.0
    var publisher = ""
    @IBOutlet var rid: UILabel!
    @IBOutlet var largelbl: UILabel!
    @IBOutlet var largeimg: UIImageView!
    var ridi = ""
    var name=""
    var image = UIImage()
    var i=0
    
    @IBOutlet var lableLeft: UILabel!
    @IBOutlet var lableRight: UILabel!
    
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callSApi()
       
        largeimg.image = image
        for i in igri{
            largelbl.text=i
        }
       
        self.title = name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callSApi(){
        let url = URL(string : "https://www.food2fork.com/api/get?key=bb1d78b48fce5718c685f987841034be&rId=\(String(ridi))")
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error)
            in
          
            if let data = data{
                do {
                    
                    let json = try? JSONDecoder().decode(obj.self, from: data)
                    print("anand anand")
                   self.publisher=(json?.recipe.publisher)!
                    self.socialRank=Double((json?.recipe.social_rank)!)
                    print((json?.recipe.ingredients.count)!)
                   
                        while(self.i < ((json?.recipe.ingredients.count)!)){
                        self.igri.append((json?.recipe.ingredients[self.i])!)
                        self.i+=1
                        
                     
                        
                        
                    }
                    DispatchQueue.main.async{
                          self.tableview.reloadData()
                        
                        }}
//                    print(self.igri)
                
                
            
            }}.resume()
}}

extension SecomdViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return igri.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? SecondTableViewCell
        cell2?.lable.text=igri[indexPath.section]
   lableLeft.text = publisher
        lableRight.text = String(socialRank)
  return cell2!
    }
    
}






















