//
//  ViewController.swift
//  TestCollectionView
//
//  Created by なぐも on 2022/05/23.
//

import UIKit

struct Qiita:Codable{
    let title:String
    let createdAt:String
    let user: User
    
    enum CodingKeys:String, CodingKey{
        case title = "title"
        case createdAt = "created_at"
        case user = "user"
    }
}

struct User:Codable{
    let name:String
    let profileImageUrl:String
    
    enum CodingKeys:String, CodingKey{
        case name = "name"
        case profileImageUrl = "profile_image_url"
    }
}

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    
    let tableView:UITableView = {
        let tv = UITableView()
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame.size = view.frame.size
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        getQiitaAPI()
    }
    
    
    private func getQiitaAPI(){
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=5")else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url){(data, respose, err) in
            if let err = err{
                print("情報の取得に失敗しました。 :", err)
                return
            }
            if let data = data{
                do{
//                    let json = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let qiita = try JSONDecoder().decode([Qiita].self, from: data)
                    print("json: ", qiita)
                }catch(let err){
                    print("情報の取得に失敗しました。:", err)
                }
            }
        }
        
        task.resume()
    }
        
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

class QiitaTableViewCell: UITableViewCell {
    
    var qiita: Qiita? {
        didSet {
            bodyTextLabel.text = qiita?.title
            let url = URL(string: qiita?.user.profileImageUrl ?? "")
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                userImageView.image = image
            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
    }
    
    let userImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let bodyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "something in here"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

}





