package com.studyroom.app

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.agora.rtm.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class AgoraManager private constructor(private val context: Context, flutterEngine: FlutterEngine) {

    private val CHANNEL = "studyroom.yifan.com/agora"
    private val TAG_AGORA = "SR_AGORA"
    private val AGORA_APPID = "68bcf9e5dc774482b2f78865e6562426"
    private var mRtmClient: RtmClient? = null
    private var mChannel: MethodChannel

    init {
        mChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        mChannel.setMethodCallHandler { call, result ->
            when {
                call.method == "agoraInit" -> agoraInit()
                call.method == "agoraLogin" -> agoraLogin()
                else -> result.notImplemented()
            }
        }
    }

    companion object {
        @Volatile
        private var instance: AgoraManager? = null

        fun getInstance(context: Context, flutterEngine: FlutterEngine) =
                instance ?: synchronized(this) {
                    instance ?: AgoraManager(context, flutterEngine).also { instance = it }
                }
    }


    private fun agoraInit() {
        Log.i(TAG_AGORA, "agoraInit from android")
        try {
            mRtmClient = RtmClient.createInstance(context, AGORA_APPID,
                    object : RtmClientListener {
                        override fun onTokenExpired() {
                            Log.d(TAG_AGORA, "Token Expired")
                        }

                        override fun onConnectionStateChanged(state: Int, reason: Int) {
                            Log.d(TAG_AGORA, "Connection state changes to $state reason: $reason")
                            sendMsgToFlutter { mChannel.invokeMethod("agoraOnConnectionStateChanged", mapOf("state" to state, "reason" to reason)) }
                        }

                        override fun onMessageReceived(rtmMessage: RtmMessage, peerId: String) {
                            val msg = rtmMessage.text
                            Log.d(TAG_AGORA, "Message received  from $peerId$msg")
                            sendMsgToFlutter { mChannel.invokeMethod("agoraOnMessageReceived", mapOf("message" to rtmMessage.text, "peerId" to peerId)) }
                        }
                    })
        } catch (e: Exception) {
            Log.d(TAG_AGORA, "RTM SDK init fatal error!")
            throw RuntimeException("You need to check the RTM init process.")
        }
    }

    private fun agoraLogin() {
        Log.i(TAG_AGORA, "agoraLogin from android")
        mRtmClient?.login(null, "1", object : ResultCallback<Void> {
            override fun onSuccess(p0: Void?) {
                Log.d(TAG_AGORA, "Login Success")
                sendMsgToFlutter { mChannel.invokeMethod("agoraOnLoginSuccess", null) }
            }

            override fun onFailure(p0: ErrorInfo?) {
                Log.d(TAG_AGORA, "Login Error ${p0?.errorCode} with msg : ${p0?.errorDescription}")
                sendMsgToFlutter { mChannel.invokeMethod("agoraOnLoginError", mapOf("errorCode" to p0?.errorCode, "errorMsg" to p0?.errorDescription)) }
            }

        })
    }

    private fun sendMsgToFlutter(callMethod: () -> Unit) {
        Handler(Looper.getMainLooper()).post {
            callMethod()
        }
    }
}