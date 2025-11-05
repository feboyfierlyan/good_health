import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // --- TAMBAHKAN BARIS INI DENGAN API KEY ANDA ---
    GMSServices.provideAPIKey("AIzaSyA8-I-u6qiAV1Fa0N1TNSq2Eu7aHjFs8U8")
    // ----------------------------------------------

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
