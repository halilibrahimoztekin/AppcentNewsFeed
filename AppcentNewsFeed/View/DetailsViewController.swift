//
//  DetailsViewController.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import UIKit
import CoreData
import WebKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var choosenFeed : ArticleViewModel!
    var selectedNews = ""
    var selectedNewsId : UUID?
    var postUrl = ""
    var webView: WKWebView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedNews == "Feed"{
            
            FeedToDeetails()
        }
        else {
            favToDetails()
        }
       
        
        let add = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteAddPost))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(sender:)))
        
        navigationItem.rightBarButtonItems = [add, share]

        
        
        
    }
    
    
    
    
    func favToDetails(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   let context = appDelegate.persistentContainer.viewContext
                   
                   let idString = selectedNewsId?.uuidString
                   
                   let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
                   fetchReq.returnsObjectsAsFaults = false
                   fetchReq.predicate = NSPredicate(format: "postId = %@",  idString!)
                   do{
                       let results = try context.fetch(fetchReq)
                       if results.count > 0{
                           
                           
                           for result in results as! [NSManagedObject] {
                               if let title = result.value(forKey: "posttitle") as? String{
                                   titleLabel.text = title
                               }
                               if let description = result.value(forKey: "postdescription") as? String{
                                   descriptionTitle.text = description
                               }
                               if let content = result.value(forKey: "postcontent") as? String{
                                   contentLabel.text = content
                               }
                               if let source = result.value(forKey: "postsource") as? String{
                                   sourceLabel.text = source
                               }
                               if let date = result.value(forKey: "postpublishedAt") as? String{
                                   dateLabel.text = date
                               }
                               if let posturl = result.value(forKey: "posturl") as? String{
                                   postUrl = posturl
                               }
                               if let posturlToImage = result.value(forKey: "posturlToImage") as? String{
                                   imageView.sd_setImage(with: URL(string: posturlToImage), placeholderImage: UIImage(named: "no_photo.svg"))
                               }
                               
                               
                               
                           }
                       }
                   } catch{
                       print("error")
                   }
    }
    
    func FeedToDeetails(){
        
        descriptionTitle.text = choosenFeed.description
        imageView.sd_setImage(with: URL(string: choosenFeed.urlToImage), placeholderImage: UIImage(named: "no_photo.svg"))
        contentLabel.text = choosenFeed.content
        sourceLabel.text = choosenFeed.source
        dateLabel.text = choosenFeed.publishedAt
        titleLabel.text = choosenFeed.title
        postUrl = choosenFeed.url
    }
    
    @objc func share(sender:UIView){
           UIGraphicsBeginImageContext(view.frame.size)
           view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = imageView.image

        let textToShare = titleLabel.text

        if let myWebsite = URL(string: postUrl) {
        let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "no_photo")] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        

        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
           }    }
    
    
    
    @objc func favoriteAddPost(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPost = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: context)
        newPost.setValue(UUID(), forKey: "postId")
        newPost.setValue(choosenFeed.author, forKey: "postauthor")
        newPost.setValue(choosenFeed.content, forKey: "postcontent")
        newPost.setValue(choosenFeed.description, forKey: "postdescription")
        newPost.setValue(choosenFeed.publishedAt, forKey: "postpublishedAt")
        newPost.setValue(choosenFeed.source, forKey: "postsource")
        newPost.setValue(choosenFeed.title, forKey: "posttitle")
        newPost.setValue(choosenFeed.url, forKey: "posturl")
        newPost.setValue(choosenFeed.urlToImage, forKey: "posturlToImage")
        
        NotificationCenter.default.post(name: NSNotification.Name("New Data"), object: nil)
        
    }
    
    @IBAction func clickedNewsSource(_ sender: Any) {
        performSegue(withIdentifier: "toWebViewVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebViewVC" {
                    
            let destinationVC = segue.destination as! WebViewController
            destinationVC.url = postUrl
                    
                }
    }
   
    
    @objc func sharePost(){
        
      
        
    }
    
  
    

    

}
