# iOS-SonoNet-SDK

## Table of contents
- [Installation](#installation)
    - [Permissions](#permissions)
    - [BackgroundModes](#background-modes)
    - [Credentials](#credentials)
    - [ContentView](#contentview-optional)
- [Inside your App](#inside-your-app)
    - [Setup](#setup)
    - [Location Services](#location-services)
- [Fat Framework](#fat-framework)
    - [Deploying to the AppStore](#deploying-to-the-appstore)

Minimum requirements: iOS 10

## Installation

Create a new iOS Xcode project or open an existing project. Simply drag the sonolib.framework to your project.

Make sure that the`Add to targets` checkbox is checked for the correct target you intend to use the framework with. You can check `Copy items into destination group’s folder` if needed.

Set `Enable Bitcode` to No in Build Settings.

#### Permissions
Add descriptions to your Info.plist to describe why you will be using the microphone as well as location tracking and bluetooth monitoring. Microphone may not be needed, see below:
```
Privacy - Microphone Usage Description         /* only needed if bluetoothOnly flag is not set to true */
Privacy - Location Always Usage Description
Privacy - Location When In Use Description
Privacy - Location Always And When In Use Usage Description
Privacy - Bluetooth Peripheral Usage Description
Privacy - Bluetooth Always Usage Description
```

#### Background Modes
Turn on Remote Notifications in Background Modes among Capabilities settings if you want to use Local Push Notifications.
In addition, you need to turn on Location Updates.

#### Credentials
We will provide you with the SDK as well as the corresponding Api key.

#### ContentView (optional)
The ContentView is a UI component that controls the display of content using the SDK. Basically, the content associated to a beacon is displayed using a web view, whereby individual functions extend and enhance the user experience.
The ContentView also contains a side menu, which can optionally be used to display configured menu items.
You don't need to use the ContentView if you want to handle the display of content by yourself.

Usage: Simply drag an UIView to your View in Storyboard, set the Constraints and naviagte to the Identity Inspector. Rename the Class to 'ContentView'. Below, set the Module 'sonolib'. Then connect the created ContentView to the corresponding ViewController using an outlet and pass the view to SonoNet via the SonoNetConfigBuilder.


## Inside your app

### Setup

#### Swift

Go to your ViewController you want to use SonoNet, import sonolib and instantiate the SonoNet singleton. Refer to the demo-applications on how to create a simple content view in storyboard.

```swift
import sonolib

@IBOutlet weak var contentView: ContentView!  /* optional */
let sonoNet = SonoNet.shared
```

Set up the SonoNetConfigs by using SonoNetConfigBuilder. Afterwards bind SonoNet. Use the closure callback to receive the content of detected Sonobeacons. The content contains id, title and url:

```swift
let config = SonoNetConfigBuilder { builder in
            builder.apiKey = "YOUR_API_KEY"
            builder.contentView = ContentView               /* optional - if you want to use the app's built-in webview to show content */
            builder.notifyMe = true                         /* optional - if you want to get notified once you enter defined geographical areas */
            builder.hasMenu = true                          /* optional - integration is only possible in conjunction with contentView */
            builder.debugMode = true                        /* optional - if you wish to receive detailed debugging messages */
            builder.bluetoothOnly = functionalities         /* optional - if you don't need beacon detection via microphone, defaults to false */
            builder.preferredMic = 2                        /* optional - front mic = 1 / back mic = 2 (default) / bottom mic = 0 */
            builder.showMenuEntryOnlyOnce = true            /* optional - when the menu entry should be displayed only once */
            builder.menuTextColorAsHexString = "000000"     /* optional - specify the desired menu item text color in hex */
            builder.menuFontSize = 17                       /* optional - specify the desired menu item text size */
            builder.initialLocationDebug                    /* optional - sets an intial location for registering the ble and geofence events */
        }

        guard let sonoNetConfig = SonoNetConfig(config) else { return }
        sonoNet.bind(withConfig: sonoNetConfig)

        sonoNet.didReceiveContent = { [weak self] content in
            guard let _ = self else { return }
            print("\(content.title)")
        }
```

Note: SonoNet requires permission to use both microphone and localization. The permission to use Bluetooth is only needed for optimizing localization. Bluetooth functionality should be activated if no Location Id is passed. Check out the demo app for implementation.

#### Objective-C (deprecated)

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

### Location Services

The SDK provides several functionalities based on the user's current position. In order to use this, the following implementations need to be made to ensure location services work even when the app is terminated.

#### Swift

All of the following is in the AppDelegate. Declare needed variables:

```swift
let locationManager = CLLocationManager()
private var currentLocation: CLLocation?
```

Configure the LocationManager:

```swift
func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { success, error in
                if let error = error {
                    print(Constants.Strings.error + ": \(error)")
                }
        }
        return true
    }
```

Implement its methods:

```swift
extension AppDelegate: CLLocationManagerDelegate {

        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        SonoNet.shared.enteredRegion(region: region, appState: UIApplication.shared.applicationState)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        SonoNet.shared.exitedRegion(region: region, appState: UIApplication.shared.applicationState)
    }

}
```

#### Objective-C (deprecated)

***Translate swift code to equivalent objective-c code***

## Fat Framework

Since version 5.1.0, the SDK is built as a universal (fat) framework. That means, that an app implementing the SDK can be run on a physical device but also on the simulator for development purposes. As a result, the framework file is rather large, **this changes when uploading to the AppStore**. Despite these changes, everything else stays the same and the framework behaves like you'd expect a regular swift framework to behave.

### Deploying to the AppStore

When deploying to the AppStore, it is necassary to strip the framework from code for the simulator. To do so, follow these steps:

* add a run script phase to your scheme, this is done by:
    * Navigating to `Project -> Targets -> YOUR_APP -> Build Phases`, click the + and select 'New Run Script Phase'
* Paste [`this script`](stripsimulator.sh).

That's all there is to it. Now the application is thinned on upload to the AppStore.