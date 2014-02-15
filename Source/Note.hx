import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.DisplayObjectContainer;

enum NoteType{
	INFO;
	ERROR;
	WAIT;
}
class Note extends Sprite{

	var box:NoteBox;
	var message:String;
	var type:NoteType;
	var scope:DisplayObjectContainer;
	public function new(_scope:DisplayObjectContainer,_message:String,?autoKill:Bool=false,?_type:NoteType)
	{
		super();
		trace( "new Notification");
		type= (_type==null)? INFO : _type; 
		message=_message;
		scope=_scope;
		draw();

		_scope.addChild(this);
		this.x= (scope.stage.stageWidth-this.width)/2;
		this.y= (scope.stage.stageHeight-this.height)/2;
		if (autoKill){
			haxe.Timer.delay(kill,1000);
				
		}
	}

	function draw()
	{
		var t:TextField= new TextField();
		t.textColor= 0xFFFFFF;
		t.text=message;
		t.autoSize= flash.text.TextFieldAutoSize.LEFT;
		t.setTextFormat(new TextFormat("_sans",24));
		t.x=t.y=20;
		box=new NoteBox(type);
		addChild(box);
		box.x=100;
		box.y=100;
		addChild(t);
	}
	public function kill()
	{
		scope.removeChild(this);
		box.kill();

	}
}

class NoteBox extends Sprite{

	public function new(type:NoteType)
	{

		super();
		var color=switch (type) {
			case INFO: 0x000000;
			case ERROR:0xcc3300;
			case WAIT: 0x00AAFF;
		}
		this.graphics.beginFill(color);
		this.graphics.drawRect(-100,-100,200,200);

		if( type==WAIT)
			this.addEventListener(flash.events.Event.ENTER_FRAME,waiting);

	}
	function waiting(e)
	{
		this.rotation+=3;
		//this.scaleX=Std.random(100)/100;
	}
	public function kill()
	{

		this.removeEventListener(flash.events.Event.ENTER_FRAME,waiting);
	}

}