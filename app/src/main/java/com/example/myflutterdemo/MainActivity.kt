package com.example.myflutterdemo

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), Pigeon.ApiToNative {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        FlutterTools.preWarmFlutterEngine(this)

        Pigeon.ApiToNative.setup(
            FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger,
            this
        )


        page_a.setOnClickListener {
            Log.d("this", "点击了")

            val data = Pigeon.SendMsg()
            data.msg = "原生给A传值"

            Pigeon.ApiToFlutter(FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger)
                .toFlutterMsg(data) {

                }

            AndroidFlutterActivity.open(this, FlutterTools.ROUTE_PAGE_A)
        }

        page_b.setOnClickListener {
            Log.d("this", "点击了")

            val data = Pigeon.SendMsg()
            data.msg = "原生给B传值"

            Pigeon.ApiToFlutter(FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger)
                .toFlutterMsg(data) {

                }

            AndroidFlutterActivity.open(this, FlutterTools.ROUTE_PAGE_B)
        }

    }


    override fun onDestroy() {
        super.onDestroy()

        FlutterTools.destroyEngine()
    }

    override fun toHostMsg(arg: Pigeon.CallBackMsg) {

        when (arg.page) {
            "A" -> page_a.text = arg.callback
            "B" -> page_b.text = arg.callback
            else -> throw Error("Not Find Router")
        }

    }
}