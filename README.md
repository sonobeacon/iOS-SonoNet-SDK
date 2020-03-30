# iOS-SonoNet-SDK

Minimum requirements: iOS 10

## How to use

Create a new iOS Xcode project or open an existing project. Simply drag the sonolib.framework to your project.

Make sure that the ‚Add to targets‘ checkbox is checked for the correct target you intend to use the framework with. You can check Copy items into destination group’s folder if needed.

Set „Enable Bitcode“ to No in Build Settings.

#### Permissions
Add descriptions to your Info.plist to describe why you will be using the microphone as well as location tracking.
(Privacy - Microphone Usage Description | Privacy - Location Always Usage Description | Location When In Use Description | Location Always And When In Use UsageDescription | Privacy - Bluetooth Peripheral Usage Description)

#### Background Modes
Turn on Remote Notifications in Background Modes among Capabilities settings if you want to use Local Push Notifications.
In addition, you need to turn on Location Updates.

#### Credentials
We will provide you with the SDK as well as the corresponding Api key and Location Id. Note: The Location Id is an identifier used to determine a particular location/environment in which beacons can be detected. E.g. Your retail store is equipped with 5 Sonobeacons, thus only those 5 beacons (which are associated to the location) are detected by the SDK. Skip adding the Location Id to SonoNetConfigs if you do not want to detect only certain Sonobeacons within a single environment.

#### ContentView (optional)
The ContentView is a UI component that controls the display of content using the SDK. Basically, the content associated to a beacon is displayed using a web view, whereby individual functions extend and enhance the user experience.
The ContentView also contains a side menu, which can optionally be used to display configured menu items.
You don't need to use the ContentView if you want to handle the display of content by yourself.

Usage: Simply drag an UIView to your View in Storyboard, set the Constraints and naviagte to the Identity Inspector. Rename the Class to 'ContentView'. Below, set the Module 'sonolib'. Then connect the created ContentView to the corresponding ViewController using an outlet and pass the view to SonoNet via the SonoNetConfigBuilder.


## Inside your app

### Swift

Go to your ViewController you want to use SonoNet, import sonolib and instantiate the SonoNet singleton.

```swift
import sonolib

@IBOutlet weak var contentView: ContentView!  /* optional */
let sonoNet = SonoNet.shared
```

Set up the SonoNetConfigs by using SonoNetConfigBuilder. Afterwards bind SonoNet. Use the closure callback to receive the content of detected Sonobeacons. The content contains id, title and url:

TODO: add bluetoothOnly

```swift
let config = SonoNetConfigBuilder { builder in
            builder.apiKey = "YOUR_API_KEY"
            builder.contentView = contentView              /* optional */
            builder.notifyMe = true                        /* optional - if you want to get notified once you enter defined geographical areas */
            builder.hasMenu = true                         /* optional - integration is only possible in conjunction with contentView */
            builder.debugMode = true                       /* optional */
            builder.singleLocation = "YOUR_LOCATION_ID"    /* optional - pass your Location ID */
            builder.preferredMic = 1                       /* optional - front mic = 1 (default) / back mic = 2 / bottom mic = 0 */
        }
        
        guard let sonoNetConfig = SonoNetConfig(config) else { return }
        sonoNet.bind(withConfig: sonoNetConfig)
        
        sonoNet.didReceiveContent = { [weak self] content in
            guard let _ = self else { return }
            print("\(content.title)")
        }
```

Note: SonoNet requires permission to use both microphone and localization. The permission to use Bluetooth is only needed for optimizing localization. Bluetooth functionality should be activated if no Location Id is passed. Check out the demo app for implementation.

### Objective-C

Set „Always Embed Standard Swift Libraries“ to Yes in Build Settings. Check out the demo app.

```objective-C
@import sonolib;

@property (weak, nonatomic) IBOutlet ContentView *contentView;

SonoNet *sonoNet = [SonoNet shared];
    
SonoNetConfig* config = [[SonoNetConfigBuilder alloc] initWithBuildClosure:^(SonoNetConfigBuilder * builder) {
      // assign properties
    }];

[sonoNet bindWithConfig:(config)];

[sonoNet setDidReceiveContent:^(id webLink) {
    NSString *title = [webLink title];
    NSLog(@"Title", title);
    }];
```
