//
//  PhotoDetailsViewController.swift
//  InstagramFeed
//
//  Created by Prasanthi Relangi on 2/4/16.
//  Copyright © 2016 prasanthi. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var photoURL:NSURL? = nil
    
    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        photoView.setImageWithURL(photoURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
