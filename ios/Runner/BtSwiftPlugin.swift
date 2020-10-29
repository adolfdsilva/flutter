import Flutter
import UIKit

public class BtSwiftPlugin: NSObject, FlutterPlugin {
    static var printerSDK : PrinterSDK? = nil
    static var _result: FlutterResult? = nil
    static let instance = BtSwiftPlugin()
    static var printers = [String : Printer]()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "plugins", binaryMessenger: registrar.messenger())
        let btChannel = FlutterEventChannel(name: "btChannel", binaryMessenger: registrar.messenger())
        btChannel.setStreamHandler(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
        printerSDK = PrinterSDK.default()
        NotificationCenter.default.addObserver(instance, selector: #selector(instance.printerConnected), name: NSNotification.Name.PrinterConnected, object: nil)
    }
    
    var _sink : FlutterEventSink? = nil
    
    
    public static func registerAppDelage(with registrar: FlutterPluginRegistry) {
        register(with: registrar.registrar(forPlugin: "BtSwiftPlugin"))        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        BtSwiftPlugin._result = result
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "stopScan":
            BtSwiftPlugin.instance.stopScan()
        case "connect":
            BtSwiftPlugin.instance.connect(address: call.arguments as! String)
        case "startPrint":
            BtSwiftPlugin.instance.startPrint(text: call.arguments as! String)
        default:
            result("Error")
        }
    }
    
}

extension BtSwiftPlugin:FlutterStreamHandler {
    
    @objc private func printerConnected(notification: NSNotification){
        print("Printer Connected")
        
        if let result = BtSwiftPlugin._result {
            result("connected")
        }
    }
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events
        startScan()
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    func startScan()  {
        guard let sink = _sink else {
            return
        }
        
        BtSwiftPlugin.printerSDK?.scanPrinters(completion: {(value) in
            if let printer = value {
                BtSwiftPlugin.printers[printer.uuidString] = printer
                let btDevice = ["name":printer.name , "address":printer.uuidString]
                if let json = try? JSONSerialization.data(withJSONObject: btDevice, options: []) {
                    let jsonString = String(data: json, encoding: .utf8)
                    sink(jsonString)
                }
            }
        })
    }
    
    func connect(address:String) {
        if let printer = BtSwiftPlugin.printers[address] {
            BtSwiftPlugin.printerSDK?.connectBT(printer)
        }
        
    }
    
    func stopScan() {
        BtSwiftPlugin.printerSDK?.disconnect()
    }
    
    func startPrint(text:String) {
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 0.5, execute: {
            BtSwiftPlugin.printerSDK?.printText(text)
        })
    }
    
}
