//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Foundation

protocol TwitterClientProtocal {
    
}

public enum TwitterURL {
    case oauth
    
    var url: URL {
        switch self {
        case .oauth:
            return URL(string: "https://api.twitter.com/")!
        }
    }
}

class OAuthClient: TwitterClientProtocal {
    var comsumerKey: String
    var comsumerSecret: String
    
    init(consumerKey: String, consumerSecret: String) {
        self.comsumerKey = consumerKey
        self.comsumerSecret = consumerSecret
    }
    
    func post(_ path: String, baseURL: TwitterURL, parameters: [String: Any]) {
        // set up HTTP Post request
        let url = URL(string: path, relativeTo: baseURL.url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        
        request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
    }
}
class Twitter {
    // properties
    var client: TwitterClientProtocal

    init(consumerKey: String, consumerSecret: String) {
        self.client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
}

// Class to authorize a user account
extension Twitter {
    public func authorize(withCallback callbackURL: URL) {
        
    }
    
    public func postOAuthRequestToken(withCallback callbackURL: URL, success: return, failure: return) {
        
    }
}

let twitter = Twitter(consumerKey: "VQDFZmAR5pc0bWt1ja6ejK6Gs", consumerSecret: "45h2w0EbZmoYQGUb7PYT7KMekSR0wmfKuqhG1omPNxifKdv23y")


class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
