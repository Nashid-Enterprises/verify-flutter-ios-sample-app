import UIKit
import Flutter
import IDVSDK


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 1
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // 2
        let deviceChannel = FlutterMethodChannel(name: "test.flutter.methodchannel/iOS",
                                                 binaryMessenger: controller.binaryMessenger)
        
        // 3
        prepareMethodHandler(deviceChannel: deviceChannel)
        GeneratedPluginRegistrant.register(with: self)
        
        NashidSDK.shared.initializeSDK(token: "MIO7NIJsfkJsE8HJJOB1Ff3xpysU7k1HE2NhslTCKA2qaIfIS9", id: "MD7ECJ0K48AJP6S", baseUrl: "https://dashboard.test.projectnid.com/api/", employeeEmail: "sotopo5208@ikumaru.com", languageId: "en")
       
        NashidSDK.shared.scanResultCallback = { nashidResult, type in
            print(nashidResult)
            print(type)
            //result(nashidResult)
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        
        // 4
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            // 5
            if call.method == "scanDocument" {
                NashidSDK.shared.documentScan()
               
            } else if call.method == "scanPassport" {
                // 9
                NashidSDK.shared.passportScan()
            }
        })
    }
}
