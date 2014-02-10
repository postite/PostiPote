package;

import openfl.utils.JNI;

import flash.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		trace( "hello");
		var box=this.addChild(new Box());
		box.y=this.stage.stageHeight - box.height;
		box.x=this.stage.stageWidth/2 - box.width/2;
		box.addEventListener(flash.events.MouseEvent.CLICK,
			function(e) { flash.Lib.exit();}
			);
		var z:Dynamic=JNI.createStaticMethod( "pack/Test" , "test_ret_bool" , "()Z" );
		trace( 'jniz='+z());

		var i:Dynamic=JNI.createStaticMethod( "pack/Test" , "sum" , "()I" );
		trace( 'jnii='+i());

			//getting the function from JNI
var filesIntentFunc:Dynamic =
JNI.createStaticMethod("com.example.androidshare/MainApp",
"filesIntent", "(Lorg/haxe/lime/HaxeObject;)V",true);


#if android
flash.Lib.postUICallback( function()
{
	trace( "postUI");
//instance = this in Main.hx
var ar:Array<Dynamic> = [this];
filesIntentFunc(ar);
} );
#end

}

//declaring callback
public function deviceGalleryFileSelectCallback(?i:String) {
 trace( "path="+i);
 var t= new flash.display.Loader();
 t.load(new flash.net.URLRequest(i));

 t.scaleX=t.scaleY=.3;
 this.addChildAt(t,0);

}

	


	
	
}

class Box extends Sprite{
	public function new()
	{
		super();
		draw();
	}
	function draw()
	{
		this.graphics.beginFill(0xcc3300);
		this.graphics.drawRect(0,0,100,100);

	}
}