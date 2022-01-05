import UIKit
import Flutter
import zpdk

// chanel Init to handle Channel Flutter
enum ChannelName {
  static let channelPayOrder = "flutter.native/channelPayOrder"
  static let eventPayOrder = "flutter.native/eventPayOrder"
}

// methods define to handle in channel
enum MethodNames {
    static let methodPayOrder = "payOrder"
    static let methodPayOrderByMomo = "payOrderMomo"
}


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler, ZPPaymentDelegate {
    
    let PAYMENTCOMPLETE = 1
    let PAYMENTERROR = -1
    let PAYMENTCANCELED = 4
    private var eventSink: FlutterEventSink?
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return ZaloPaySDK.sharedInstance().application(app, open:url, sourceApplication: "vn.com.vng.zalopay", annotation:nil)
        }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    func paymentDidSucceeded(_ transactionId: String!, zpTranstoken: String!, appTransId: String!) {
        guard let eventSink = eventSink else {
            return
        }
        
        eventSink(["errorCode": PAYMENTCOMPLETE, "zpTranstoken": zpTranstoken ?? "", "transactionId": transactionId ?? "", "appTransId": appTransId ?? ""])
    }
    
    func paymentDidCanceled(_ zpTranstoken: String!, appTransId: String!) {
        guard let eventSink = eventSink else {
          return
        }
        eventSink(["errorCode": PAYMENTCANCELED, "zpTranstoken": zpTranstoken ?? "", "appTransId": appTransId ?? ""])
    }
    
    func paymentDidError(_ errorCode: ZPPaymentErrorCode, zpTranstoken: String!, appTransId: String!) {
        guard let eventSink = eventSink else {
          return
        }
        eventSink(["errorCode": PAYMENTERROR, "zpTranstoken": zpTranstoken ?? "", "appTransId": appTransId ?? ""])
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    //NOTE: - If you want to use production, replace .sandbox with .production
    ZaloPaySDK.sharedInstance()?.initWithAppId(2554, uriScheme: "demozpdk://app", environment: .sandbox)
    
    // Handle channel in iOS
    let controller = window.rootViewController as? FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: ChannelName.channelPayOrder, binaryMessenger: controller!.binaryMessenger)
    
    nativeChannel.setMethodCallHandler({
    [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == MethodNames.methodPayOrder || call.method == MethodNames.methodPayOrderByMomo else {
          result(FlutterMethodNotImplemented)
          return
        }

        let args = call.arguments as? [String: Any]

        
        let _zptoken = args?["zptoken"] as? String
        let _momoDeepLink = args?["deeplink"] as? String
        
        if (_zptoken != nil) {
            ZaloPaySDK.sharedInstance()?.paymentDelegate = self
            ZaloPaySDK.sharedInstance()?.payOrder(_zptoken)
            result("Processing...")
        }
        if (_momoDeepLink != nil) {
            print("DEEP LINK IN NATIVE", _momoDeepLink ?? "NATIVE DEEPLINK")
            
            if let appURL = URL(string: _momoDeepLink ?? "") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL) { success in
                        if success {
                            print("The URL was delivered successfully.")
                        } else {
                            print("The URL failed to open.")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            } else {
                print("Invalid URL specified.")
            }
        }
        else {
            print("ERROR NATIVE")
        }
        
    })
    
    let eventPayOrderChannel = FlutterEventChannel(name: ChannelName.eventPayOrder,
                                              binaryMessenger: controller!.binaryMessenger)

    eventPayOrderChannel.setStreamHandler(self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
