import flash.events.Event;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.geom.Matrix;
import msignal.Signal;
import flash.display.PixelSnapping;

class Playdoh extends Sprite
{
	public var DONE:Signal1<Bitmap>;
	var boite:Sprite;
	var bitmap:flash.display.Bitmap;
	var preview:Bitmap;
	var mire:Shape;
	var mouseDownref:MouseEvent->Void;
	function new(_bitmap:Bitmap)
	{
		trace( "new Playdoh");
		super();
		DONE= new Signal1();
		
		bitmap=_bitmap;

		//listen
		
		this.addEventListener(Event.ADDED_TO_STAGE,drawUI);
		
	}
	function drawUI(e:Event)
	{
		trace( "ui");
		this.removeEventListener(Event.ADDED_TO_STAGE,drawUI);
		boite= new Sprite();
		trace( this);
		mire= new Shape();
		mire.graphics.lineStyle(1,0xcc3300);
		mire.graphics.drawRect(0,0,400,400);
		mire.x=(stage.stageWidth-mire.width) /2;
		mire.y=(stage.stageHeight-mire.height) /2;
		boite.addChild(mire);
		this.addChild(boite);

		boite.addChildAt(bitmap,0);

		var btn= new Main.Box(0x00ffff);
		this.addChild(btn);
		btn.x=mire.x+mire.width;
		btn.y= mire.y+mire.height;
		btn.addEventListener(MouseEvent.CLICK,finish);

		
		boite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownref=function (e){
			var ref:MouseEvent->Void;
			boite.addEventListener(MouseEvent.MOUSE_MOVE,ref=manipule);
			boite.addEventListener(MouseEvent.MOUSE_UP,function(e)boite.removeEventListener(MouseEvent.MOUSE_MOVE,ref));
			});
		
	}

	///TODO
	function manipule(e:MouseEvent)
	{
		trace( "manipiule");

	bitmap.x=e.stageX-(e.target.width/2);
	bitmap.y=e.stageY-(e.target.height/2);

		
	}



	function finish(e:MouseEvent)
	{
		e.target.removeEventListener(MouseEvent.CLICK,finish);
		

		// bmp= new BitmapData(mire.width,mire.height);
		// var scale:Float = Math.min(bmp.width/bitmap.width, bmp.height/bitmap.height);
		// bmp.draw(bitmap, new Matrix(scale, 0, 0, scale));
		// //var BD= new flash.display.BitmapData(Std.int(bitmap.width),Std.int(bitmap.height));
		// //BD.draw(bitmap);
		// bitmap=null;
		// //e.target.removeEventListener(Event.COMPLETE,manipule);
		
		preview=toCrop();
		//preview.rotation=30;
		//addChild(preview);
		this.DONE.dispatch(preview);
		kill();
	}

	function toCrop():Bitmap {
		//Matrix to holder the area to be cropped
		var maskRect =mire.getBounds(stage);
		trace( maskRect);
		//Matrix of image to be cropped
		var imgMatrix:Matrix= bitmap.transform.matrix;
		imgMatrix.translate(-maskRect.x,-maskRect.y);
		maskRect.x=0;
		maskRect.y=0;
		//Cropped image
		var myCroppedImage:Bitmap = crop(maskRect, imgMatrix, mire.width, mire.height,bitmap );
		return myCroppedImage;
		//addChild( myCroppedImage );
	}

	function crop( rect, matrix, _width:Float, _height:Float, displayObject:DisplayObject):Bitmap {
		//Create cropped image
		var croppedBitmap:Bitmap = new Bitmap( new BitmapData( Std.int(_width), Std.int(_height) ), PixelSnapping.ALWAYS, true );
		croppedBitmap.bitmapData.draw(displayObject, matrix , null, null, rect, true );
		return croppedBitmap;
		}

	function kill()
	{
		DONE= null;
		boite.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownref);
		mire=null;
		boite=null;
		this.parent.removeChild(this);

	}
}