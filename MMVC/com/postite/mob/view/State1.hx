package com.postite.mob.view;
import flash.display.Sprite;
import flash.events.Event;
import com.postite.mob.view.UI.State;
import com.postite.mob.view.UI;
import flash.events.MouseEvent;
import msignal.Signal;
import flash.text.TextField;

class State1 extends State implements com.postite.mob.Api.IState{

	public var stateTrigger:Signal0= new Signal0();
	public var valide:Signal1<String>= new Signal1();
	var text:TextField;
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

		text= new TextField();
		text.background=true;
		text.backgroundColor=0xFFFFFF;
		text.x=stage.stageWidth/2;
		text.y=stage.stageHeight/2;
		text.type=flash.text.TextFieldType.INPUT;
		text.text="type here";
		this.addChild(text);

		var btnText= new Box(0x008888);
		btnText.x=stage.stageWidth/2 +100;
		btnText.y=stage.stageHeight/2;
		addChild(btnText);
		btnText.addEventListener(MouseEvent.CLICK,onTextValide);
	}
	function onTextValide(e)
	{
		valide.dispatch(text.text);
		
	}
	public function active()
	{
		trace( "active");
		var box= new Box(0x000000);
		box.addEventListener(flash.events.MouseEvent.CLICK,onTrig);
		this.addChild(box);
	}
	function onTrig(e)
	{
		stateTrigger.dispatch();
	}
}