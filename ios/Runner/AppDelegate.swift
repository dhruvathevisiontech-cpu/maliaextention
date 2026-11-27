
import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GMSServices.provideAPIKey("AIzaSyCQcM71ZE4Yd0rU9ugw1nF9hNyH38iJXxU")

    return super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
  }

  func didInitializeImplicitFlutterEngine(
    _ engineBridge: FlutterImplicitEngineBridge
  ) {
    print("DEBUG: Flutter implicit engine initialized")

    GeneratedPluginRegistrant.register(
      with: engineBridge.pluginRegistry
    )

    print("DEBUG: Flutter plugins registered")
  }
}
