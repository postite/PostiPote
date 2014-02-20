package com.postite.mob.view;
import com.postite.mob.view.UI.Box;
import com.postite.mob.view.State1;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import msignal.Signal;
import flash.display.Loader;
import flash.display.Bitmap;
import flash.utils.ByteArray;
import com.postite.mob.Api;
import com.postite.mob.view.UI.State;
import tweenx909.TweenX;
import tweenx909.EaseX;
class State0 extends State implements IState
{

	public var valide:Signal1<ByteArray>= new Signal1();
	public  var browsing:Signal0=new Signal0();
	public  var sending:Signal0=new Signal0();
	public var BA:ByteArray;
	var bmp:BitmapData;
	var preview:DisplayObject;
	public function new()
	{
		super();	
		trace("new");
		this.addEventListener(Event.ADDED_TO_STAGE,ui);
	}


	public function reset()
	{
		if(preview!=null)removeChild(preview);
		preview=null;
		
	}

	function ui(e)
	{
		this.removeEventListener(Event.ADDED_TO_STAGE,ui);
		var box=this.addChild(new Box());
		box.y=this.stage.stageHeight - box.height;
		box.x=this.stage.stageWidth/2 - box.width/2;
		box.addEventListener(MouseEvent.CLICK,
			function(e) { 
				#if !flash flash.Lib.exit(); #end}
				);
		
		var browser= this.addChild(new Box(0x00AAFF));
		browser.addEventListener(MouseEvent.CLICK,function(e)browsing.dispatch());

		var uploadBtn= this.addChild(new Box(0x000000));
		uploadBtn.addEventListener(MouseEvent.CLICK,function(e)sending.dispatch());
		uploadBtn.x=300;

		// state1= cast this.addChild(new State1());
		// state1.x=stage.stageWidth;
		
		
	}

	public function loadImage(path:String)
	{
		var loader= new Loader();
		// load android image in app
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
		loader.load(new flash.net.URLRequest(path));
	}
	function complete(e:Event)
	{
		trace( "manipule");
		var bitmap:Bitmap=e.target.content;
		var playdoh:Playdoh=new Playdoh(bitmap);
		addChildAt(playdoh,0);
		playdoh.DONE.addOnce(capture);

	}
	
	function capture(bitmap:Bitmap)
	{
		trace( "encode");
		
		bmp=bitmap.bitmapData;
		
		preview=this.addChild(bitmap);
		bitmap.x=(this.stage.stageWidth-bitmap.width)/2;
		bitmap.y=(this.stage.stageHeight-bitmap.height)/2;
		// benchmark
		haxe.Timer.measure(encodetest);
		valide.dispatch(BA);

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
}