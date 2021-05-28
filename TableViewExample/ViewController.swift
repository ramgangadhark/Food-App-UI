//
//  ViewController.swift
//  TableViewExample
//
//  Created by Ram on 12/02/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var searchBar1: UISearchBar!
    var data = [dishData]()
    var searching = false
    var searchedDish = [dishData]()
    let searchController = UISearchController(searchResultsController: nil)
    var optionalVar:String?
    @IBOutlet weak var tableView: UITableView!
//    let dishArray = ["Hyderabad Biryani","Hyderabd Noodles","Fried Rice","Hyderabad pulao","Butter Chicken","Chilli Chicken","Chicken Manchurian","Shawarma"]
//    let chefArray = ["By Ramya","By Alekya","By Kishore","By Prasad","By Venkatesh","By Sonam Kapoor","By Srija","By Pooja Hegde"]
//    let favArray = [40,35,43,21,73,94,97,123]
//    let imgArray = ["Noodles","Noodles","Noodles","Noodles","Noodles","Noodles","Noodles","Noodles"]
    var savedDishArr:[String] = [String]()
    var savedChefArr:[String] = [String]()
    var savedDict = [String:String]()
    var likes: [UIImage]!
    var saved:[UIImage]!
    //var isFoodFav = UserDefaults.standard.bool(forKey: "isFoodFav")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataAppending()
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

            dictionary.keys.forEach
            { key in   defaults.removeObject(forKey: key)
            }
//        print("\(data.count)")
//        if(searching)
//        {
//            likes = [UIImage](repeating: UIImage(systemName: "heart")! , count: searchedDish.count)
//            saved = [UIImage](repeating: UIImage(systemName: "bookmark")!, count: searchedDish.count)
//        }else
//        {
//            likes = [UIImage](repeating: UIImage(systemName: "heart")! , count: data.count)
//            saved = [UIImage](repeating: UIImage(systemName: "bookmark")!, count: data.count)
//        }

        let cell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "cell")
        configureSearchController()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func dataAppending()
    {
        let dish1 = dishData(chefName: "By Ramya", dishName: "Hyderabad Biryani", dishImg: "Noodles", favCount: 40)
        data.append(dish1)
        let dish2 = dishData(chefName: "By Alekya", dishName: "Hyderabd Noodles", dishImg: "Noodles", favCount: 35)
        data.append(dish2)
        let dish3 = dishData(chefName: "By Kishore", dishName: "Fried Rice", dishImg: "Noodles", favCount: 43)
        data.append(dish3)
        let dish4 = dishData(chefName: "By Prasad", dishName: "Hyderabad pulao", dishImg: "Noodles", favCount: 21)
        data.append(dish4)
        let dish5 = dishData(chefName: "By Venkatesh", dishName: "Butter Chicken", dishImg: "Noodles", favCount: 73)
        data.append(dish5)
        let dish6 = dishData(chefName: "By Sonam Kapoor", dishName: "Chilli Chicken", dishImg: "Noodles", favCount: 94)
        data.append(dish6)
        let dish7 = dishData(chefName: "By Srija", dishName: "Chicken Manchurian", dishImg: "Noodles", favCount: 97)
        data.append(dish7)
        let dish8 = dishData(chefName: "By Pooja Hegde", dishName: "Shawarma", dishImg: "Noodles", favCount: 123)
        data.append(dish8)
    }
    
    private func configureSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search By Dish Name"
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            likes = [UIImage](repeating: UIImage(systemName: "heart")! , count: searchedDish.count)
            saved = [UIImage](repeating: UIImage(systemName: "bookmark")!, count: searchedDish.count)
            return searchedDish.count
            
        }
        else
        {
            likes = [UIImage](repeating: UIImage(systemName: "heart")! , count: data.count)
            saved = [UIImage](repeating: UIImage(systemName: "bookmark")!, count: data.count)
            return data.count
      
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        if searching{
            
            cell.dishTitleLbl.text = searchedDish[indexPath.row].dishName
            cell.chefNameLbl.text = searchedDish[indexPath.row].chefName
            cell.favCountLbl.text = String(searchedDish[indexPath.row].favCount)
            cell.icoImgView!.image = UIImage(named: "\(searchedDish[indexPath.row].dishImg!)")
            cell.favBtn.tag = indexPath.row
            cell.saveBtn.tag = indexPath.row
            cell.favBtn.addTarget(self, action: #selector(favButtonClick), for: UIControl.Event.touchUpInside)
            cell.favBtn.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            
            cell.saveBtn.addTarget(self, action: #selector(saveButtonClick), for: UIControl.Event.touchUpInside)
        }
        else
        {
            
            cell.dishTitleLbl.text = data[indexPath.row].dishName
            cell.chefNameLbl.text = data[indexPath.row].chefName
            cell.favCountLbl.text = String(data[indexPath.row].favCount)
            cell.icoImgView!.image = UIImage(named: "\(data[indexPath.row].dishImg!)")
            print(data[indexPath.row].dishImg!)
            cell.favBtn.tag = indexPath.row
            cell.saveBtn.tag = indexPath.row
            cell.favBtn.addTarget(self, action: #selector(favButtonClick), for: UIControl.Event.touchUpInside)
            cell.favBtn.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            cell.saveBtn.addTarget(self, action: #selector(saveButtonClick), for: UIControl.Event.touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            print("Searching \(indexPath.row)")
            print(searchedDish[indexPath.row].dishName!)
        }
        else
        {
            print("\(indexPath.row)")
            print(data[indexPath.row].dishName!)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if(!searchText.isEmpty)
        {
            searching = true
            searchedDish.removeAll()
            for dish in data
            {
                if(dish.dishName.lowercased().contains(searchText.lowercased()))
                {
                    searchedDish.append(dish)
                }
            }
        }
        else
        {
            searching = false
            searchedDish.removeAll()
            searchedDish = data
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedDish.removeAll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    
    @objc func favButtonClick(sender:UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath: IndexPath? = tableView.indexPathForRow(at: buttonPosition)

        let cell = tableView.cellForRow(at: indexPath! as IndexPath) as? CustomTableViewCell
//        print(sender.tag) // This works, every cell returns a different number and in order.
        if searching
        {
            if likes[sender.tag] == UIImage(systemName: "heart") {
                likes[sender.tag] = UIImage(systemName: "heart.fill")!
                cell?.favCountLbl.text = String(searchedDish[sender.tag].favCount + 1)
                sender.setImage(likes[sender.tag], for: UIControl.State.normal)
                
            }
            else {
                likes[sender.tag] = UIImage(systemName: "heart")!
                cell?.favCountLbl.text = String(searchedDish[sender.tag].favCount)
                sender.setImage(likes[sender.tag], for: UIControl.State.normal)
               
            }
        }else
        {
            if likes[sender.tag] == UIImage(systemName: "heart") {
                likes[sender.tag] = UIImage(systemName: "heart.fill")!
                cell?.favCountLbl.text = String(data[sender.tag].favCount + 1)
                sender.setImage(likes[sender.tag], for: UIControl.State.normal)
                
            }
            else {
                likes[sender.tag] = UIImage(systemName: "heart")!
                cell?.favCountLbl.text = String(data[sender.tag].favCount)
                sender.setImage(likes[sender.tag], for: UIControl.State.normal)
            }
            
        }
            
        
        
    }
    @objc func saveButtonClick(sender:UIButton)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath: IndexPath? = tableView.indexPathForRow(at: buttonPosition)

        let cell = tableView.cellForRow(at: indexPath! as IndexPath) as? CustomTableViewCell
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        
        //let indexPath1 = IndexPath(row: sender.tag, section: 0)
        print("Save Button Clicked \(sender.tag)")
        if(searching)
        {
            if(saved[sender.tag] == UIImage(systemName: "bookmark"))
            {
                saved[sender.tag] = UIImage(systemName: "bookmark.fill")!
                cell?.saveLbl.text = "Unsave"
                //vc.dataLbl.text = "BookMark Saved for cell No : \(sender.tag)"
                vc.data = "BookMark Saved for cell No : \(sender.tag)"
                //self.navigationController?.pushViewController(vc, animated: true)
                
                UserDefaults.standard.set("\(searchedDish[sender.tag].dishName ?? "No Name")", forKey: "\(searchedDish[sender.tag].chefName ?? "No Name")")
                
                print("\(searchedDish[sender.tag].dishName ?? "No Name") = \(searchedDish[sender.tag].chefName ?? "No Name")")
                    UserDefaults.standard.synchronize()
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("Saved")
                    print("\(key) = \(value) \n")
                }
            }
            else {
                saved[sender.tag] = UIImage(systemName: "bookmark")!
                cell?.saveLbl.text = "Save"
                print("\(searchedDish[sender.tag].dishName ?? "No Name") = \(searchedDish[sender.tag].chefName ?? "No Name")")
                vc.data = "BookMark Unsaved for cell No : \(sender.tag)"
                //self.navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.removeObject(forKey: "\(searchedDish[sender.tag].dishName ?? "No Name")")
                UserDefaults.standard.synchronize()
                
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("Removed")
                    print("\(key) = \(value) \n")
                }
                }
            
        }else
        {
            if(saved[sender.tag] == UIImage(systemName: "bookmark"))
            {
                saved[sender.tag] = UIImage(systemName: "bookmark.fill")!
                cell?.saveLbl.text = "Unsave"
                //vc.dataLbl.text = "BookMark Saved for cell No : \(sender.tag)"
                vc.data = "BookMark Saved for cell No : \(sender.tag)"
                //self.navigationController?.pushViewController(vc, animated: true)
                
                UserDefaults.standard.set("\(data[sender.tag].dishName ?? "No Name")", forKey: "\(data[sender.tag].chefName ?? "No Name")")
                
                print("\(data[sender.tag].dishName ?? "No Name") = \(data[sender.tag].chefName ?? "No Name")")
                    UserDefaults.standard.synchronize()
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("Saved")
                    print("\(key) = \(value) \n")
                }
            }
            else {
                saved[sender.tag] = UIImage(systemName: "bookmark")!
                cell?.saveLbl.text = "Save"
                print("\(data[sender.tag].dishName ?? "No Name") = \(data[sender.tag].chefName ?? "No Name")")
                vc.data = "BookMark Unsaved for cell No : \(sender.tag)"
                //self.navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.removeObject(forKey: "\(data[sender.tag].dishName ?? "No Name")")
                UserDefaults.standard.synchronize()
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("Removed")
                    print("\(key) = \(value) \n")
                }
                }
        }

        sender.setImage(saved[sender.tag], for: UIControl.State.normal)
        //presentAlert(withTitle: "Message", message: "Item Saved")
    }
}
