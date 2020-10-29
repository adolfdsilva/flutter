package lyhourpay.com.mpwt

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry


class BluetoothService(private val registrar: PluginRegistry.Registrar) : MethodChannel.MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "lyhourpay.com.mpwt")
            val instance = BluetoothService(registrar)
            channel.setMethodCallHandler(instance)
        }
    }

    override fun onMethodCall(call: MethodCall, channel: MethodChannel.Result) {
        when (call.method) {
            "bt_scan" -> {
                channel.success("Printer")
            }
            else -> {
                channel.error("Else", "Error", null)
            }
        }

    }


}