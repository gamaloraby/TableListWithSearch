//
//  ViewController.swift
//  Robusta
//
//  Created by gamal on 12/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var InfoList: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var repoNames : [String] = [""]
    var FiltredItems : [String] = [""]
    var owner : [String] = [""]
    var avatarUrl : [String] = [""]
    var createdDate : [String] = [""]
    var data :Data?
    var dataList = [Data]()
    
    var index =  0
    override func viewDidLoad() {
        super.viewDidLoad()
        InfoList.dataSource = self
        InfoList.delegate = self
        SearchBar.delegate = self
        InfoList.rowHeight = UITableView.automaticDimension
        InfoList.estimatedRowHeight = 60
        let CellNib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        InfoList.register(CellNib, forCellReuseIdentifier: "InfoCell")
        InfoService.getInfo(Completion: { [self]list,names,urls,dates   in
            repoNames = list
            FiltredItems = repoNames
            owner = names
            avatarUrl = urls
            createdDate = dates
            DispatchQueue.main.async {
                do {
                    for (index , _) in avatarUrl.enumerated(){
                        let url = URL(string: avatarUrl[index])
                         data = try Data(contentsOf: url!)
                        dataList.append(data!)
                    }
                    loader.isHidden = true
                    InfoList.reloadData()
                }
                catch{
                    print(error)
                }
              
            }
        })
    }
}
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiltredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TableCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoTableViewCell
        TableCell.RepoName.text = FiltredItems[indexPath.row]
        TableCell.CreationDate.text = createdDate[indexPath.row]
        TableCell.OwnerName.text = owner[indexPath.row]
        if dataList.count > 0 {
            TableCell.OwnerImg.image = UIImage(data:dataList[indexPath.row])
        }
       
        return TableCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "detailes", sender: nil)
        print("selected index is \(indexPath.row)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailesController
        {
            let vc = segue.destination as? DetailesController
            vc?.data = dataList[index]
            vc?.owner = owner[index]
            vc?.repoName = FiltredItems[index]
        }
    }
}
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            FiltredItems = searchText.isEmpty ? repoNames : repoNames.filter({(dataString: String) -> Bool in
                    return dataString.range(of: searchText, options: .caseInsensitive) != nil
                })
        }else if searchText.count == 1 {
            FiltredItems = repoNames
        }
        InfoList.reloadData()
    }
}
