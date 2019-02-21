import UIKit
import sonolib

class ViewController: UIViewController {
    
    let sonoSystem = SonoSystem.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let credentials = SonoSystemCredentials(apiKey: "YOUR_API_KEY", locationId: "YOUR_LOCATION_ID")
        sonoSystem.bind(withCredentials: credentials)
        
        sonoSystem.didReceiveContent = { [weak self] content in
            guard let strongSelf = self else { return }
            print("\(content.title)")
        }
    }

}
