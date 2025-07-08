import Foundation

@objc public class GetLocalIP: NSObject {
    @objc public func getLocalIP() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        // Get list of all interfaces on the local machine
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // Iterate through linked list of interfaces
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                
                // Check interface name - focus on en0 (WiFi interface) first, then fallback to other interfaces
                let name = String(cString: interface.ifa_name)
                
                // Convert interface address to string using safer approach
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                           &hostname, socklen_t(hostname.count),
                           nil, socklen_t(0), NI_NUMERICHOST)
                
                let addressString = String(cString: hostname)
                
                // Check if it's a valid IP address and not loopback
                if !addressString.isEmpty && addressString != "127.0.0.1" && addressString != "0.0.0.0" {
                    
                    // Prioritize en0 (WiFi interface) - return immediately if found
                    if name == "en0" {
                        address = addressString
                        break
                    }
                    
                    // Fallback: store first valid non-loopback address from other interfaces (en1, etc.)
                    if address == nil && name.hasPrefix("en") {
                        address = addressString
                    }
                }
            }
        }
        
        // Free the memory allocated by getifaddrs
        freeifaddrs(ifaddr)
        return address
    }
}
