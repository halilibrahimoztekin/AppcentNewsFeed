//
//  FavoriteViewController.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import UIKit
import CoreData
class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleArray = [String]()
    var imageArray = [String]()
    var sourceArray = [String]()
    var descriptionArray = [String]()
    var idArray = [UUID]()
    var selectedNews = ""
    var selectedNewsId : UUID?
    @IBOutlet weak var tableView: UITableView!
    var selectedFeed : ArticleViewModel!
    private var feeds : ArticleListViewModel!
    override func viewDidLoad() {
        selectedNews = ""
        super.viewDidLoad()
        // Core Data ile favori verilerin çekilmesi
        getCoreData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            //  NotificationCenter ile gelen paketi dinleme ve aksiyon alma
            NotificationCenter.default.addObserver(self, selector: #selector(getCoreData), name: NSNotification.Name("New Data"), object: nil)
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavoritesCellTableViewCell
      let imageurl = imageArray[indexPath.row]
      cell.imageViewFav.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "no_photo.svg"))
        cell.titleLabelFav.text = titleArray[indexPath.row].uppercased()
        cell.sourceFav.text = sourceArray[indexPath.row].lowercased()
        cell.descriptionLabel.text = descriptionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNews = titleArray[indexPath.row]
        selectedNewsId = idArray[indexPath.row]
        performSegue(withIdentifier: "FavToDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FavToDetailsVC" {
                    
                    let destinationVC = segue.destination as! DetailsViewController
                    destinationVC.selectedNews = selectedNews
                    destinationVC.selectedNewsId = selectedNewsId
                    
                }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
                    let idString = idArray[indexPath.row].uuidString
                    fetchrequest.predicate = NSPredicate(format: "postId = %@", idString)
                    fetchrequest.returnsObjectsAsFaults = false
                    do{
                    let results = try context.fetch(fetchrequest)
                        if results.count > 0 {
                            for result in results as! [NSManagedObject]{
                                if let id = result.value(forKey: "postId") as? UUID  {
                                    if id == idArray[indexPath.row]{
                                        context.delete(result)
                                        titleArray.remove(at: indexPath.row)
                                        imageArray.remove(at: indexPath.row)
                                        sourceArray.remove(at: indexPath.row)
                                        descriptionArray.remove(at: indexPath.row)
                                        idArray.remove(at: indexPath.row)
                                        self.tableView.reloadData()
                                        do
                                        {
                                         try context.save()
                                        }
                                        catch
                                        {
                                        print("error")
                                        }
                                        break
                                }
                                }
                            }
                        }
                    }
                    catch{
                        print("error")
                    }
                     
                    
                }
    }
    
    // Core Data ile Favorilere Eklenen Verilerin Çekilmesi ve Tekrara düşmemek için daha önceden çekilen arraylerin temizlenmesi
   @objc func getCoreData(){
       print("Core Data Çalıştı")
       
        imageArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        titleArray.removeAll(keepingCapacity: false)
        sourceArray.removeAll(keepingCapacity: false)
        descriptionArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
         
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        fetchReq.returnsObjectsAsFaults = false
        
        do {
                    let results = try context.fetch(fetchReq)
                    for result in results as! [NSManagedObject] {
                        if let title =  result.value(forKey: "posttitle") as? String{
                            titleArray.append(title)
                        }
                        if let image =  result.value(forKey: "posturlToImage") as? String{
                            imageArray.append(image)
                        }
                        if let source =  result.value(forKey: "postsource") as? String{
                            sourceArray.append(source)
                        }
                        if let description =  result.value(forKey: "postdescription") as? String{
                            descriptionArray.append(description)
                        }
                        if let id = result.value(forKey: "postId") as? UUID{
                            self.idArray.append(id)
                            
                        }
                        self.tableView.reloadData()
                        
                    }
                    
                }
                catch{
                    print("error")
                }
    }

}
