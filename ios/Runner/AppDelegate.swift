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
    GMSServices.provideAPIKey("API-KAMU-SENDIRI-YAA hehe")
    // ----------------------------------------------

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
