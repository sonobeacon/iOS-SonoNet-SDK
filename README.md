# iOS-SonoNet-SDK

Minimum requirements: iOS 10

## How to use

Create a new iOS Xcode project or open an existing project. Simply add the sonolib.framework to the "Embedded Binaries" section in the general settings of your app.

Make sure that the ‚Add to targets‘ checkbox is checked for the correct target you intend to use the framework with. You can check Copy items into destination group’s folder if needed.

Set „Enable Bitcode“ to No in Build Settings.
Also add descriptions to your Info.plist, why you will be using microphone and location tracking.
(Privacy - Microphone Usage Description | Privacy - Location Always Usage Description | Location When In Use Description | Privacy - Bluetooth Peripheral Usage Description)

We will provide you with the SDK as well as the Api key and the Location Id. Note: The location Id is an identifier used to determine a particular location/environment in which beacons can be detected. E.g. Your retail store is equipped with 5 Sono beacons, thus only those 5 beacons (which are associated to the location) are detected by the SDK. Skip adding the location Id to the SonoNetCredentials if you do not want to detect only certain Sono beacons within a single environment.

#### ContentView (optional)
The ContentView is an UI component that controls the display of content via the SDK. Mainly, the content associated to a beacon is displayed in a web view, whereby individual functions extend and enhance the user experience. You don't need to use the ContentView if you want to handle the display of content by yourself.

Usage: Simply drag an UIView to your View in Storyboard, set the Constraints and naviagte to the Identity Inspector. Rename the Class to 'ContentView'. Below, set the Module 'sonolib'. Then connect the created ContentView to the corresponding ViewController using an outlet.


## Inside your app

### Swift

Go to your ViewController you want to use SonoNet, import sonolib and instantiate the SonoNet singleton.

```swift
import sonolib

@IBOutlet weak var contentView: ContentView!  /* optional */
let sonoNet = SonoNet.shared
```

Afterwards set up the credentials using SonoNetCredentials (locationId is optional) and initialize SonoNet. Use the closure callback to receive the content of detected Sonobeacons. The content contains the id, title and url:

```swift
let credentials = SonoNetCredentials(apiKey: "YOUR_API_KEY", locationId: "LOCATION_ID") /* REPLACE WITH YOUR CREDENTIALS */
// let credentials = SonoNetCredentials(apiKey: "YOUR_API_KEY")
sonoNet.bind(withCredentials: credentials, andOptionalContentView: contentView) /* optional */
// sonoNet.bind(withCredentials: credentials)

sonoNet.didReceiveContent = { [weak self] content in
            guard let strongSelf = self else { return }
            print("\(content.title)")
        }
```

Note: SonoNet requires permission to use both microphone and localization. The permission to use Bluetooth is only necessary to optimize localization. Bluetooth functionality should be activated if no location Id is passed. Check out the demo app for implementation.

### Obective-C

Set „Always Embed Standard Swift Libraries“ to Yes in Build Settings. Check out the demo app.

```objective-C
@import sonolib;

@property (weak, nonatomic) IBOutlet ContentView *contentView;

SonoNet *sonoNet = [SonoNet shared];
 
SonoNetCredentials *credentials = [[SonoNetCredentials alloc] initWithApiKey:@"YOUR_API_KEY" locationId:@"LOCATION_ID"];
[sonoNet bindWithCredentials:(credentials) andOptionalContentView:contentView];
    
[sonoNet setWhenBluetoothDisabled:^{
        // do nothing so far
    }];
    
    
[sonoNet setDidReceiveContent:^(id webLink) {
        __weak ViewController *wSelf = self;
        NSString *title = [webLink title];
        NSLog(@"Title", title);
    }];
```
