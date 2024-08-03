package com.example.buyer_app

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.net.Uri
import android.util.Log


class MainActivity: FlutterActivity() {
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("data==>22", "intent");
        if (Intent.ACTION_VIEW == intent.action) {
            val data: Uri? = intent.data
            Log.d("data==>22", data.toString());
            val flutterEngine: FlutterEngine? = flutterEngine
            if (flutterEngine != null) {
                flutterEngine.navigationChannel.pushRoute("done")
            }
        }
    }
    /*override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val action: String? = intent.action
        val data: Uri? = intent.data
        val routeIntent = action == Intent.ACTION_VIEW
        val engine = flutterEngine
        val redirectUrl = "${data?.scheme}://${data?.host}"

        val mollieRedirectUrl = "com.restauranthub.usersapp://payment-redirect"

        if (routeIntent && engine != null && redirectUrl == mollieRedirectUrl) {
            // Pushing a new route when new intent received
            // pops the previous view of the app
            engine.navigationChannel.popRoute()
            // navigate to new route
            engine.navigationChannel.pushRoute("/done")
        }
        redirectToCheckingPaymentResultView(intent.action, intent.data)
    }*/
}
