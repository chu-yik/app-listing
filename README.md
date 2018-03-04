# App Listing

## Summary
This is my submission of a programming test, the features include:
- display top 10 grossing apps from HK iTunes store
- display top 100 free apps from  HK iTunes  store
- provide search by keyword to filter the displayed apps

Following is a sample screenshot for the running application:

![Sample Screenshot](/Screenshots/sample.jpeg?raw=true)

### iTunes Data API
There are 3 iTunes data API used, all data are acquired from the Hong Kong store
- [https://itunes.apple.com/hk/rss/topgrossingapplications/limit=10/json](https://itunes.apple.com/hk/rss/topgrossingapplications/limit=10/json)
- [https://itunes.apple.com/hk/rss/topfreeapplications/limit=100/json](https://itunes.apple.com/hk/rss/topfreeapplications/limit=100/json)
- https://itunes.apple.com/hk/lookup?id=[app_id]


## Build environment

### Supported IDEs
Xcode, tested on Xcode Version 9.2 (9C40b)

### Tested iOS Version
iOS 11.2

### Other tools
CocoaPods is required to handle dependencies:

```
sudo gem install cocoapods
```

### Dependencies
Managed by [CocoaPods](http://cocoapods.org). Frameworks used are:

+ Alamofire: [Alamofire 4.6+](https://github.com/Alamofire/Alamofire)
+ SwiftyJSON: [SwiftyJSON 4.0.0+](https://github.com/SwiftyJSON/SwiftyJSON)
+ Kingfisher: [Kingfisher 4.0+](https://github.com/onevcat/Kingfisher)
+ Cosmos: [Cosmos 15.0+](https://github.com/evgenyneu/Cosmos)


## How to build the project

After cloning the project, pods need to be initialized.

```
pod install
```
When all dependecies are installed, open AppListing.xcworkspace in Xcode.

### Code Signing
Code signing for the target AppListing will need to be updated before the project can be built and run.

### Bundle Identifier
Bundle identifier might need to be changed depending on the provisioning profile for code signing.
 
## Known Issues

### Rating mismatch?

It seems that there is a difference in the app rating information, between the ones displayed on the iTunes page, and the ones returned by the lookup API *(https://itunes.apple.com/hk/lookup?id=[app_id])*

Take WhatsApp Messenger *(id 310633997)* as an example:
- [https://itunes.apple.com/hk/app/id310633997](https://itunes.apple.com/hk/app/id310633997), and
- [https://itunes.apple.com/hk/lookup?id=310633997](https://itunes.apple.com/hk/lookup?id=310633997)

are showing different rating information for me.

#### Clarification

For the sake of this application, the ratings displayed are the ones from the **lookup API**.

Rating displayed is the average user rating, and the count is the user rating count.

#### Other resources

There was a similar issue a few years ago on the [discussion forum](https://discussions.apple.com/thread/4920253).

The problem for the OP was a missing store in the URL, it doesn't seem to be the case for me.
