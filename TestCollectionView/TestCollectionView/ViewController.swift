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
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 120, height: 120)
//        collectionViewFlowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 3)
        
        let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 170, height: 170)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            collectionView.collectionViewLayout = layout
        
        getQiitaAPI()
    }
    
    private func getQiitaAPI(){
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20")else {return}
        
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



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 12

        return cell
    }
}

