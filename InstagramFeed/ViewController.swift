//
//  ViewController.swift
//  InstagramFeed
//
//  Created by Prasanthi Relangi on 2/4/16.
//  Copyright © 2016 prasanthi. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var media:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
    }
    
    func fetchData() {
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            self.media = responseDictionary["data"]as! [NSDictionary]
                            
                            print("media = \(self.media)")
                            print("media count = \(self.media.count)")
                            
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath)
        if let images = media[indexPath.row]["images"] as! NSDictionary? {
            if let resolution = images["low_resolution"] as! NSDictionary? {
                if let url = resolution["url"] as! NSString? {
                    print(url)
                    let imageURL = NSURL(string: url as String)
                    cell.imageView!.setImageWithURL(imageURL!)
                }
            }
        }
        return cell
    }
    
    func get_url(indexPath:NSIndexPath) -> String? {
        if let images = media[indexPath.row]["images"] as! NSDictionary? {
            if let resolution = images["low_resolution"] as! NSDictionary? {
                if let url = resolution["url"] as! NSString? {
                    return(url) as String
                }
            }
        }
        
        return nil
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        vc.photoURL = NSURL(string: get_url(indexPath!)!)
        
        print("prepareForSegue: photoURL = \(vc.photoURL)")
        
        
        
        
        
    }


}

