package com.postite.mob.view;
import flash.display.Sprite;
class UI{}
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

class State extends Sprite {
	public function new(){
		super();
	}
	
}
	
