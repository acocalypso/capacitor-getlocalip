import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(GetLocalIPPlugin)
public class GetLocalIPPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "GetLocalIPPlugin"
    public let jsName = "GetLocalIP"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getLocalIP", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = GetLocalIP()

    @objc func getLocalIP(_ call: CAPPluginCall) {
        if let ip = implementation.getLocalIP() {
            call.resolve([
                "ip": ip
            ])
        } else {
            call.reject("Unable to determine local IP address")
        }
    }
}
