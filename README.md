# iOS-SonoNet-SDK

Minimum requirements: iOS 10

<h2>How to use:</h2>

Create a new iOS Xcode project or open an existing project. Simply drag the sonolib.framework into your project navigator on the left hand side, possibly onto the Framework group, but thats entirely up to you.

Make sure that the ‚Add to targets‘ checkbox is checked for the correct target you intend to use the framework with. You can check Copy items into destination group’s folder if needed.
Add the framework to the Embedded Binaries in the General Project Settings.

Set „Enable Bitcode“ to No in Build Settings.
Also define in your Info.plist, why you will be using the microphone.

We will provide you with the SDK as well as the Api key and the Location Id.

<h2>Inside your app</h2>

Go to your ViewController you want use SonoNet and import sonolib:

 `import sonolib`

Instantiate the SonoSystem singleton in your ViewController:

 `let sonoSystem = SonoSystem.shared`

Then set up the credentials using SonoSystemCredentials and initialize SonoSystem:

 `let credentials = SonoSystemCredentials(apiKey: "YOUR_API_KEY", locationId: "YOUR_LOCATION_ID")
  sonoSystem.bind(withCredentials: credentials)`
 
Use the closure callback to receive the content of detected Sono beacons:
 
 `sonoSystem.didReceiveContent = { [weak self] content in
            guard let strongSelf = self else { return }
            print("\(content.title)")
        }
    }`
 
 
<h3>Objective-C implementation:</h3>
 
`SonoSystem *sonoSystem = [SonoSystem shared];
 SonoSystemCredentials *credentials = [[SonoSystemCredentials alloc] initWithApiKey:@"YOUR_API_KEY" locationId:"YOUR_LOCATION_ID"];
 [sonoSystem bindWithCredentials:(credentials) andOptionalContentView:nil];`
    
    `[sonoSystem setDidReceiveContent:^(id webLink) {
        __weak ViewController *wSelf = self;
        NSString *title = [webLink title];
        wSelf.label.text = title;
    }];`





    
 
