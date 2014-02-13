package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.*;
import flash.events.MouseEvent;
import flash.net.URLLoader;
import flash.geom.Matrix;
import flash.display.Shape;
import Note;
#if android
import openfl.utils.JNI;
#end
//import openfl.Assets;
import flash.display.Sprite;
import flash.utils.ByteArray;
import Multipart;

class Main extends Sprite {
	
	#if local
	static var serverBase="http://localhost:8888";
	#else
	static var serverBase="http://postite.alwaysdata.net";
	#end
	static var upScript=serverBase+"/up/multi";

	static var note:Note;
	static var bmp:BitmapData;
	static var BA:ByteArray;
	var preview:DisplayObject;

	public function new () {
		
		super ();
		trace( "hello");
		ui();
		

	}

	function ui()
	{
		

		var box=this.addChild(new Box());
		box.y=this.stage.stageHeight - box.height;
		box.x=this.stage.stageWidth/2 - box.width/2;
		box.addEventListener(MouseEvent.CLICK,
			function(e) { 
				#if !flash flash.Lib.exit(); #end}
				);
		
		var browser= this.addChild(new Box(0x00AAFF));
		browser.addEventListener(MouseEvent.CLICK,browse);

		var uploadBtn= this.addChild(new Box(0x000000));
		uploadBtn.addEventListener(MouseEvent.CLICK,upM);
		uploadBtn.x=300;
		
		
	}

	// function testJNI()
	// {
	// 	#if android
	// 	var z:Dynamic=JNI.createStaticMethod( "pack/Test" , "test_ret_bool" , "()Z" );
	// 	trace( 'jniz='+z());

	// 	var i:Dynamic=JNI.createStaticMethod( "pack/Test" , "sum" , "()I" );
	// 	trace( 'jnii='+i());


	// 	#end
	// }

	function browse(e:MouseEvent)
	{
		if(preview!=null) removeChild(preview);
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
		var loader= new Loader();
		// load android image in app
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,manipule);
		loader.load(new flash.net.URLRequest(i));
	}
	
	function capture(bitmap:Bitmap)
	{
		trace( "encode");
		
		// // warning encoding twice BitmapData 
		// bmp= new BitmapData(Std.int(bitmap.width), Std.int(bitmap.height));
		// //var scale:Float = Math.min(bmp.width/bitmap.width, bmp.height/bitmap.height);
		// bmp.draw(bitmap);
		// //var BD= new flash.display.BitmapData(Std.int(bitmap.width),Std.int(bitmap.height));
		// //BD.draw(bitmap);
		// bitmap=null;
		// //e.target.removeEventListener(Event.COMPLETE,manipule);
		
		// preview=new Bitmap(bmp);
		// //preview.addEventListener(Event.ADDED,upM);
		
		//manipule(preview);
		bmp=bitmap.bitmapData;
		
		preview=this.addChild(bitmap);
		bitmap.x=(this.stage.stageWidth-bitmap.width)/2;
		bitmap.y=(this.stage.stageHeight-bitmap.height)/2;
		// benchmark
		haxe.Timer.measure(encodetest);

	}

	inline function encodetest():Void
	{
		var byteArray:ByteArray = new ByteArray();
		//var BA:ByteArray=null;
		#if flash
		BA=bmp.encode(new flash.geom.Rectangle(0,0,bmp.width,bmp.height), new flash.display.JPEGEncoderOptions(100), byteArray);
		#else
		BA=bmp.encode("jpg",.9);
		#end
		
	}

	function manipule(e:Event)
	{
		trace( "manipule");
		var bitmap:Bitmap=e.target.content;
		var playdoh:Playdoh=new Playdoh(bitmap);
		addChildAt(playdoh,0);
		playdoh.DONE.addOnce(capture);
		
		
	}
	// function playDoh(e:MouseEvent)
	// {
	// 	preview.x=e.stageX-(e.target.width/2);
	// 	preview.y=e.stageY-(e.target.height/2);
	// }

	function upM(?e:Event):Void
	{
		note= new Note(this,"uploading",WAIT);
		var MP=new Multipart(upScript);
		
		MP.addField("etaoile","des neiges");
		MP.addFile("file1",BA,"application/octet-stream",'postite_${Date.now()}.jpg');
		
		//move that to Multipart
		var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(Event.OPEN, err);
            loader.addEventListener(ProgressEvent.PROGRESS, err);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, err);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, err);
            loader.addEventListener(IOErrorEvent.IO_ERROR, err);
			
			try {
				loader.load(MP.request);
			} catch (error: Dynamic) {
				trace( "Unable to load requested document : "+error.message);
			}
		trace("request sent");
	}
	
	function err(e:Event)
	{
		trace (e.type);
		switch (e.type){
			case "IO_ERROR": trace("verifier connexion internet");
		}
	}
	 function onComplete (e: Event):Void {
	 	trace("complete");
	 	note.kill();
		trace (untyped e.target.data);
		note=new Note(this,"done",true,INFO);

	}



}

class Box extends Sprite{
	public function new(?color:Int=1)
	{
		super();
		draw(color);
	}
	function draw(c:Int)
	{
		c= (c!=1)? c :0xcc3300;
		this.graphics.beginFill(c);
		this.graphics.drawRect(0,0,100,100);

	}
}