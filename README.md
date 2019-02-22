# iOS-SonoNet-SDK

Minimum requirements: iOS 10

## How to use

Create a new iOS Xcode project or open an existing project. Simply drag the sonolib.framework into your project navigator on the left hand side, possibly onto the Framework group, but thats entirely up to you.

Make sure that the ‚Add to targets‘ checkbox is checked for the correct target you intend to use the framework with. You can check Copy items into destination group’s folder if needed.
Add the framework to the Embedded Binaries in the General Project Settings.

Set „Enable Bitcode“ to No in Build Settings.
Also define in your Info.plist, why you will be using the microphone.

We will provide you with the SDK as well as the Api key and the Location Id.

## Inside your app

### Swift

Go to your ViewController you want use SonoNet, import sonolib and instantiate the SonoSystem singleton in your ViewController:

```swift
import sonolib
let sonoSystem = SonoSystem.shared
```
Then set up the credentials using SonoSystemCredentials and initialize SonoSystem. Use the closure callback to receive the content of detected Sonobeacons:

```swift
let credentials = SonoSystemCredentials(apiKey: "YOUR_API_KEY", locationId: "YOUR_LOCATION_ID")
  sonoSystem.bind(withCredentials: credentials)

sonoSystem.didReceiveContent = { [weak self] content in
            guard let strongSelf = self else { return }
            print("\(content.title)")
        }
```

### Obective-C


```objective-C
SonoSystem *sonoSystem = [SonoSystem shared];

SonoSystemCredentials *credentials = [[SonoSystemCredentials alloc] initWithApiKey:@"YOUR_API_KEY" locationId:"YOUR_LOCATION_ID"];
[sonoSystem bindWithCredentials:(credentials) andOptionalContentView:nil];

[sonoSystem setDidReceiveContent:^(id webLink) {
        NSString *title = [webLink title];
        NSLog(@"%@", title);
    }];
```


## License
[MIT](https://choosealicense.com/licenses/mit/)
