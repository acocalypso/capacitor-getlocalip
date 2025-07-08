package eu.touchnstars.plugins.getlocalip;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.text.format.Formatter;
import android.util.Log;

public class GetLocalIP {

    public String getLocalIP(Context context) {
        try {
            WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
            if (wifiManager != null) {
                WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                int ipAddress = wifiInfo.getIpAddress();
                
                // Convert the IP address to a readable format
                String formattedIpAddress = Formatter.formatIpAddress(ipAddress);
                
                // Check if we got a valid IP address (not 0.0.0.0)
                if (formattedIpAddress != null && !formattedIpAddress.equals("0.0.0.0")) {
                    return formattedIpAddress;
                }
            }
        } catch (Exception ex) {
            Log.e("GetLocalIP", "Error getting local IP", ex);
        }
        return null;
    }
}
