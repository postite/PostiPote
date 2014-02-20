import flash.display.Sprite;
import flash.events.Event;
import Main.State;
class State1 extends State {

	public function new()
	{
		super();
		
		this.addEventListener(Event.ADDED_TO_STAGE,draw);
	}

	function draw(e:Event)
	{
		this.removeEventListener(Event.ADDED_TO_STAGE,draw);
		this.graphics.beginFill(0xcc3300);
		this.graphics.drawRect(0,0,stage.stageWidth,stage.stageWidth);
	}
}