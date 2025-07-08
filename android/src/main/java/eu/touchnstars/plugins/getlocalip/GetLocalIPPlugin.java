package eu.touchnstars.plugins.getlocalip;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "GetLocalIP")
public class GetLocalIPPlugin extends Plugin {

    private GetLocalIP implementation = new GetLocalIP();

    @PluginMethod
    public void getLocalIP(PluginCall call) {
        try {
            String ip = implementation.getLocalIP(getContext());
            
            JSObject ret = new JSObject();
            if (ip != null) {
                ret.put("ip", ip);
                call.resolve(ret);
            } else {
                call.reject("Unable to determine local IP address. Make sure you are connected to WiFi.");
            }
        } catch (Exception e) {
            call.reject("Error getting local IP: " + e.getMessage(), e);
        }
    }
}
