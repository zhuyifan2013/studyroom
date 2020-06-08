package com.studyroom.app

import com.amitshekhar.DebugDB
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : FlutterActivity() {


    private var mAgoraManager: AgoraManager? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        mAgoraManager = AgoraManager.getInstance(this, flutterEngine)

        DebugDB.getAddressLog();
    }

}
