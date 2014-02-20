package com.postite.mob.services;

import flash.events.Event;
import flash.display.Loader;
import msignal.Signal;
//JNI stuff
#if android

import openfl.utils.JNI;
#end
class ImageProvider{

public var onPath:Signal1<String> = new msignal.Signal1();
public function new()
{
	
}

public function browse()
	{
		//if(preview!=null) removeChild(preview); //TODo move to view
		trace( "browse");
		#if android
			//getting the function from JNI
			var filesIntentFunc:Dynamic =
			JNI.createStaticMethod("com.example.androidshare/MainApp",
				"filesIntent", "(Lorg/haxe/lime/HaxeObject;)V",true);



			flash.Lib.postUICallback( function()
			{
				trace( "postUI");
				//instance = this in Main.hx
				var ar:Array<Dynamic> = [this];
				filesIntentFunc(ar);
				} );
		#else
		//faking image select in flash
		deviceGalleryFileSelectCallback("../../../Assets/encre.jpg");

		#end
		}


//declaring android callback
	public function deviceGalleryFileSelectCallback(?i:String) {
		trace( "path="+i);
		onPath.dispatch(i);
		
	}

}