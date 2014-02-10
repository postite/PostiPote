package com.example.androidshare;
import org.haxe.lime.HaxeObject;
import android.os.Bundle;
import	android.util.Log;
import android.content.Intent;
public class MainApp extends org.haxe.lime.GameActivity {
public static HaxeObject callback;

public static void main(String[] args) {
// TODO Auto-generated method stub

}
public static void filesIntent(HaxeObject cb){
callback = cb;
Log.e("hip","hep");

 getInstance().startActivityForResult(new
 Intent(getInstance().getContext(),IntentManagerZ.class).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK),1);

}


}