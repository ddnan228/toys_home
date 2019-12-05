import UIKit
import Flutter
import GoogleMaps //<--

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyD5MUC-Tb0LOaAzxR8MYo1-i-GWaCDLcH4")  //<-- Add this line!
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
