package com.studyroom.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : FlutterActivity() {


    private var mAgoraManager: AgoraManager? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        mAgoraManager = AgoraManager.getInstance(this, flutterEngine)
    }

}
