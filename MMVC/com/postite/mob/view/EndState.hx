package com.postite.mob.view;
import flash.display.Sprite;
import flash.events.Event;
import com.postite.mob.view.UI.State;
import com.postite.mob.view.UI;
import msignal.Signal.Signal0;
class EndState extends State implements com.postite.mob.Api.IState{

	public var stateTrigger:Signal0= new Signal0();
	public var valide:Signal0= new Signal0();

	public function new()
	{
		super();
		this.addEventListener(Event.ADDED_TO_STAGE,draw);
	}

	function draw(e:Event)
	{
		this.removeEventListener(Event.ADDED_TO_STAGE,draw);
		this.graphics.beginFill(0x00AAFF);
		this.graphics.drawRect(0,0,stage.stageWidth,stage.stageWidth);
	}
	public function active()
	{
		trace( "active");
		var box= new Box(0x000000);
		box.x=stage.stageWidth/2;
		box.addEventListener(flash.events.MouseEvent.CLICK,onValide);
		this.addChild(box);

		var retour= new Box(0xFF00FF);
		retour.x=stage.stageWidth/2;
		retour.y=stage.stageHeight/2;
		retour.addEventListener(flash.events.MouseEvent.CLICK,onTrig);
		this.addChild(retour);
	}
	function onValide(e)
	{
		valide.dispatch();
	}
	function onTrig(e)
	{
		stateTrigger.dispatch();
	}
}