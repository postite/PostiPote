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

enum Orientation{
	Horizontal;
	Vertical;
	Square;
}
class Playdoh extends Sprite
{
	public var DONE:Signal1<Bitmap>;
	var boite:Sprite;
	var bitmap:flash.display.Bitmap;
	var preview:Bitmap;
	var mire:Shape;
	var mouseDownref:MouseEvent->Void;
	var rotator:Sprite;
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

		rotator=new Sprite();
		rotator.x= stage.stageWidth/2;
		rotator.y=stage.stageHeight/2;
		boite.addChildAt(rotator,0);
		this.addChild(boite);

		var dragger= new Sprite();
		dragger.graphics.beginFill(0x000000,.2);
		dragger.graphics.drawCircle(0,0,100);
		dragger.x=mire.x+mire.width/2;
		dragger.y=mire.y+mire.height/2;
		boite.addChild(dragger);

		
		bitmap.smoothing = true; //smoothin' FTW !
		rotator.addChild(bitmap);
		bitmap.x= -bitmap.width/2;
		bitmap.y= -bitmap.height/2;
		scaleToStage(bitmap);
		var btn= new Main.Box(0x00ffff);
		this.addChild(btn);
		btn.x=mire.x+mire.width;
		btn.y= mire.y+mire.height;
		btn.addEventListener(MouseEvent.CLICK,finish);

			var refDrag:MouseEvent->Void;
			var ref:MouseEvent->Void;
			var refStage:MouseEvent->Void=null;
		dragger.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownref=function (e){
			
			dragger.addEventListener(MouseEvent.MOUSE_MOVE,ref=manipule);
			stage.addEventListener(MouseEvent.MOUSE_UP,refStage=function(e){
				dragger.removeEventListener(MouseEvent.MOUSE_MOVE,ref);
				if(refStage!=null)stage.removeEventListener(MouseEvent.MOUSE_UP,refStage);
				});
			});
		rotator.addEventListener(MouseEvent.MOUSE_DOWN,refDrag=function(e){
				rotator.startDrag();
				stage.addEventListener(MouseEvent.MOUSE_UP,refStage=function(e){
				rotator.stopDrag();
				if(refStage!=null)stage.removeEventListener(MouseEvent.MOUSE_UP,refStage);
				});
			});
		
	}

	function drag(e:MouseEvent)
	{
		trace("drag" +(stage.stageWidth/2-e.stageX));

		rotator.x+=(stage.stageWidth/2-e.stageX)/(bitmap.width/100);
		rotator.y+=(stage.stageHeight/2-e.stageY)/(bitmap.width/100);

	}
	function scaleToStage(disp:DisplayObject)
	{
		var plus=1.2;
		var sw=stage.stageWidth;
		var sh=stage.stageHeight;
		var bh= disp.height;
		var bw= disp.width;
		var orientation:Orientation = if(bw>bh) Horizontal else Vertical;
		if (bw == bh) orientation=Square;
		var ratio:Float=1.0;
		switch (orientation) {
			case Horizontal :
			ratio = bw/bh;
			if (bw>sw)disp.width=sw* plus;
			disp.height= Std.int(disp.width/ratio);
			case Vertical :
			ratio = bh/bw;
			if (bh>sh)disp.height=sh* plus;
			disp.width= Std.int(disp.height/ratio);
			
			case Square :
			disp.width= disp.height*plus;
		}
		//disp.x=Std.int ((sw-disp.width)/2 );
		//disp.y=Std.int ((sh- disp.height)/2);
		disp.x= -disp.width/2;
		disp.y= -disp.height/2;
		//disp.rotation = 20;
		trace("--------------------"+orientation);
	}

	///TODO
	function manipule(e:MouseEvent)
	{
	



	//bitmap.x=e.stageX-(e.target.width/2);
	//bitmap.y=e.stageY-(e.target.height/2);

	//var distancex = e.stageX-stage.stageWidth/2;
	//var distancey = e.stageY-stage.stageHeight/2;
	var distancex=e.stageX-rotator.x;
	var distancey= e.stageY-rotator.y;
	rotator.rotation=Math.atan2(distancey,distancex)*180/Math.PI;
	var hypothenuse=Math.sqrt(distancex*distancex+distancey*distancey);
	//rotator.scaleX=rotator.scaleY=hypothenuse/100;
	//trace( "manipule" +bitmap.rotation);

		
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
		
		preview=toCrop(rotator);
		//preview.rotation=30;
		//addChild(preview);
		this.DONE.dispatch(preview);
		kill();
	}

	function toCrop(disp:DisplayObject):Bitmap {
		//Matrix to holder the area to be cropped
		var maskRect =mire.getBounds(stage);
		trace( maskRect);
		//Matrix of image to be cropped
		var imgMatrix:Matrix= disp.transform.matrix;
		imgMatrix.translate(-maskRect.x,-maskRect.y);
		maskRect.x=0;
		maskRect.y=0;
		//Cropped image
		var myCroppedImage:Bitmap = crop(maskRect, imgMatrix, mire.width, mire.height,disp );
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