//
//  FullSizeImageViewController.swift
//  RLReddit
//
//  Created by Taras Galagodza on 9/8/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class FullSizeImageViewController: UIViewController {

    @IBOutlet weak var fullSizeImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var imageLink: String?
    private var isSavingInProgress: Bool = false {
        didSet {
            activityIndicatorView.isHidden = !isSavingInProgress
            if (isSavingInProgress)
            {
                activityIndicatorView.startAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        isSavingInProgress = false
        if let imageLink = imageLink {
            fullSizeImageView.downloadedFrom(link: imageLink)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveImage() {
        if let image = fullSizeImageView.image {
            isSavingInProgress = true
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        isSavingInProgress = false
        var title = NSLocalizedString("Image saved", comment: "")
        var message = NSLocalizedString("image successfully saved to your gallery", comment: "")
        if let error = error {
            title = NSLocalizedString("Error", comment: "")
            message = error.localizedDescription
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        present(alert, animated: true)
    }
}

extension FullSizeImageViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        if let imageLink = imageLink {
            coder.encode(imageLink, forKey: "imageLink")
        }
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        imageLink = coder.decodeObject(forKey: "imageLink") as? String
        super.decodeRestorableState(with: coder)
    }
    
    override func applicationFinishedRestoringState() {
        if let imageLink = imageLink {
            fullSizeImageView.downloadedFrom(link: imageLink)
        }
    }
}
