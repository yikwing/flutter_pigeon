package com.example.myflutterdemo

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.myflutterdemo.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), Pigeon.ApiToNative {


    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)


        
        FlutterTools.preWarmFlutterEngine(this)

        Pigeon.ApiToNative.setup(
            FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger,
            this
        )


        binding.pageA.setOnClickListener {
            Log.d("this", "点击了")

            val data = Pigeon.SendMsg()
            data.msg = "原生给A传值"

            Pigeon.ApiToFlutter(FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger)
                .toFlutterMsg(data) {}

            AndroidFlutterActivity.open(this, FlutterTools.ROUTE_PAGE_A)
        }

        binding.pageB.setOnClickListener {
            Log.d("this", "点击了")

            val data = Pigeon.SendMsg()
            data.msg = "原生给B传值"

            Pigeon.ApiToFlutter(FlutterTools.getsFlutterEngine().dartExecutor.binaryMessenger)
                .toFlutterMsg(data) {}

            AndroidFlutterActivity.open(this, FlutterTools.ROUTE_PAGE_B)
        }

    }


    override fun onDestroy() {
        super.onDestroy()

        FlutterTools.destroyEngine()
    }

    override fun toHostMsg(arg: Pigeon.CallBackMsg) {

        when (arg.page) {
            "A" -> binding.pageA.text = arg.callback
            "B" -> binding.pageB.text = arg.callback
            else -> throw Error("Not Find Router")
        }

    }
}