//
//  ImageViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 14/09/21.
//

import UIKit
import WebKit

class ImageViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadImageWith(_ url: URL?) {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
